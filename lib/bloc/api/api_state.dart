part of 'api_bloc.dart';

abstract class ApiState extends Equatable {
  const ApiState();

  @override
  List<Object?> get props => [];
}

class ApiStateInitial extends ApiState {}

class ApiStateLoading extends ApiState {}

class ApiStateCompleted extends ApiState {
  ApiStateCompleted({
    required this.headlines,
  });

  final Headlines headlines;
}

class ApiStateEror extends ApiState {
  ApiStateEror({required this.errorMessage});

  final String errorMessage;
}
