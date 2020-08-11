import 'package:Ecom/bloc/ecom_data/ecom_data_bloc.dart';
import 'package:Ecom/bloc/ecom_data/ecom_data_event.dart';
import 'package:Ecom/bloc/ecom_data/ecom_data_state.dart';
import 'package:Ecom/data/model/api_result_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  EcomDataBloc ecomDatBloc;

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
                    builder: (context, state) {
                      if (state is EcomDataInitialState) {
                        return buildLoading();
                      } else if (state is EcomDataLoadingState) {
                        return buildLoading();
                      } else if (state is EcomDataLoadedState) {
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
