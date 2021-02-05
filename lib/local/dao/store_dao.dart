import 'package:e_commerece_app_ezzat/local/models/product_model.dart';
import 'package:floor/floor.dart';

@dao
abstract class StoreDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> addItemtoCart(Product product);

  @Query("select * from cart_product")
  Future<List<Product>> getAllCarItem();

  @Query("select * from cart_product where cart_product.id=:id")
  Future<Product> getCartItemById(String id);

  @delete
  Future<int> reoveCartItemById(Product product);

  @Query('DELETE FROM cart_product')
  Future<void> deleteAllCart();
}
