import 'package:Ecom/database/entities/products_ranking_entity.dart';
import 'package:floor/floor.dart';

@dao
abstract class ProductsRankingDao {
  @Query('SELECT * FROM products_ranking')
  Stream<List<ProductsRankingEntity>> findAllProductRankings();

  @Query('SELECT * FROM products_ranking')
  Future<List<ProductsRankingEntity>> findAllProductRankingList();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertProductRankings(List<ProductsRankingEntity> productsRanking );
}