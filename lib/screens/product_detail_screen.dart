import 'package:e_commerece_app_ezzat/local/models/product_model.dart';
import 'package:e_commerece_app_ezzat/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  ProductDetailScreen(this.product);

  @override
  Widget build(BuildContext context) {
    final myProviderCart = Provider.of<CartProvider>(context, listen: false);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.purple.shade100,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: height * .50,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  product.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                background: Hero(
                  tag: product.id,
                  child: FadeInImage(
                    placeholder:
                        AssetImage("assets/images/product-placeholder.png"),
                    image: NetworkImage(product.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              Card(
                color: Colors.white,
                elevation: 3,
                margin: EdgeInsets.all(20),
                shadowColor: Colors.purpleAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Text(
                        "Description :",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 32, right: 32),
                      child: Text(product.description,
                          style: TextStyle(fontSize: 18)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      child: Divider(
                        thickness: 2,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Text(
                        "Price :",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 32, right: 32),
                      child: Text("\$${product.price}",
                          style: TextStyle(color: Colors.purple, fontSize: 18)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      child: Divider(
                        thickness: 2,
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                color: Colors.white,
                elevation: 3,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 30),
                shadowColor: Colors.purpleAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 8,
                        child: RaisedButton(
                          onPressed: () {
                            if (myProviderCart.listProduct
                                .any((element) => element.id == product.id)) {
                              Toast.show(
                                  "This item already exsit at your cart ",
                                  context,
                                  duration: Toast.LENGTH_LONG);
                            } else {
                              myProviderCart
                                  .addNewProductToCart(product)
                                  .then((value) {
                                print(value);
                                Toast.show(
                                    "the product added  to cart", context);
                              }).catchError(
                                      (e) => Toast.show(e.toString(), context));
                            }
                          },
                          child: Text(
                            "Add To My Cart",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          color: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                            width: 30,
                            height: 30,
                            child: Icon(
                              product.is_fav
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Theme.of(context).primaryColor,
                              size: 35,
                            )),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: width * .85,
              )
            ]))
          ],
        ),
      ),
    );
  }
}
