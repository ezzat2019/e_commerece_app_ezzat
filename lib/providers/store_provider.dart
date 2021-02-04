import 'package:e_commerece_app_ezzat/helpers/fake_data.dart';
import 'package:e_commerece_app_ezzat/local/models/product_model.dart';
import 'package:flutter/material.dart';

class StoreProvider with ChangeNotifier {
  var products = FakeData.items;

  void setProdcuts(List<Product> list) {
    products = list;
    notifyListeners();
  }

  void getAllFav() {
    List<Product> l = [];
    products.forEach((element) {
      if (element.is_fav) {
        l.add(element);
      }
    });
    setProdcuts(l);
  }

  void getAll() {
    List<Product> l = FakeData.items;
    setProdcuts(l);
  }
}
