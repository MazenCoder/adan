import 'package:flutter_compass/flutter_compass.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:adan/services/qibla_service.dart';
import 'package:adan/widgets/qiblah_compass.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:adan/mobx/mobx_app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;



class NavigationWidget extends StatefulWidget {
  @override
  _NavigationWidgetState createState() => _NavigationWidgetState();
}

class _NavigationWidgetState extends State<NavigationWidget> {
  // double direction = 0;

  // final _deviceSupport = FlutterQiblah.androidDeviceSensorSupport();
  // final MobxApp _mobxApp = MobxApp();

  // void updateDirection() async{
  //   double dir = await getQiblaDirection();
  //   _mobxApp.setDirection(dir);
  // }
  //
  // @override
  // void initState() {
  //   super.initState();
  //   updateDirection();
  // }

  @override
  Widget build(BuildContext context)  {
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 18.0,
        vertical: 10.0,
      ),
      child: BlurryContainer(
        height: height * .55,
        bgColor: Colors.grey.shade700,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // Observer(
            //   builder: (_) {
            //     return _buildCompass(_mobxApp.direction);
            //   },
            // ),
            Expanded(
              child: FutureBuilder(
                future:  FlutterQiblah.androidDeviceSensorSupport(),
                builder: (_, AsyncSnapshot<bool> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  if (snapshot.hasError)
                    return Center(
                      child: Text("Error: ${snapshot.error.toString()}"),
                    );

                  if (snapshot.data)
                    return QiblahCompass();
                  else
                    return Center();
                },
              ),
            ),
            Text('direction_qibla'.tr,
              textAlign: TextAlign.start,
              style: GoogleFonts.tajawal(
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
//
// Widget _buildCompass(double navDirection) {
//   return StreamBuilder<double>(
//     stream: FlutterCompass.events,
//     builder: (context, snapshot) {
//       if (snapshot.hasError) {
//         return Text('error_reading'.trArgs([snapshot.error.toString()]));
//       }
//
//       if (snapshot.connectionState == ConnectionState.waiting) {
//         return Center(
//           child: CircularProgressIndicator(),
//         );
//       }
//
//       double direction = snapshot.data;
//
//       // if direction is null, then device does not support this sensor
//       // show error message
//       if (direction == null)
//         return Center(
//           child: Text("not_sensors".tr),
//         );
//       return Container(
//         child: Align(
//           alignment: Alignment.center,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical:25.0),
//             child: Stack(
//               alignment: Alignment.center,
//               children: <Widget>[
//                 Transform.rotate(
//                   angle: ((direction ?? 0) * (math.pi / 180) * -1),
//                   child: Image.asset(
//                     'assets/compass.png',
//                     width: 170,
//                   ),
//                 ),
//                 Container(
//                   child: Transform.rotate(
//                     angle: ((direction - navDirection ?? 0) * 180),
//                         // (math.pi / 180) * -1),
//                     child: Image.asset(
//                       'assets/needle.png',
//                       width: 22.0,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       );
//     },
//   );
// }