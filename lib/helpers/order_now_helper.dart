import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerece_app_ezzat/local/models/order_model.dart';
import 'package:e_commerece_app_ezzat/local/models/product_model.dart';

class OrderNowHelper {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference orders = FirebaseFirestore.instance.collection('orders');

  Future<DocumentReference> addOrders(
      String user_id, List<Product> list, double total, Timestamp timestamp) {
    OrderModel orderModel = OrderModel(user_id, list, total, timestamp);

    return orders.add(orderModel.orderToMap());
  }

  Future<void> deleteOrder(String id) {
    return orders.doc(id).delete();
  }

  Future<QuerySnapshot> getAllOrder() {
    return orders.get();
  }
}
