import 'package:e_commerece_app_ezzat/helpers/order_now_helper.dart';
import 'package:e_commerece_app_ezzat/local/models/order_model.dart';
import 'package:e_commerece_app_ezzat/providers/manage_store_provider.dart';
import 'package:e_commerece_app_ezzat/widgets/mangage_store/manage_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class ManageStoreScreen extends StatelessWidget {
  final OrderNowHelper orderNowHelper = OrderNowHelper();
  List<OrderModel> list = List();
  bool check = true;
  List<String> ids = List();

  @override
  Widget build(BuildContext context) {
    final myManageStoreProviderLive = Provider.of<ManageStoreProvider>(context);
    final myManageStoreProvider =
        Provider.of<ManageStoreProvider>(context, listen: false);
    final GlobalKey<AnimatedListState> _listKey = GlobalKey();
    if (check) {
      orderNowHelper.getAllOrder().then((value) {
        value.docs.forEach((element) {
          if (element.data()["userId"] ==
              FirebaseAuth.instance.currentUser.uid) {
            OrderModel orderModel = OrderModel.sec(element.data());
            ids.add(element.id);
            list.add(orderModel);
            myManageStoreProvider.setOrderList(list);
            print(myManageStoreProvider.list.length);
          }
          check = false;
        });
      });
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.purple.shade100,
        appBar: AppBar(
          title: Text("Manage Store"),
        ),
        body: list.isEmpty
            ? Center(
                child: SpinKitCubeGrid(
                  color: Theme.of(context).primaryColor,
                  size: 50.0,
                ),
              )
            : ListView.builder(
                key: _listKey,
                itemBuilder: (context, index) {
                  return ManageItem(list[index], index, ids[index]);
                },
                itemCount: list.length,
              ),
      ),
    );
  }
}
