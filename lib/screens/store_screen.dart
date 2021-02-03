import 'package:e_commerece_app_ezzat/providers/store_provider.dart';
import 'package:e_commerece_app_ezzat/widgets/store/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'file:///C:/Users/Dell/AndroidStudioProjects/e_commerece_app_ezzat/lib/widgets/store/store_drawer.dart';

class StoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final myProviderLive = Provider.of<StoreProvider>(context);
    final myProvider = Provider.of<StoreProvider>(context, listen: false);
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
                  onPressed: () {},
                ),
                Positioned(
                    right: 1,
                    top: 2,
                    child: CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 10,
                      child: Center(
                        child: Text(
                          "0",
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
            itemCount: myProviderLive.products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 4.9 / 4),
            itemBuilder: (context, index) {
              return ProductItem(myProvider.products[index]);
            }),
        drawer: StoreDrawer(),
      ),
    );
  }
}
