import 'package:Ecom/bloc/ecom_data/ecom_data_event.dart';
import 'package:Ecom/bloc/ecom_data/ecom_data_state.dart';
import 'package:Ecom/data/model/api_result_model.dart';
import 'package:Ecom/data/repository/data_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EcomDataBloc extends Bloc<EcomDataEvent, EcomDataState> {
  final DataRepository repository;

  EcomDataBloc({this.repository}): super(EcomDataInitialState());

  // EcomDataBloc({@required this.repository});


  @override
  Stream<EcomDataState> mapEventToState(EcomDataEvent event) async* {
    if (event is FetchEcomDataEvent) {
      yield EcomDataLoadingState();
      try {
        ApiResultModel resultModel = await repository.getAllData();
        yield EcomDataLoadedState(resultModel: resultModel);
      } catch (e) {
        yield EcomDataErrorState(message: e.toString());
      }
    }
  }
}
