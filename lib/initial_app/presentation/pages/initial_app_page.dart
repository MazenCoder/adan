import 'package:adan/initial_app/presentation/widgets/loading_app_screen.dart';
import 'package:adan/initial_app/presentation/widgets/build_initial_app.dart';
import 'package:adan/initial_app/presentation/widgets/build_loaded_app.dart';
import 'package:adan/initial_app/presentation/bloc/initial_app_bloc.dart';
import 'package:adan/widgets/responsive_safe_area.dart';
import 'package:adan/helpers/injection_container.dart';
import 'package:adan/usecases/flash_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:adan/widgets/error_app.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:get/get.dart';



class InitialAppPage extends StatelessWidget {
  InitialAppPage({Key key}) : super(key: key);

  final logger = Logger();
  final token = "123456";

  @override
  Widget build(BuildContext context) {
    return ResponsiveSafeArea(
      builder: (_) => Scaffold(
        body: BlocProvider(
          create: (_) => sl<InitialAppBloc>(),
          child: BlocConsumer<InitialAppBloc, InitialAppState>(
            listener: (context, state) {
              if (state is ErrorInitialApp) {
                FlashHelper.errorBar(context, message: state.message != null ?
                  state.message : 'something_wrong'.tr,
                );
              }

              if (state is LoadedApp) {
                if (state.model.status.contains('KO')) {
                  FlashHelper.errorBar(context, message: state.model.message);
                }
              }
            },
            builder: (context, state) {
              if (state is InitialApp) {
                return BuildInitialApp(token);
              } else if (state is LoadingApp) {
                return LoadingAppScreen();
              } else if (state is LoadedApp) {
                return BuildLoadedApp(model: state.model);
              } else if (state is ErrorInitialApp) {
                return ErrorApp();
              } else {
                return ErrorApp();
              }
            },
          )
        ),
      ),
    );
  }
}
