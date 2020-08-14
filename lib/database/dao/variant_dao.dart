
import 'package:Ecom/database/entities/variant_entity.dart';
import 'package:floor/floor.dart';

@dao
abstract class VariantDao {
  @Query('SELECT * FROM variant')
  Stream<List<VariantEntity>> findAllVariants();

  @Query('SELECT * FROM variant')
  Future<List<VariantEntity>> findAllVariantList();

  @Query('SELECT * FROM variant WHERE product_id = :id')
  Stream<List<VariantEntity>> findVariantsProductWise(int productId);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertVariants(List<VariantEntity> variants);
}