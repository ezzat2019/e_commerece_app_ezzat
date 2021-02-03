import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  OrderScreen({Key key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text("Orders"),
          ),
          body: Container()),
    );
  }
}
