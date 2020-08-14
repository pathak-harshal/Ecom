import 'package:Ecom/database/entities/category_entity.dart';
import 'package:floor/floor.dart';

@dao
abstract class CategoryDao {
  @Query('SELECT * FROM category')
  Stream<List<CategoryEntity>> findAllCategories();

  @Query('SELECT * FROM category')
  Future<List<CategoryEntity>> findAllCategoryList();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertCategories(List<CategoryEntity> categories);
}