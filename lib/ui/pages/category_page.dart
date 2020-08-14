import 'package:Ecom/database/dao/category_dao.dart';
import 'package:Ecom/database/dao/parent_category_dao.dart';
import 'package:Ecom/database/dao/product_dao.dart';
import 'package:Ecom/database/dao/products_ranking_dao.dart';
import 'package:Ecom/database/dao/ranking_dao.dart';
import 'package:Ecom/database/dao/variant_dao.dart';
import 'package:Ecom/database/entities/category_entity.dart';
import 'package:Ecom/ui/pages/sub_category_page.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  final int parentId;
  final ParentCategoryDao parentCategoryDao;
  final CategoryDao categoryDao;
  final ProductDao productDao;
  final VariantDao variantDao;
  final RankingDao rankingDao;
  final ProductsRankingDao productsRankingDao;
  final String categoryName;

  const CategoryPage({
    Key key,
    this.parentId,
    this.categoryDao,
    this.categoryName,
    this.parentCategoryDao,
    this.productDao,
    this.variantDao,
    this.rankingDao,
    this.productsRankingDao,
  }) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState(
        parentId: parentId,
        categoryDao: categoryDao,
        categoryName: categoryName,
        parentCategoryDao: parentCategoryDao,
        productDao: productDao,
        variantDao: variantDao,
        rankingDao: rankingDao,
        productsRankingDao: productsRankingDao,
      );
}

class _CategoryPageState extends State<CategoryPage> {
  final int parentId;
  final ParentCategoryDao parentCategoryDao;
  final CategoryDao categoryDao;
  final ProductDao productDao;
  final VariantDao variantDao;
  final RankingDao rankingDao;
  final ProductsRankingDao productsRankingDao;
  final String categoryName;

  _CategoryPageState({
    this.parentId,
    this.categoryDao,
    this.parentCategoryDao,
    this.productDao,
    this.variantDao,
    this.rankingDao,
    this.productsRankingDao,
    this.categoryName,
  });

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // categoryDao.findChildCategory(parentId).then((List<CategoryEntity> list){
    //   print("Category Count ${list.length}");
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          categoryName,
        ),
      ),
      body: buildCategories(),
    );
  }

  Widget buildCategories() {
    return StreamBuilder<List<CategoryEntity>>(
      stream: categoryDao.findChildCategory(parentId),
      builder: (_, AsyncSnapshot<List<CategoryEntity>> snapshot) {
        if (snapshot.hasData) {
          final List<CategoryEntity> categories = snapshot.data;
          if (categories.length == 0) {
            return const Center(
              child: Text(
                "Not Available",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            );
          } else {
            return ListView.builder(
              key: UniqueKey(),
              shrinkWrap: true,
              itemCount: categories.length,
              itemBuilder: (_, index) {
                final item = categories[index];
                return ListTile(
                  title: Text(item.categoryName),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SubCategoryPage(
                          parentId: item.categoryId,
                          categoryDao: categoryDao,
                          productDao: productDao,
                          parentCategoryDao: parentCategoryDao,
                          productsRankingDao: productsRankingDao,
                          rankingDao: rankingDao,
                          variantDao: variantDao,
                          categoryName: item.categoryName,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
        } else {
          return const Center(
            child: Text(
              "Not Available",
              style: TextStyle(fontSize: 30.0, color: Colors.grey),
            ),
          );
        }
      },
    );
  }
}
