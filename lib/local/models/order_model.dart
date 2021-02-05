import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerece_app_ezzat/local/models/product_model.dart';

class OrderModel {
  String userId;
  List<Product> products;
  double totalPrice;
  Timestamp timestamp;

  OrderModel(this.userId, this.products, this.totalPrice, this.timestamp);

  Map<String, dynamic> orderToMap() {
    List<Map<String, dynamic>> l1 = List();
    products.forEach((element) {
      l1.add($ProductToJson(element));
    });
    Map<String, dynamic> map = Map();
    map["userId"] = userId;

    map["products"] = l1;
    map["totalPrice"] = totalPrice;
    map["timestamp"] = timestamp;

    return map;
  }

  OrderModel.sec(Map<String, dynamic> myMap) {
    List<Product> l1 = List();
    myMap["products"].forEach((element) {
      l1.add($ProductFromJson(element));
    });

    userId = myMap["userId"];
    products = l1;
    totalPrice = myMap["totalPrice"];
    timestamp = myMap["timestamp"];
  }
}
