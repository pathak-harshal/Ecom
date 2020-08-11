import 'package:Ecom/data/model/api_result_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class EcomDataState extends Equatable {}

class EcomDataInitialState extends EcomDataState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class EcomDataLoadingState extends EcomDataState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class EcomDataLoadedState extends EcomDataState {

  ApiResultModel resultModel;

  EcomDataLoadedState({@required this.resultModel});

  @override
  // TODO: implement props
  List<Object> get props => [resultModel];
}

class EcomDataErrorState extends EcomDataState {

  String message;

  EcomDataErrorState({@required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}