import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:woo_store/services/utils.dart';
import 'package:woo_store/widgets/text_widget.dart';
import 'package:woo_store/woocommerce/models/category_model.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils(context).getSizeScreen();
    final categoryModel = Provider.of<CategoryModel>(context);
    return InkWell(
      onTap: () {
        // Navigator.pushNamed(context, CategoryScreen.routeName,
        //     arguments: catText);
      },
      child: Container(
        // height: _screenWidth * 0.6,
        decoration: BoxDecoration(
          color: Colors.pinkAccent.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.pinkAccent.withOpacity(0.7),
            width: 2,
          ),
        ),
        child: Column(children: [
          // Container for the image
          Container(
            height: screenSize.width * 0.3,
            width: screenSize.width * 0.3,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  categoryModel.image == null
                      ? 'https://bitfun.mx/wp-content/uploads/2022/06/cropped-logo3_color.png'
                      : categoryModel.image!.url,
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
          // Category name
          TextWidget(
            text: categoryModel.categoryName,
            color: Colors.black,
            textSize: 20,
            isTitle: true,
          ),
        ]),
      ),
    );
  }
}
