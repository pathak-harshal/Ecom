import 'package:Ecom/bloc/ecom_data/ecom_data_bloc.dart';
import 'package:Ecom/bloc/ecom_data/ecom_data_event.dart';
import 'package:Ecom/bloc/ecom_data/ecom_data_state.dart';
import 'package:Ecom/data/model/api_result_model.dart';
import 'package:Ecom/database/dao/category_dao.dart';
import 'package:Ecom/database/dao/parent_category_dao.dart';
import 'package:Ecom/database/dao/product_dao.dart';
import 'package:Ecom/database/dao/products_ranking_dao.dart';
import 'package:Ecom/database/dao/ranking_dao.dart';
import 'package:Ecom/database/dao/variant_dao.dart';
import 'package:Ecom/database/processing_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  final CategoryDao categoryDao;
  final ParentCategoryDao parentCategoryDao;
  final ProductDao productDao;
  final VariantDao variantDao;
  final RankingDao rankingDao;
  final ProductsRankingDao productsRankingDao;

  const HomePage({
    Key key,
    this.categoryDao,
    this.parentCategoryDao,
    this.productDao,
    this.variantDao,
    this.rankingDao,
    this.productsRankingDao,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState(
        categoryDao: categoryDao,
        parentCategoryDao: parentCategoryDao,
        productDao: productDao,
        variantDao: variantDao,
        rankingDao: rankingDao,
        productsRankingDao: productsRankingDao,
      );
}

class _HomePageState extends State<HomePage> {
  EcomDataBloc ecomDatBloc;

  final CategoryDao categoryDao;
  final ParentCategoryDao parentCategoryDao;
  final ProductDao productDao;
  final VariantDao variantDao;
  final RankingDao rankingDao;
  final ProductsRankingDao productsRankingDao;

  _HomePageState({
    this.categoryDao,
    this.parentCategoryDao,
    this.productDao,
    this.variantDao,
    this.rankingDao,
    this.productsRankingDao,
  });

  @override
  void initState() {
    super.initState();
    ecomDatBloc = BlocProvider.of<EcomDataBloc>(context);
    ecomDatBloc.add(FetchEcomDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) {
          return Material(
            child: Scaffold(
              appBar: AppBar(
                title: Text("Category"),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () {
                      ecomDatBloc.add(FetchEcomDataEvent());
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.info),
                    onPressed: () {},
                  )
                ],
              ),
              body: Container(
                child: BlocListener<EcomDataBloc, EcomDataState>(
                  listener: (context, state) {
                    if (state is EcomDataErrorState) {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                        ),
                      );
                    }
                  },
                  child: BlocBuilder<EcomDataBloc, EcomDataState>(
                    // ignore: missing_return
                    builder: (context, state) {
                      if (state is EcomDataInitialState) {
                        return buildLoading();
                      } else if (state is EcomDataLoadingState) {
                        return buildLoading();
                      } else if (state is EcomDataLoadedState) {
                        ProcessingData(
                          state.resultModel,
                          parentCategoryDao,
                          categoryDao,
                          productDao,
                          variantDao,
                          rankingDao,
                          productsRankingDao,
                        );
                        return buildArticleList(state.resultModel.categories);
                      } else if (state is EcomDataErrorState) {
                        return buildErrorUi(state.message);
                      }
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildErrorUi(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  Widget buildArticleList(List<Category> articles) {
    parentCategoryDao.findAllParentCategoryList().then((list) {
      print("No of Parent Categories ${list.length}");
    });
    categoryDao.findAllCategoryList().then((list) {
      print("No of Categories ${list.length}");
    });
    productDao.findAllProductList().then((list) {
      print("No of Products ${list.length}");
    });
    variantDao.findAllVariantList().then((list) {
      print("No of Variants ${list.length}");
    });
    rankingDao.findAllRankingList().then((list) {
      print("No of Ranking ${list.length}");
    });
    productsRankingDao.findAllProductRankingList().then((list) {
      print("No of Product Ranking ${list.length}");
    });
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (ctx, pos) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            child: ListTile(
              leading: ClipOval(
                child: Hero(
                  tag: articles[pos].name,
                  child: Image.network(
                    articles[pos].id.toString(),
                    fit: BoxFit.cover,
                    height: 70.0,
                    width: 70.0,
                  ),
                ),
              ),
              title: Text(articles[pos].name),
            ),
            onTap: () {},
          ),
        );
      },
    );
  }
}
