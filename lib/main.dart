import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ungpos/states/admin_service.dart';
import 'package:ungpos/states/authen.dart';
import 'package:ungpos/states/officer_service.dart';
import 'package:ungpos/states/show_cart.dart';
import 'package:ungpos/utility/my_constant.dart';

final Map<String, WidgetBuilder> map = {
  '/authen': (BuildContext context) => Authen(),
  '/officerService': (BuildContext context) => OfficerService(),
  '/adminService': (BuildContext context) => AdminService(),
  '/showCart': (BuildContext context) => ShowCart(),
};

String? firstState;

void main() {
  firstState = MyConstant.routeAuthen;
  print('### firstState ==> $firstState');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    return MaterialApp(
      title: MyConstant.appName,
      routes: map,
      initialRoute: firstState,
    );
  }
}
