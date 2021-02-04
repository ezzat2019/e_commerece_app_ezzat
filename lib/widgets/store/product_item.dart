import 'package:e_commerece_app_ezzat/local/models/product_model.dart';
import 'package:e_commerece_app_ezzat/providers/cart_provider.dart';
import 'package:e_commerece_app_ezzat/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class ProductItem extends StatelessWidget {
  final Product productItem;

  ProductItem(this.productItem);

  @override
  Widget build(BuildContext context) {
    final myProviderCart = Provider.of<CartProvider>(context, listen: false);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Card(
      elevation: 7,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      shadowColor: Colors.purpleAccent,
      margin: EdgeInsets.all(7),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return ProductDetailScreen(productItem);
              },
            ));
          },
          child: Stack(
            children: [
              Hero(
                tag: productItem.id,
                child: FadeInImage(
                    width: double.infinity,
                    placeholder:
                        AssetImage("assets/images/product-placeholder.png"),
                    image: NetworkImage(
                      productItem.imageUrl,
                    ),
                    fit: BoxFit.cover),
              ),
              Positioned(
                child: Container(
                  color: Colors.black54,
                  height: 60,
                  width: width,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 25,
                      ),
                      Icon(
                        productItem.is_fav
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text("${productItem.title.substring(0, 5)}",
                          style: TextStyle(color: Colors.white),
                          overflow: TextOverflow.ellipsis),
                      SizedBox(
                        width: 30,
                      ),
                      IconButton(
                        icon: Icon(Icons.shopping_cart),
                        color: Colors.lightGreenAccent,
                        splashColor: Colors.green,
                        onPressed: () {
                          if (myProviderCart.listProduct
                              .any((element) => element.id == productItem.id)) {
                            Toast.show("This item already exsit at your cart ",
                                context,
                                duration: Toast.LENGTH_LONG);
                          } else {
                            myProviderCart
                                .addNewProductToCart(productItem)
                                .then((value) {
                              print(value);
                              Toast.show("the product added  to cart", context);
                            }).catchError(
                                    (e) => Toast.show(e.toString(), context));
                          }
                        },
                      ),
                    ],
                  ),
                ),
                bottom: 0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
