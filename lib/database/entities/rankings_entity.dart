import 'package:Ecom/data/model/api_result_model.dart';
import 'package:floor/floor.dart';

@Entity(tableName: 'rankings')
class RankingEntity {
  // @ColumnInfo(name: 'ranking_id')
  // @PrimaryKey(autoGenerate: true)
  // final int rankingId;

  @ColumnInfo(name: 'ranking_text')
  @PrimaryKey(autoGenerate: false)
  final String rankingText;

  RankingEntity({
    // this.rankingId,  
    this.rankingText,
  });
}
