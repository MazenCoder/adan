import 'package:adan/initial_app/domain/usecases/get_initial_app.dart';
import 'package:adan/initial_app/data/models/ville_model.dart';
import 'package:adan/error/failures.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:dartz/dartz.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'dart:async';

part 'initial_app_event.dart';
part 'initial_app_state.dart';

class InitialAppBloc extends Bloc<InitialEvent, InitialAppState> {

  final GetInitialApp getInitialApp;
  InitialAppBloc({@required this.getInitialApp}) : super(InitialApp());


  final logger = Logger();

  @override
  Stream<InitialAppState> mapEventToState(InitialEvent event) async* {
    if (event is GetInitial) {
      try {
        Either<Failure, VilleModel> either = await getInitialApp.call(event.token);
        yield LoadingApp();
        yield* either.fold((failure) async* {
          logger.e('failure');
          var getType = failure.props?.elementAt(0);
          print("getType message: $getType");
          print("getType first: ${failure.props.first}");
          String messageFailure = either.fold((failure) => failure.props?.elementAt(0) ?? '', (_) => '');
          print("messageFailure: $messageFailure");
          yield ErrorInitialApp(message: messageFailure);
        }, (values) async* {
          logger.d('$values');
          yield LoadedApp(values);
        });
      } catch(e) {
        logger.e(e);
        yield ErrorInitialApp(message: e.toString());
      }
    }
  }
}
