import 'dart:async';

import 'package:Ecom/database/dao/category_dao.dart';
import 'package:Ecom/database/dao/parent_category_dao.dart';
import 'package:Ecom/database/dao/product_dao.dart';
import 'package:Ecom/database/dao/products_ranking_dao.dart';
import 'package:Ecom/database/dao/ranking_dao.dart';
import 'package:Ecom/database/dao/variant_dao.dart';
import 'package:Ecom/database/entities/category_entity.dart';
import 'package:Ecom/database/entities/parent_category_entity.dart';
import 'package:Ecom/database/entities/product_entity.dart';
import 'package:Ecom/database/entities/products_ranking_entity.dart';
import 'package:Ecom/database/entities/rankings_entity.dart';
import 'package:Ecom/database/entities/variant_entity.dart';

import 'package:floor/floor.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'ecom_database.g.dart';

@Database(version: 1, entities: [
  CategoryEntity,
  ParentCategoryEntity,
  ProductEntity,
  VariantEntity,
  RankingEntity,
  ProductsRankingEntity
])
abstract class EcomDatabase extends FloorDatabase {
  CategoryDao get categoryDao;
  ParentCategoryDao get parentCategoryDao;
  ProductDao get productDao;
  VariantDao get variantDao;
  RankingDao get rankingDao;
  ProductsRankingDao get productsRankingDao;
}
