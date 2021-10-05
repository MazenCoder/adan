import 'package:adan/initial_app/presentation/bloc/initial_app_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'loading_app_screen.dart';



class BuildInitialApp extends StatelessWidget {

  final String token;
  BuildInitialApp(this.token);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: Future.value(token),
      builder: (context, snapshot) {
        switch(snapshot.connectionState) {
          case ConnectionState.waiting:
            return LoadingAppScreen();
          default:
            BlocProvider.of<InitialAppBloc>(context)
              ..add(GetInitial(snapshot.data));
            return LoadingAppScreen();
        }
      },
    );
  }
}


