import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:adan/helpers/preference_utils.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:adan/database/app_database.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:adan/helpers/app_utils.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:adan/mobx/mobx_app.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import '../main.dart';


class SummaryWidget extends StatefulWidget {
  final String currentAddress;

  SummaryWidget({
    @required this.currentAddress,
  });

  @override
  _SummaryWidgetState createState() => _SummaryWidgetState();
}

class _SummaryWidgetState extends State<SummaryWidget> {

  HijriCalendar _todayHijri = new HijriCalendar.now();
  final AppUtils appUtils = GetIt.I.get<AppUtils>();
  final MobxApp _mobxApp = MobxApp();
  DateTime now = new DateTime.now();
  DateFormat formatter;


  void getCountDown() {}

  @override
  void initState() {
    initializeDateFormatting();
    formatter = DateFormat('dd MMMM yyyy', 'fr');
    HijriCalendar.setLocal("en");
    getNxtSalah();
    super.initState();
  }

  Future<void> getNxtSalah() async {
    try {
      final list = await appUtils.getAllSalah();
      TimeOfDay nowTime = TimeOfDay.now();
      double _doubleNowTime = nowTime.hour.toDouble() + (nowTime.minute.toDouble() / 60);
      List<TimeDiff> timeDiffList = [];
      TimeOfDay salahTime;

      list.forEach((salah) {
        if (salah.time != null) {
          salahTime = TimeOfDay(
            hour: int.parse(salah.time.substring(0, 2)),
            minute: int.parse(salah.time.substring(3, 5)),
          );

          double _doubleTempTime = salahTime.hour.toDouble() + (salahTime.minute.toDouble() / 60);
          double _timeDiff = (_doubleTempTime - _doubleNowTime);
          timeDiffList.add(TimeDiff(salah.id, _timeDiff));
        }
      });

      print("timeDiffList: ${timeDiffList.length}");
      final timeNext = timeDiffList.reduce((curr, next) => curr.time > 0.0 ? curr: next);
      int endTime = DateTime.now().millisecondsSinceEpoch + timeNext.time.truncate() * 3600000 + (((timeNext.time - timeNext.time.truncate()) * 60).truncate() * 60000);
      _mobxApp.setEndTime(endTime??0);
      print(list.firstWhere((element) => element.id == timeNext.id).name);
      _mobxApp.setSalah(list.firstWhere((element) => element.id == timeNext.id));
      // return list.firstWhere((element) => element.id == timeNext.id);
    } catch(e) {
      // return Salah(name: '', englishName: '', time: '00:00', isNotificationEnabled: false, date: DateTime.now());
      _mobxApp.setEndTime(0);
      _mobxApp.setSalah(Salah(name: '', englishName: '', time: '00:00', isNotificationEnabled: false, date: DateTime.now()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<AppDatabase>(context);
    final villeId = PreferenceUtils.getInt(KEY_VILLE_ID, 1);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final locale = Get.locale.languageCode;
    return Column(
      children: <Widget>[
        SizedBox(height: height * 0.06),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: BlurryContainer(
            height: height * 0.32,
            borderRadius: BorderRadius.circular(12),
            bgColor: Colors.grey.shade800,
            // bgColor: Color(0xFFC78BA5),
            child: Column(
              children: <Widget>[
                SizedBox(height: 3),
                Observer(
                  builder: (_) {
                    if (_mobxApp.salah != null) {
                      return Column(
                        children: [
                          Text(
                            "prayer".trArgs([locale.contains('fr') ?
                            _mobxApp.salah?.englishName??'' : _mobxApp.salah?.name??''
                            ]),
                            style: GoogleFonts.tajawal(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 2),
                          Text('${_mobxApp.salah?.time??''}',
                            style: GoogleFonts.roboto(
                              fontSize: 40,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 2),
                          CountdownTimer(
                            endTime: _mobxApp.endTime,
                            onEnd: () async {
                              print('endTime: ${_mobxApp.endTime}');
                              await Future.delayed(Duration(seconds: 20)).then((value) => getNxtSalah());
                              print('endTime: ${_mobxApp.endTime}');
                            },
                            widgetBuilder: (_, CurrentRemainingTime time) {
                              return Text(
                                time != null
                                    ? '${time.hours ?? '00'} : ${time.min ?? '00'} : ${time.sec ?? '00'}'
                                    : '00:00:00',
                                style: GoogleFonts.roboto(
                                  fontSize: 17,
                                  color: Colors.white,
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.date_range,
                              color: Colors.white,
                              size: 20,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${_todayHijri.toFormat("dd MMMM yyyy")}',
                              // '${widget.salah.dateHijri}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 1,),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.date_range,
                              color: Colors.white,
                              size: 20,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(formatter.format(now),
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        FutureBuilder<Ville>(
                          future: db.villesDao.getVilleById(villeId),
                          builder: (context, snapshot) {
                            switch(snapshot.connectionState) {
                              case ConnectionState.waiting: return Center(
                                child: Text('loading'.tr,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                              default:
                                return Text(
                                  "${locale.contains('fr') ?
                                  snapshot.data.ville??'' :
                                  snapshot.data.ville_ar??''}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                );
                            }
                          },
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Icon(
                          Icons.location_on,
                          color: Colors.white,
                          size: 20,
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}


class TimeDiff {
  final int id;
  final double time;
  TimeDiff(this.id, this.time);
}