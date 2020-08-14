import 'package:floor/floor.dart';

@Entity(
  tableName: 'products_ranking',
  primaryKeys: ['ranking_text', 'product_id'],
)
class ProductsRankingEntity {
  

  @ColumnInfo(name: 'ranking_text')
  final String rankingText;

  @ColumnInfo(name: 'product_id')
  final int productId;

  @ColumnInfo(name: 'total_count')
  final int totalCount;

  ProductsRankingEntity({
    this.rankingText,
    this.productId,
    this.totalCount,
  });
}
