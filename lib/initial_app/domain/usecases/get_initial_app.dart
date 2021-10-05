import 'package:adan/initial_app/domain/repositories/initial_app_repository.dart';
import 'package:adan/initial_app/data/models/ville_model.dart';
import 'package:adan/usecases/usecase.dart';
import 'package:adan/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';


class GetInitialApp implements UseCase<VilleModel, String> {

  final InitialAppRepository repository;
  GetInitialApp({@required this.repository});

  @override
  Future<Either<Failure, VilleModel>> call(String params) async {
    return await repository.getInitialApp(params);
  }
}