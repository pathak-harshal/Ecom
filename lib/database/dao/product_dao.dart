import 'package:Ecom/database/entities/product_entity.dart';
import 'package:floor/floor.dart';

@dao
abstract class ProductDao {
  @Query('SELECT * FROM product')
  Stream<List<ProductEntity>> findAllProducts();

  @Query('SELECT * FROM product')
  Future<List<ProductEntity>> findAllProductList();

  @Query('SELECT * FROM product WHERE category_id = :id')
  Stream<List<ProductEntity>> findProductsWithCategory(int categoryId);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertProducts(List<ProductEntity> products);
}