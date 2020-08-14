import 'package:Ecom/data/model/api_result_model.dart' as apiResult;
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

class ProcessingData {
  apiResult.ApiResultModel model;
  ParentCategoryDao parentCategoryDao;
  CategoryDao categoryDao;
  ProductDao productDao;
  VariantDao variantDao;
  RankingDao rankingDao;
  ProductsRankingDao productsRankingDao;

  ProcessingData(
    apiResult.ApiResultModel model,
    ParentCategoryDao parentCategoryDao,
    CategoryDao categoryDao,
    ProductDao productDao,
    VariantDao variantDao,
    RankingDao rankingDao,
    ProductsRankingDao productsRankingDao,
  ) {
    this.model = model;
    this.parentCategoryDao = parentCategoryDao;
    this.categoryDao = categoryDao;
    this.productDao = productDao;
    this.variantDao = variantDao;
    this.rankingDao = rankingDao;
    this.productsRankingDao = productsRankingDao;
    saveParentCategory();
    saveCategory();
    saveProductsAndVariants();
    saveRanking();
  }

  void saveParentCategory() {
    List<apiResult.Category> allCategories = model.categories;
    List<ParentCategoryEntity> list = new List<ParentCategoryEntity>();
    List<int> childCategories = new List();
    for (int i = 0; i < allCategories.length; i++) {
      childCategories.addAll(allCategories.elementAt(i).childCategories);
    }
    for (int i = 0; i < allCategories.length; i++) {
      apiResult.Category category = allCategories.elementAt(i);
      if (!childCategories.contains(category.id)) {
        int id = category.id;
        String name = category.name;
        print('name $name');
        ParentCategoryEntity entity = new ParentCategoryEntity(
            parentCategoryId: id, parentCategoryName: name);
        list.add(entity);
      }
    }
    parentCategoryDao.insertParentCategories(list);
  }

  void saveCategory() {
    List<apiResult.Category> allCategories = model.categories;
    List<CategoryEntity> list = new List<CategoryEntity>();
    List<int> childCategories = new List();
    for (int i = 0; i < allCategories.length; i++) {
      childCategories.addAll(allCategories.elementAt(i).childCategories);
    }

    for (int i = 0; i < childCategories.length; i++) {
      int childCatgory = childCategories.elementAt(i);
      int parentCategory = 0;
      for (int j = 0; j < allCategories.length; j++) {
        apiResult.Category category = allCategories.elementAt(j);
        if (category.childCategories.contains(childCatgory)) {
          parentCategory = category.id;
        }
      }
      for (int k = 0; k < allCategories.length; k++) {
        apiResult.Category category = allCategories.elementAt(k);
        if (category.id == childCatgory) {
          int id = category.id;
          String name = category.name;
          bool isParentAlso = false;
          if (category.childCategories.isNotEmpty) {
            isParentAlso = true;
          }
          var entity = CategoryEntity(
              categoryId: id,
              categoryName: name,
              isParentAlso: isParentAlso,
              parentId: parentCategory);
          list.add(entity);
        }
      }
    }

    categoryDao.insertCategories(list);
  }

  void saveProductsAndVariants() {
    List<apiResult.Category> allCategories = model.categories;
    List<ProductEntity> list = new List<ProductEntity>();

    for (int i = 0; i < allCategories.length; i++) {
      apiResult.Category category = allCategories.elementAt(i);
      int parentCategory = category.id;
      for (int j = 0; j < category.products.length; j++) {
        List<VariantEntity> listVariant = new List<VariantEntity>();
        apiResult.CategoryProduct product = category.products.elementAt(j);
        int pId = product.id;
        String name = product.name;
        String dateAdded = product.dateAdded.toString();
        String taxName = product.tax.name.toString();
        double taxValue = product.tax.value;

        var entity = ProductEntity(
          productId: pId,
          productName: name,
          categoryId: parentCategory,
          productDateAdded: dateAdded,
          taxName: taxName,
          taxValue: taxValue,
        );

        var variants = product.variants;
        for (int k = 0; k < variants.length; k++) {
          var variant = variants.elementAt(k);
          int id = variant.id;
          String color = variant.color;
          int size = variant.size;
          int price = variant.price;

          var variantEntity = VariantEntity(
            variantId: id,
            variantColor: color,
            variantSize: size,
            variantPrice: price,
            productId: pId,
          );

          listVariant.add(variantEntity);
        }
        variantDao.insertVariants(listVariant);
        list.add(entity);
      }
    }

    productDao.insertProducts(list);
  }

  void saveRanking() {
    List<apiResult.Ranking> allRankings = model.rankings;

    for (int i = 0; i < allRankings.length; i++) {
      var object = allRankings.elementAt(i);

      String rankingName = object.ranking;

      var entity = RankingEntity(rankingText: rankingName);

      rankingDao.insertRanking(entity);
      List<ProductsRankingEntity> list = new List<ProductsRankingEntity>();
        for (int j = 0; j < object.products.length; j++) {
          var product = object.products.elementAt(j);

          int id = product.id;
          int count = 0;
          if (product.orderCount != 0 || product.orderCount != null) {
            count = product.orderCount;
          } else if (product.shares != 0 || product.shares != null) {
            count = product.shares;
          } else {
            count = product.viewCount;
          }

          var entity = ProductsRankingEntity(
            productId: id,
            rankingText: rankingName,
            totalCount: count,
          );

          list.add(entity);
        }

        productsRankingDao.insertProductRankings(list);
    }
  }
}
