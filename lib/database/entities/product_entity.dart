import 'package:floor/floor.dart';

@Entity(tableName: 'product')
class ProductEntity {
  @ColumnInfo(name: 'product_id')
  @PrimaryKey(autoGenerate: false)
  final int productId;

  @ColumnInfo(name: 'product_name')
  final String productName;

  @ColumnInfo(name: 'product_date_added')
  final String productDateAdded;

  @ColumnInfo(name: 'category_id')
  final int categoryId;

  @ColumnInfo(name: 'tax_name')
  final String taxName;

  @ColumnInfo(name: 'tax_value')
  final double taxValue;

  ProductEntity({
    this.productId,
    this.productName,
    this.productDateAdded,
    this.categoryId,
    this.taxName,
    this.taxValue,
  });
}
