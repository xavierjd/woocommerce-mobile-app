import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:woo_store/widgets/text_widget.dart';

class ExpandTextWidget extends StatefulWidget {
  const ExpandTextWidget({
    super.key,
    required this.labelHeader,
    required this.desc,
    required this.shortDesc,
  });

  final String labelHeader, desc, shortDesc;

  @override
  State<ExpandTextWidget> createState() => _ExpandTextWidgetState();
}

class _ExpandTextWidgetState extends State<ExpandTextWidget> {
  bool descTextShowFlag = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            text: widget.labelHeader,
            color: Colors.black,
            textSize: 18,
            isTitle: true,
          ),
          Html(
            data: descTextShowFlag ? widget.desc : widget.shortDesc,
            style: {
              'div': Style(
                  padding: const EdgeInsets.only(
                    top: 5,
                    bottom: 5,
                  ),
                  fontSize: FontSize.medium)
            },
          ),
          Align(
            child: GestureDetector(
              child: TextWidget(
                text: descTextShowFlag ? 'Show Less' : 'Show More',
                color: Colors.blue,
                textSize: 18,
              ),
              onTap: () {
                setState(() {
                  descTextShowFlag = !descTextShowFlag;
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
