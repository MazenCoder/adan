import 'package:adan/services/notifications.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:adan/database/app_database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:adan/helpers/app_utils.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:get/get.dart';



class SalahItemWidget extends StatefulWidget {
  final Salah salah;
  final bool fromHome;
  SalahItemWidget({@required this.salah, this.fromHome = true});

  @override
  _SalahItemWidgetState createState() => _SalahItemWidgetState();
}

class _SalahItemWidgetState extends State<SalahItemWidget> {

  final AppUtils appUtils = GetIt.I.get<AppUtils>();
  bool notificationEnabled = false;

  @override
  void initState() {
    notificationEnabled = widget.salah.isNotificationEnabled;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<AppDatabase>(context);
    final locale = Get.locale.languageCode;
    final size = MediaQuery.of(context).size;
    return BlurryContainer(
      height: size.height * .075,
      padding: EdgeInsets.all(0),
      borderRadius: BorderRadius.circular(12),
      bgColor: Colors.grey.shade800,
      // bgColor: Color(0xFF837BA9),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              width: 120,
              child: Text(
                locale.contains('fr') ?
                  widget.salah.englishName
                    : widget.salah.name,
                style: GoogleFonts.tajawal(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            Text(
              widget.salah?.time??'',
              style: GoogleFonts.tajawal(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            if (widget.fromHome)
              StreamBuilder<Salah>(
                stream: db.salahsDao.watchSalahById(widget.salah.id),
                builder: (context, snapshot) {
                  switch(snapshot.connectionState) {
                    case ConnectionState.waiting: return Center(
                      child: CircularProgressIndicator(),
                    );
                    default:
                      final salah = snapshot.data;
                      return GestureDetector(
                        onTap: () async {
                          if (salah.isNotificationEnabled) {
                            await NotificationService.cancelNotification(widget.salah.id);
                          } else {
                            await NotificationService.enableNotification(widget.salah);
                          }
                          await appUtils.updateSalahNotification(widget.salah, !salah.isNotificationEnabled);
                        },
                        child: Icon(
                          salah.isNotificationEnabled
                              ? Icons.volume_up
                              : Icons.volume_off,
                          size: 30,
                          color: salah.isNotificationEnabled ?
                          Colors.white : Colors.red,
                        ),
                      );
                  }
                },
              )
          ],
        ),
      ),
    );
  }
}
