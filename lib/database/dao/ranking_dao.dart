import 'package:Ecom/database/entities/rankings_entity.dart';
import 'package:floor/floor.dart';

@dao
abstract class RankingDao {
  @Query('SELECT * FROM rankings')
  Stream<List<RankingEntity>> findAllRakings();

  @Query('SELECT * FROM rankings')
  Future<List<RankingEntity>> findAllRankingList();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertRanking(RankingEntity rankingEntity);
}