import 'package:e_commerece_app_ezzat/main.dart';
import 'package:e_commerece_app_ezzat/screens/cart_screen.dart';
import 'package:e_commerece_app_ezzat/screens/manage_store_screen.dart';
import 'package:e_commerece_app_ezzat/screens/store_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StoreDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text(
              "Choose From Store",
              style: GoogleFonts.jaldi(fontWeight: FontWeight.bold),
            ),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            title: Text("Store"),
            leading: Icon(Icons.shop),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          Divider(),
          ListTile(
              title: Text("Orders"),
              leading: Icon(Icons.payment),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CartScreen(),
                ));
              }),
          Divider(),
          ListTile(
              title: Text("Mange Store"),
              leading: Icon(Icons.edit),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ManageStoreScreen(),
                ));
              }),
          Divider(),
          ListTile(
            title: Text("Logout"),
            leading: Icon(Icons.logout),
            onTap: () {
              FirebaseAuth.instance.signOut().then((value) {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => MyApp(),
                ));
              }).catchError((e) => print(e.toString()));
            },
          ),
        ],
      ),
    );
  }
}
