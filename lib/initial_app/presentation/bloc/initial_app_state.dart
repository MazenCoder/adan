part of 'initial_app_bloc.dart';


abstract class InitialAppState extends Equatable {
  const InitialAppState();
}

class InitialApp extends InitialAppState {
  const InitialApp();

  @override
  List<Object> get props => [];
}

class LoadingApp extends InitialAppState {
  const LoadingApp();

  @override
  List<Object> get props => [];
}

class LoadedApp extends InitialAppState {
  final VilleModel model;
  const LoadedApp(this.model);

  @override
  List<Object> get props => [model];
}

class ErrorInitialApp extends InitialAppState {
  final String message;
  final bool isConnection;
  const ErrorInitialApp({this.message, this.isConnection = false});

  @override
  List<Object> get props => [message];
}