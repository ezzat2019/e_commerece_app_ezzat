import 'package:e_commerece_app_ezzat/providers/cart_provider.dart';
import 'package:e_commerece_app_ezzat/providers/store_provider.dart';
import 'package:e_commerece_app_ezzat/screens/cart_screen.dart';
import 'package:e_commerece_app_ezzat/widgets/store/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import 'file:///C:/Users/Dell/AndroidStudioProjects/e_commerece_app_ezzat/lib/widgets/store/store_drawer.dart';

class StoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final myProviderStoreLive = Provider.of<StoreProvider>(context);
    final myProviderStore = Provider.of<StoreProvider>(context, listen: false);

    final myProviderCartLive = Provider.of<CartProvider>(context);
    final myProviderCart = Provider.of<CartProvider>(context, listen: false);

    myProviderCart.getAllCarItem().then((value) {
      myProviderCart.setProductList(value);
    }).catchError((e) => Toast.show(e.toString(), context));

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.purple.shade100,
        appBar: AppBar(
          title: Text("Store"),
          actions: [
            Stack(
              children: [
                IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return CartScreen();
                      },
                    ));
                  },
                ),
                Positioned(
                    right: 1,
                    top: 2,
                    child: CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 10,
                      child: Center(
                        child: Text(
                          "${myProviderCartLive.listProduct.length}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ))
              ],
            ),
            PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: Text("Only Favourie"),
                  value: "fav",
                ),
                PopupMenuItem(
                  child: Text("Show All"),
                  value: "all",
                ),
              ],
              onSelected: (value) {
                print(value);
              },
            )
          ],
        ),
        body: GridView.builder(
            itemCount: myProviderStoreLive.products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 4.9 / 4),
            itemBuilder: (context, index) {
              return ProductItem(myProviderStore.products[index]);
            }),
        drawer: StoreDrawer(),
      ),
    );
  }
}
