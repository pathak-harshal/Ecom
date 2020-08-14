import 'package:floor/floor.dart';

@Entity(tableName: 'variant')
class VariantEntity {
  @ColumnInfo(name: 'variant_id')
  @PrimaryKey(autoGenerate: false)
  final int variantId;

  @ColumnInfo(name: 'variant_color', nullable: false)
  final String variantColor;

  @ColumnInfo(name: 'variant_size')
  final int variantSize;

  @ColumnInfo(name: 'variant_price')
  final int variantPrice;

  @ColumnInfo(name: 'product_id')
  final int productId;

  VariantEntity({
    this.variantId,
    this.variantColor,
    this.variantSize,
    this.variantPrice,
    this.productId,
  });
}
