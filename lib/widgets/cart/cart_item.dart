import 'package:e_commerece_app_ezzat/local/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartItem extends StatelessWidget {
  final Product product;
  final int pos;

  CartItem(this.product, this.pos);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        product.title,
        style: GoogleFonts.lato(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      leading: CircleAvatar(
        child: Text(
          "\$${product.price.toStringAsFixed(2)}",
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        radius: 30,
      ),
      trailing: Text("${pos + 1} x"),
      tileColor: Colors.white,
      subtitle: Text(
        product.description,
        maxLines: 2,
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
