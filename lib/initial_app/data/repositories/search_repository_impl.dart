import 'package:adan/initial_app/data/database/initial_app_remote_data_source.dart';
import 'package:adan/initial_app/data/database/initial_app_local_data_source.dart';
import 'package:adan/initial_app/domain/repositories/initial_app_repository.dart';
import 'package:adan/initial_app/data/models/salah_model.dart';
import 'package:adan/initial_app/data/models/ville_model.dart';
import 'package:adan/network/network_info.dart';
import 'package:adan/error/exceptions.dart';
import 'package:adan/error/failures.dart';
import 'package:logger/logger.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:get/get.dart';



class InitialAppRepositoryImpl implements InitialAppRepository {

  final InitialAppRemoteDataSource remoteDataSource;
  final InitialAppLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  final logger = Logger();

  InitialAppRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });


  @override
  Future<Either<Failure, VilleModel>> getInitialApp(String token) async {
    if (await networkInfo.isConnected) {
      try {
        VilleModel ville = await remoteDataSource.getVilles(token);
        if (ville != null && ville.status.contains('OK')) {
          await localDataSource.cacheVille(ville);
        }
        SalahModel priere = await remoteDataSource.getHorairePriere(token);
        if (priere != null && priere.status.contains('OK')) {
          await localDataSource.cacheSalah(priere);
        }
        return Right(ville);
      } on ServerException {
        return Left(ServerFailure(message: 'error_server'.tr));
      }
    } else {
      return Left(CacheFailure(message: "error_connection".tr));
    }
  }
}