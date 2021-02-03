import 'package:floor/floor.dart';

@Entity(tableName: "cart_product")
class Product {
  @PrimaryKey()
  @ColumnInfo(nullable: false, name: "id")
  final String id;
  @ColumnInfo(name: "title")
  final String title;
  @ColumnInfo(name: "description")
  final String description;
  @ColumnInfo(name: "price")
  final double price;
  @ColumnInfo(name: "imageUrl")
  final String imageUrl;

  Product({this.id, this.title, this.description, this.price, this.imageUrl});
}
