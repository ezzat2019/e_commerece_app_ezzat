import 'package:e_commerece_app_ezzat/helpers/order_now_helper.dart';
import 'package:e_commerece_app_ezzat/local/models/order_model.dart';
import 'package:e_commerece_app_ezzat/providers/manage_store_provider.dart';
import 'package:e_commerece_app_ezzat/widgets/cart/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class ManageItem extends StatelessWidget {
  final OrderModel orderModel;
  int index;

  ManageItem(this.orderModel, this.index, this.id);

  OrderNowHelper helper = OrderNowHelper();
  String id;

  @override
  Widget build(BuildContext context) {
    final myManageStoreProvider =
        Provider.of<ManageStoreProvider>(context, listen: false);
    return Card(
      elevation: 7,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      shadowColor: Colors.purpleAccent,
      margin: EdgeInsets.all(22),
      color: Colors.white,
      child: Container(
        height: 350,
        child: Column(
          children: [
            SizedBox(
              height: 8,
            ),
            Text(
              "Order ",
              style: GoogleFonts.aBeeZee(
                  fontSize: 30, color: Theme.of(context).primaryColor),
            ),
            SizedBox(
              height: 4,
            ),
            Text("Products Of Order"),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: CartItem(orderModel.products[index], index),
                  );
                },
                itemCount: orderModel.products.length,
              ),
            ),
            RaisedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return SpinKitRotatingCircle(
                      color: Theme.of(context).primaryColor,
                      size: 50.0,
                    );
                  },
                );
                helper.deleteOrder(id).then((value) {
                  myManageStoreProvider.removeItem(index);
                  Navigator.of(context).pop();
                  Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text("The Order is canceled")));
                }).catchError((e) => Toast.show(e.toString(), context,
                    duration: Toast.LENGTH_LONG));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  "CANCEL ORDER",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              color: Colors.purple,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}
