import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/model/headlines_model.dart';

import '../../resources/api_repository.dart';

part 'api_event.dart';
part 'api_state.dart';

class ApiBloc extends Bloc<ApiEvent, ApiState> {
  ApiBloc() : super(ApiStateInitial()) {
    final ApiRepository _apiRepository = ApiRepository();
    on<ApiEventHeadlines>((event, emit) async {
      try {
        emit(ApiStateLoading());
        var headlines = await _apiRepository.fetchCovidList();
        emit(ApiStateCompleted(headlines: headlines));
      } catch (e) {
        emit(ApiStateEror(errorMessage: "wow"));
      }
    });
  }
}
