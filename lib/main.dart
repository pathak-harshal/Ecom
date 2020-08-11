import 'package:Ecom/bloc/ecom_data/ecom_data_bloc.dart';
import 'package:Ecom/data/repository/data_repository.dart';
import 'package:Ecom/ui/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ecom',
      home: BlocProvider(
        create: (context) => EcomDataBloc(repository: DataRepositoryImpl()),
        child: HomePage(),
      ),
    );
  }
}
