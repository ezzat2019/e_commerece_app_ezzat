import 'package:e_commerece_app_ezzat/local/models/order_model.dart';
import 'package:flutter/cupertino.dart';

class ManageStoreProvider with ChangeNotifier {
  List<OrderModel> list = List();

  void setOrderList(List<OrderModel> list) {
    this.list = list;
    notifyListeners();
  }

  void removeItem(int index) {
    list.removeAt(index);

    notifyListeners();
  }
}
