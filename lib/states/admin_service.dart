import 'package:flutter/material.dart';

class AdminService extends StatefulWidget {
  const AdminService({ Key? key }) : super(key: key);

  @override
  _AdminServiceState createState() => _AdminServiceState();
}

class _AdminServiceState extends State<AdminService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Text('Admin Service'),
      ),
    );
  }
}