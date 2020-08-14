import 'package:floor/floor.dart';

@Entity(tableName: 'parent_category')
class ParentCategoryEntity {
  @ColumnInfo(name: 'parent_category_id')
  @PrimaryKey(autoGenerate: false)
  final int parentCategoryId;


  @ColumnInfo(name: 'category_name', nullable: false)
  final String parentCategoryName;

  ParentCategoryEntity({
    this.parentCategoryId,
    this.parentCategoryName,
  });
}