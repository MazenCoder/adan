import 'package:flutter/material.dart';


class LoadingAppScreen extends StatelessWidget {
  const LoadingAppScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
            child: SizedBox(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
              // width: 20,
              // height: 20,
            ),
        ),
      ),
    );
  }
}
