import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ungpos/models/user_model.dart';
import 'package:ungpos/utility/my_constant.dart';
import 'package:ungpos/utility/my_dialog.dart';
import 'package:ungpos/widgets/show_image.dart';
import 'package:ungpos/widgets/show_title.dart';

class Authen extends StatefulWidget {
  const Authen({Key? key}) : super(key: key);

  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) => GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          behavior: HitTestBehavior.opaque,
          child: Row(
            children: [
              leftLayout(constraints),
              rightLayout(constraints),
            ],
          ),
        ),
      ),
    );
  }

  Container rightLayout(BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth * 0.5,
      child: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShowTitle(
                    title: MyConstant.appName,
                    textStyle: MyConstant().h1Style()),
                buildUser(constraints),
                buildPassword(constraints),
                buildLogin(constraints),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildLogin(BoxConstraints constraints) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: constraints.maxWidth * 0.3,
      child: ElevatedButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            checkLogin();
          }
        },
        child: Text('Login'),
        style: MyConstant().myButtonStyle(),
      ),
    );
  }

  Future<Null> checkLogin() async {
    String user = userController.text;
    String password = passwordController.text;
    // print('user = $user, password = $password');
    String apiCheckLogin =
        'https://www.androidthai.in.th/bigc/getUserWhereUser.php?isAdd=true&user=$user';
    await Dio().get(apiCheckLogin).then((value) {
      // print('valut from API ==> $value');
      if (value.toString() == 'null') {
        // print('User False');
        MyDialog()
            .normalDialog(context, 'User False !!!', 'NO $user in my Database');
      } else {
        var result = json.decode(value.data);
        // print('result ==>> $result');
        for (var item in result) {
          // print('item ==>> $item');
          UserModel model = UserModel.fromMap(item);
          if (password == model.password) {
            switch (model.type) {
              case 'officer':
                Navigator.pushNamedAndRemoveUntil(
                    context, MyConstant.routeOfficer, (route) => false);
                break;
                case 'admin':
                Navigator.pushNamedAndRemoveUntil(
                    context, MyConstant.routeAdmin, (route) => false);
                break;
              default:
            }
          } else {
            MyDialog().normalDialog(context, 'Password False !!!',
                'Password False Please Try Again');
          }
        }
      }
    });
  }

  Container buildUser(BoxConstraints constraints) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: constraints.maxWidth * 0.3,
      child: TextFormField(
        controller: userController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please Fill User in Blank';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'User :',
          prefixIcon: Icon(Icons.perm_identity),
        ),
      ),
    );
  }

  Container buildPassword(BoxConstraints constraints) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: constraints.maxWidth * 0.3,
      child: TextFormField(
        controller: passwordController,
        obscureText: true,
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณากรอก Password ด้วย คะ';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Password :',
          prefixIcon: Icon(Icons.lock_outline),
        ),
      ),
    );
  }

  Container leftLayout(BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth * 0.5,
      child: Center(
        child: Container(
          width: constraints.maxWidth * 0.4,
          child: ShowImage(pathImage: MyConstant.image1),
        ),
      ),
    );
  }
}
