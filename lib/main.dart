import 'package:Ecom/bloc/ecom_data/ecom_data_bloc.dart';
import 'package:Ecom/data/repository/data_repository.dart';
import 'package:Ecom/database/dao/category_dao.dart';
import 'package:Ecom/database/dao/parent_category_dao.dart';
import 'package:Ecom/database/dao/product_dao.dart';
import 'package:Ecom/database/dao/products_ranking_dao.dart';
import 'package:Ecom/database/dao/ranking_dao.dart';
import 'package:Ecom/database/dao/variant_dao.dart';
import 'package:Ecom/database/db/ecom_database.dart';
import 'package:Ecom/database/entities/parent_category_entity.dart';
import 'package:Ecom/ui/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var database =
      await $FloorEcomDatabase.databaseBuilder('ecom_database.db').build();
  final categoryDao = database.categoryDao;
  final parentCategoryDao = database.parentCategoryDao;
  final productDao = database.productDao;
  final variantDao = database.variantDao;
  final rankingDao = database.rankingDao;
  final productsRankingDao = database.productsRankingDao;

  runApp(MyApp(
    categoryDao: categoryDao,
    parentCategoryDao: parentCategoryDao,
    productDao: productDao,
    variantDao: variantDao,
    rankingDao: rankingDao,
    productsRankingDao: productsRankingDao,
  ));
}

class MyApp extends StatelessWidget {
  final CategoryDao categoryDao;
  final ParentCategoryDao parentCategoryDao;
  final ProductDao productDao;
  final VariantDao variantDao;
  final RankingDao rankingDao;
  final ProductsRankingDao productsRankingDao;

  const MyApp({
    Key key,
    this.categoryDao,
    this.parentCategoryDao,
    this.productDao,
    this.variantDao,
    this.rankingDao,
    this.productsRankingDao,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ecom',
      home: BlocProvider(
        create: (context) => EcomDataBloc(repository: DataRepositoryImpl()),
        child: HomePage(
          categoryDao: categoryDao,
          parentCategoryDao: parentCategoryDao,
          productDao: productDao,
          variantDao: variantDao,
          rankingDao: rankingDao,
          productsRankingDao: productsRankingDao,
        ),
      ),
    );
  }
}
