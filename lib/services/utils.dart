import 'package:flutter/material.dart';

class Utils {
  BuildContext context;
  Utils(this.context);
  Size getSizeScreen() => MediaQuery.of(context).size;
}
