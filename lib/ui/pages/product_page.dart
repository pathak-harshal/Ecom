import 'package:Ecom/database/dao/product_dao.dart';
import 'package:Ecom/database/dao/products_ranking_dao.dart';
import 'package:Ecom/database/dao/ranking_dao.dart';
import 'package:Ecom/database/dao/variant_dao.dart';
import 'package:Ecom/database/entities/product_entity.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  final int categoryId;
  final String categoryName;
  final ProductDao productDao;
  final VariantDao variantDao;
  final RankingDao rankingDao;
  final ProductsRankingDao productsRankingDao;

  const ProductPage({
    Key key,
    this.productDao,
    this.variantDao,
    this.rankingDao,
    this.productsRankingDao,
    this.categoryId,
    this.categoryName,
  }) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState(
        categoryId: categoryId,
        categoryName: categoryName,
        productDao: productDao,
        variantDao: variantDao,
        rankingDao: rankingDao,
        productsRankingDao: productsRankingDao,
      );
}

class _ProductPageState extends State<ProductPage> {
  final int categoryId;
  final String categoryName;
  final ProductDao productDao;
  final VariantDao variantDao;
  final RankingDao rankingDao;
  final ProductsRankingDao productsRankingDao;

  _ProductPageState({
    this.categoryId,
    this.categoryName,
    this.productDao,
    this.variantDao,
    this.rankingDao,
    this.productsRankingDao,
  });

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
    return StreamBuilder<List<ProductEntity>>(
      stream: productDao.findProductsWithCategory(categoryId),
      builder: (_, AsyncSnapshot<List<ProductEntity>> snapshot) {
        if (snapshot.hasData) {
          final List<ProductEntity> categories = snapshot.data;
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
                  title: Text(item.productName),
                  onTap: () {},
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
