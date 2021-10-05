import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:adan/widgets/responsive_safe_area.dart';
import 'package:adan/screens/initial_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ErrorApp extends StatelessWidget {
  final String message;
  ErrorApp([this.message]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(12),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('Oops',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20,),
                Image.asset('assets/logo_inoser.png', height: 220,
                  color: Colors.black,
                ),
                SizedBox(height: 5,),
                Text(message != null ? message : 'error_wrong'.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                RaisedButton.icon(
                  icon: Icon(MdiIcons.refresh),
                  // color: ColorHelper.COLOR_PINK[400],
                  // textColor: ColorHelper.COLOR_WITHE,
                  label: Padding(
                    padding: const EdgeInsets.only(top: 12, bottom: 12),
                    child: Text('try_again'.tr),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) => InitialScreen(),
                    ));
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(16.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
