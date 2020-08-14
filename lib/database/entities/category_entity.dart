import 'package:floor/floor.dart';

@Entity(tableName: 'category')
class CategoryEntity {
  @ColumnInfo(name: 'category_id')
  @PrimaryKey(autoGenerate: false)
  final int categoryId;

  @ColumnInfo(name: 'category_name', nullable: false)
  final String categoryName;

  @ColumnInfo(name: 'parent_also', nullable: false)
  final bool isParentAlso;

  @ColumnInfo(name: 'parent_id')
  final int parentId;

  CategoryEntity({
    this.categoryId,
    this.categoryName,
    this.isParentAlso,
    this.parentId,
  });
}
