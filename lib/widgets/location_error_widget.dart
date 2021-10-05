import 'package:flutter/material.dart';
import 'package:get/get.dart';


class LocationErrorWidget extends StatelessWidget {
  final String error;
  final Function callback;

  const LocationErrorWidget({Key key, this.error, this.callback})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    final box = SizedBox(height: 32);
    return Container(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.location_off,
              size: 50,
              color: Colors.red,
            ),
            box,
            Text(
              error,
              style: TextStyle(
                  color: Colors.red, fontWeight: FontWeight.bold),
            ),
            box,
            TextButton(
              child: Text("retry".tr,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                if (callback != null) callback();
              },
            )
          ],
        ),
      ),
    );
  }
}
