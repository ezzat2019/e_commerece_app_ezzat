import 'package:e_commerece_app_ezzat/helpers/fake_data.dart';
import 'package:flutter/material.dart';

class StoreProvider with ChangeNotifier {
  final products = FakeData.items;
}
