import 'package:adan/initial_app/data/models/ville_model.dart';
import 'package:adan/error/failures.dart';
import 'package:dartz/dartz.dart';


abstract class InitialAppRepository {
  Future<Either<Failure, VilleModel>> getInitialApp(String token);
}