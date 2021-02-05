import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@Entity(tableName: "cart_product")
@JsonSerializable()
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
  @ColumnInfo(name: "is_fav")
  final bool is_fav;
  @ColumnInfo(name: "user_id")
  final String user_id;

  Product(
      {this.id,
      this.title,
      this.description,
      this.price,
      this.imageUrl,
      this.is_fav,
      this.user_id});
}
