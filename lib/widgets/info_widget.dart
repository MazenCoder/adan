import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class InfoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 18.0,
        vertical: 15.0,
      ),
      child: BlurryContainer(
        height: height * .505,
        blur: 20,
        bgColor: Colors.black,
        // child: Container(),
        /// TODO Remove Comment
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 2,
              ),
              Text(
                'info_app'.tr,
                style: GoogleFonts.tajawal(
                  color: Colors.white,
                  fontSize: 15,
                  height: 1.6,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              InkWell(
                onTap: () async {
                  await launch('http://www.inoser.ma/');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/logo_inoser.png',
                      width: 99,
                    ),
                    // Image.asset(
                    //   'assets/logo2.png',
                    //   width: 100,
                    // )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
