import 'package:flutter/material.dart';
import 'package:ungpos/utility/my_constant.dart';
import 'package:ungpos/widgets/show_image.dart';
import 'package:ungpos/widgets/show_title.dart';

class MyDialog {
  Future<Null> normalDialog(
      BuildContext context, String title, String message) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: ShowImage(pathImage: MyConstant.image2),
          title: ShowTitle(
            title: title,
            textStyle: MyConstant().h2Style(),
          ),
          subtitle: ShowTitle(
            title: message,
            textStyle: MyConstant().h3Style(),
          ),
        ),actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text('OK'))],
      ),
    );
  }
}
