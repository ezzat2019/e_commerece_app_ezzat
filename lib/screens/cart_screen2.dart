import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerece_app_ezzat/helpers/order_now_helper.dart';
import 'package:e_commerece_app_ezzat/local/models/product_model.dart';
import 'package:e_commerece_app_ezzat/providers/cart_provider.dart';
import 'package:e_commerece_app_ezzat/widgets/cart/cart_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Product> myList;
  final GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();
  bool copmute = true;
  OrderNowHelper orderNowHelper = OrderNowHelper();

  @override
  Widget build(BuildContext context) {
    final myProviderCartLive = Provider.of<CartProvider>(context);
    final myProviderCart = Provider.of<CartProvider>(context, listen: false);
    // myProviderCart.getAllCarItem().then((value) {
    //   myProviderCart.setProductList(value);
    // }).catchError((e) => Toast.show(e.toString(), context));
    final weidth = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    myList = myProviderCart.listProduct;
    double total_price = 0.0;
    if (copmute) {
      myList.forEach((element) {
        total_price += element.price;
        myProviderCart.setTotalPrice(total_price);
        setState(() {});
      });
      copmute = false;
    }
    BuildContext vv;

    return SafeArea(
        child: Scaffold(
      key: globalKey,
      backgroundColor: Colors.purple.shade100,
      appBar: AppBar(title: Text("Your Cart")),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(16),
            child: Container(
              height: 80,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 16,
                  ),
                  Text(
                    "Total",
                    style: GoogleFonts.lato(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: weidth * .14),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        color: Theme.of(context).primaryColor,
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                        child: Text(
                          myList.length == 0
                              ? "\$00.00"
                              : "\$${myProviderCartLive.total_price.toStringAsFixed(2)}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              backgroundColor: Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                  ),
                  FlatButton(
                      onPressed: () {
                        showDialog(
                          context: globalKey.currentState.context,
                          builder: (context2) {
                            vv = context2;
                            return SpinKitRotatingCircle(
                              color: Theme.of(globalKey.currentState.context)
                                  .accentColor,
                              size: 50.0,
                            );
                          },
                        );

                        orderNowHelper
                            .addOrders(
                                FirebaseAuth.instance.currentUser.uid,
                                myList,
                                myProviderCart.total_price,
                                Timestamp.now())
                            .then((value) {
                          myProviderCart.removeAll().catchError((e) {
                            if (vv != null) {
                              Navigator.of(vv).pop();
                              Toast.show(e.toString(), context,
                                  duration: Toast.LENGTH_LONG);
                            }

                            // setState(() {
                            //
                            // });
                          }).then((value) {
                            if (vv != null) {
                              Navigator.of(vv).pop();
                              Toast.show("successed", context,
                                  duration: Toast.LENGTH_LONG);
                            }

                            // setState(() {
                            //
                            // });
                          });
                        }).catchError((e) => Toast.show(e.toString(), context,
                                duration: Toast.LENGTH_LONG));
                      },
                      child: Text(
                        "Order Now",
                        style: GoogleFonts.abel(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor),
                      ))
                ],
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Dismissible(
                  direction: DismissDirection.endToStart,
                  key: ValueKey(myList[index].id),
                  confirmDismiss: (direction) {
                    if (direction == DismissDirection.endToStart) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Are you sure ?"),
                            content:
                                Text("Do you want delete Item from the cart?"),
                            actions: [
                              FlatButton(
                                  onPressed: () {
                                    myProviderCart
                                        .reoveCartItemById(myList[index])
                                        .then((value) {
                                      total_price = 0.0;
                                      myProviderCart
                                          .getAllCarItem()
                                          .then((value) {
                                        myList = value;
                                        myProviderCart.setProductList(myList);

                                        setState(() {
                                          copmute = true;
                                          Navigator.of(context).pop();
                                        });
                                      });
                                      print(" delted  $value");
                                    }).catchError((e) => Toast.show(
                                            e.toString(), context,
                                            duration: Toast.LENGTH_LONG));
                                  },
                                  child: Text("Yes")),
                              FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("No")),
                            ],
                          );
                        },
                      );
                    }
                  },
                  background: Container(
                    margin: EdgeInsets.all(8),
                    color: Colors.red,
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                  child: Card(
                    margin: EdgeInsets.all(8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      child: CartItem(myList[index], index),
                    ),
                  ),
                );
              },
              itemCount: myList.length,
            ),
          )
        ],
      ),
    ));
  }
}
