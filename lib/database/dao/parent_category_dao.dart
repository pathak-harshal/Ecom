import 'package:Ecom/database/entities/parent_category_entity.dart';
import 'package:floor/floor.dart';

@dao
abstract class ParentCategoryDao {
  @Query('SELECT * FROM parent_category')
  Stream<List<ParentCategoryEntity>> findAllParentCategories();

  @Query('SELECT * FROM parent_category')
  Future<List<ParentCategoryEntity>> findAllParentCategoryList();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertParentCategories(List<ParentCategoryEntity> parentCategories);
}