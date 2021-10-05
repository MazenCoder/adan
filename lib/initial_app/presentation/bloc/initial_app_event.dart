part of 'initial_app_bloc.dart';

abstract class InitialEvent extends Equatable {
  const InitialEvent();
}

class GetInitial extends InitialEvent {
  final String token;
  const GetInitial(this.token);

  @override
  List<Object> get props => [token];
}