import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woo_store/widgets/appbar_widget.dart';
import 'package:woo_store/widgets/product_card_widget.dart';

import 'package:woo_store/woocommerce/models/product_model.dart';
import 'package:woo_store/woocommerce/provider/product_provider.dart';

class ProductListScreen extends StatefulWidget {
  static const routeName = "/ProductListScreen";
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  int _page = 1;

  late ScrollController _scrollController;

  late TextEditingController _searchQuery;

  Timer? _debounce;

  final _sortByOptions = [
    SortBy(value: 'popularity', text: 'Popularity', sortOder: 'asc'),
    SortBy(value: 'modified', text: 'Latest', sortOder: 'asc'),
    SortBy(value: 'price', text: 'Price: High to Low', sortOder: 'desc'),
    SortBy(value: 'price', text: 'Price: Low to High', sortOder: 'asc'),
  ];

  @override
  void initState() {
    super.initState();
    _searchQuery = TextEditingController();
    _scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final productList = Provider.of<ProductProvider>(context, listen: false);
      productList.clearProductList();
      productList.setLoadingState(LoadMoreStatus.initial);
      productList.fetchProducts(pageNumber: _page);
    });

    _scrollController.addListener(_onMaxScroll);

    _searchQuery.addListener(_onSearchChange);
  }

  _onMaxScroll() {
    final productList = Provider.of<ProductProvider>(context, listen: false);
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      productList.setLoadingState(LoadMoreStatus.loading);
      productList.fetchProducts(pageNumber: ++_page);
    }
  }

  _onSearchChange() {
    final productList = Provider.of<ProductProvider>(context, listen: false);
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(
      const Duration(milliseconds: 1000),
      () {
        productList.clearProductList();
        productList.setLoadingState(LoadMoreStatus.initial);
        productList.fetchProducts(
            pageNumber: _page, strSearch: _searchQuery.text);
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _searchQuery.removeListener(_onSearchChange);
    _searchQuery.dispose();
    _scrollController.dispose();
    _debounce?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final categoryId = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      appBar: const AppBarWidget(
        title: 'products',
        backgroundColor: Colors.pinkAccent,
      ),
      body: Column(children: [
        _productFilters(),
        Expanded(
          child: _productsList(),
        ),
      ]),
    );
  }

  Widget _productsList() {
    return Consumer<ProductProvider>(
      builder: (context, model, child) {
        if (model.allProducts.isNotEmpty &&
            model.getLoadMoreStatus() != LoadMoreStatus.initial) {
          return _buildList(model.allProducts,
              model.getLoadMoreStatus() == LoadMoreStatus.loading);
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _buildList(List<ProductModel>? items, bool isLoading) {
    return Column(
      children: [
        Flexible(
          child: GridView.count(
            shrinkWrap: true,
            controller: _scrollController,
            crossAxisCount: 2,
            physics: const ClampingScrollPhysics(),
            scrollDirection: Axis.vertical,
            children: List.generate(
              items!.length,
              (index) {
                return ChangeNotifierProvider.value(
                  value: items[index],
                  child: const ProductCardWidget(),
                );
              },
            ),
          ),
        ),
        Visibility(
          visible: isLoading,
          child: Container(
            padding: const EdgeInsets.all(5),
            height: 35.0,
            width: 35.0,
            child: const CircularProgressIndicator(),
          ),
        ),
      ],
    );
  }

  Widget _productFilters() {
    return Container(
      height: 51,
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              controller: _searchQuery,
              // onEditingComplete: () {
              //   final productList =
              //       Provider.of<ProductProvider>(context, listen: false);
              //   productList.clearProductList();
              //   productList.setLoadingState(LoadMoreStatus.initial);
              //   productList.fetchProducts(
              //       pageNumber: _page, strSearch: _searchQuery.text);
              // },
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none),
                fillColor: const Color(0xffe6e6ec),
                filled: true,
                // suffix: IconButton(
                //   onPressed: () {
                //     _searchQuery.clear();
                //     //_searchTextFocusNode.unfocus();
                //   },
                //   icon: const Icon(
                //     Icons.close,
                //     color: Colors.red,
                //     //_searchTextFocusNode.hasFocus ? Colors.red : Colors.grey,
                //   ),
                // ),
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xffe6e6ec),
              borderRadius: BorderRadius.circular(9.0),
            ),
            child: PopupMenuButton(
              onSelected: (sortBy) {
                var productList =
                    Provider.of<ProductProvider>(context, listen: false);
                productList.clearProductList();
                productList.setSortOrder(sortBy);
                productList.fetchProducts(
                  pageNumber: _page,
                );
              },
              itemBuilder: (BuildContext context) {
                return _sortByOptions.map(
                  (item) {
                    return PopupMenuItem(
                      value: item,
                      child: Text(item.text),
                    );
                  },
                ).toList();
              },
              icon: const Icon(Icons.tune),
            ),
          ),
        ],
      ),
    );
  }
}
