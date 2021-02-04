import 'package:e_commerece_app_ezzat/local/base/main_data_base.dart';
import 'package:e_commerece_app_ezzat/local/dao/store_dao.dart';
import 'package:e_commerece_app_ezzat/local/models/product_model.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  MainDataBase mainDataBase;
  StoreDao storeDao;
  List<Product> listProduct = [];
  double total_price = 0.0;

  void setTotalPrice(double total_price) {
    this.total_price = total_price;
    notifyListeners();
  }

  void setProductList(List<Product> listProduct) {
    this.listProduct = listProduct;
    notifyListeners();
  }

  Future<void> initlDataBase() async {
    mainDataBase =
        await $FloorMainDataBase.databaseBuilder('app_database3.db').build();
    storeDao = mainDataBase.storeDao;
  }

  Future<int> addNewProductToCart(Product product) async {
    await initlDataBase();
    return storeDao.addItemtoCart(product);
  }

  Future<List<Product>> getAllCarItem() async {
    await initlDataBase();
    return storeDao.getAllCarItem();
  }

  Future<Product> getCartItemById(String id) async {
    await initlDataBase();
    return storeDao.getCartItemById(id);
  }

  Future<int> reoveCartItemById(Product product) async {
    await initlDataBase();
    return storeDao.reoveCartItemById(product);
  }
}
