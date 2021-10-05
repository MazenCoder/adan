import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:adan/shared_pref/preferred_adhan_pref.dart';
import 'package:adan/shared_pref/salah_reminder_pref.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:adan/helpers/preference_utils.dart';
import 'package:adan/shared_pref/method_pref.dart';
import 'package:adan/screens/initial_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:adan/database/app_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:adan/helpers/app_utils.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:get/get.dart';
import 'dart:typed_data';
import '../main.dart';
import 'dart:io';



class SettingsWidget extends StatefulWidget {
  @override
  _SettingsWidgetState createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {

  final AppUtils appUtils = GetIt.I.get<AppUtils>();

  String dropDownLng1 = 'العربية';
  String dropDownLng2 = 'French';
  String dropDownAdhan = 'adan1';
  String dropDownMethod = 'ISNA';
  String dropDownReminder = '3';
  AudioPlayer audioPlayer = AudioPlayer();
  List<String> lngList = <String>['العربية', 'French'];
  List<String> adhanList = <String>['adan1', 'adan2', 'adan3'];
  List<String> methodList = <String>[
    'ISNA',
    'SMJ',
  ];

  Ville _ville;
  List<String> reminderList = <String>[
    '3',
    '5',
    '10',
    '15',
    '20',
    '30',
  ];

  @override
  void initState() {
    initSalahReminder();
    initPreferredAdhan();
    initPreferredMethod();
    super.initState();
  }

  void initSalahReminder() async {
    _ville = await appUtils.getVilleById();
    dropDownReminder = PreferenceUtils.getInt(cSalahReminder, 3).toString();
    setState(() {});
  }

  void initPreferredAdhan() async {
    dropDownAdhan = await getPreferredAdhan();
    setState(() {});
  }

  Future<ByteData> loadAsset(String audioName) async {
    return await rootBundle.load('assets/$audioName.mp3');
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.dispose();
  }

  playLocal(String audioName) async {
    final file = new File('${(await getTemporaryDirectory()).path}/$audioName.wav');
    // final file = new File('${(await getTemporaryDirectory()).path}/$audioName.mp3');
    await file.writeAsBytes((await loadAsset(audioName)).buffer.asUint8List());
    int result = await audioPlayer.play(file.path, isLocal: true);
  }

  initPreferredMethod() async {
    dropDownMethod = await getMethod();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final locale = Get.locale.languageCode;
    final db = Provider.of<AppDatabase>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 18.0,
        vertical: 10.0,
      ),
      child: BlurryContainer(
        height: height * 0.5,
        bgColor: Colors.black,
        // child: Container(),
        /// TODO Remove Comment

        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(
                Icons.language,
                color: Colors.white,
                size: 20,
              ),
              title: Text(
                'lung'.tr,
                style: GoogleFonts.tajawal(
                  color: Colors.white,
                ),
              ),
              trailing: Theme(
                data: Theme.of(context).copyWith(
                  canvasColor: Colors.black,
                ),
                child: dropDownSettings(() {

                }, locale.contains('fr') ?
                  dropDownLng2 : dropDownLng1, lngList),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.music_note,
                color: Colors.white,
                size: 20,
              ),
              title: Text('azan_settings'.tr,
                style: GoogleFonts.tajawal(
                  color: Colors.white,
                ),
              ),
              trailing: Theme(
                data: Theme.of(context).copyWith(
                  canvasColor: Colors.black,
                ),
                child: DropdownButton<String>(
                  value: dropDownAdhan,
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white,
                  ),
                  iconSize: 24,
                  elevation: 16,
                  style: GoogleFonts.tajawal(
                    color: Colors.black,
                  ),
                  underline: Container(
                    height: 1,
                    color: Colors.white24,
                  ),
                  onChanged: (String newValue) async {
                    dropDownAdhan = newValue;
                    playLocal(dropDownAdhan.toLowerCase());
                    // setPreferredAdhan(dropDownAdhan);
                    print('dropDownAdhan: $dropDownAdhan');
                    PreferenceUtils.setString(cSalahSoundSource, dropDownAdhan);
                    Fluttertoast.showToast(
                        msg: "done".tr,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.blueGrey,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    setState(() {});
                  },
                  items: adhanList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: GoogleFonts.tajawal(color: Colors.white),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.alarm,
                color: Colors.white,
                size: 20,
              ),
              title: Text(
                'prayer_alerts_minutes'.tr,
                style: GoogleFonts.tajawal(
                  color: Colors.white,
                ),
              ),
              trailing: Theme(
                data: Theme.of(context).copyWith(
                  canvasColor: Colors.black,
                ),
                child: DropdownButton<String>(
                  value: dropDownReminder,
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white,
                  ),
                  iconSize: 24,
                  elevation: 16,
                  style: GoogleFonts.tajawal(
                    color: Colors.black,
                  ),
                  underline: Container(
                    height: 1,
                    color: Colors.white24,
                  ),
                  onChanged: (String newValue) async {
                    print("newValue: $newValue");
                    PreferenceUtils.setInt(cSalahReminder, int.parse(newValue));
                    dropDownReminder = newValue;
                    // setSalahReminder(int.parse(dropDownReminder));
                    Fluttertoast.showToast(
                        msg: "done".tr,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.blueGrey,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    setState(() {});
                  },
                  items: reminderList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: GoogleFonts.tajawal(color: Colors.white),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(height: 8),
            Container(
              child: Theme(
                data: Theme.of(context).copyWith(
                  canvasColor: Colors.blue,
                ),
                child: FutureBuilder<List<Ville>>(
                  future: db.villesDao.getAllVille(),
                  builder: (context, snapshot) {
                    switch(snapshot.connectionState) {
                      case ConnectionState.waiting: return Center(
                        child: CircularProgressIndicator(),
                      );
                      default:
                        List<Ville> villes = snapshot.data??[];
                        return SearchableDropdown.single(
                          iconEnabledColor: Colors.white,
                          displayClearIcon: false,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          items: villes.map((item) {
                            if (locale.contains('fr')) {
                              return (DropdownMenuItem(
                                child: Text(item.ville.toString()),
                                value: item,
                              ));
                            } else {
                              return (DropdownMenuItem(
                                child: Text(item.ville_ar.toString()),
                                value: item,
                              ));
                            }
                          }).toList(),
                          value: _ville,
                          hint: (_ville != null) ?
                          (locale.contains('fr')) ?
                          _ville.ville : _ville.ville_ar :
                          "city".tr,
                          searchHint: "select_city".tr,
                          onChanged: (Ville value) async {
                            if (value != null && this._ville.id_ville != value.id_ville) {
                              await PreferenceUtils.setInt(KEY_VILLE_ID, value.id_ville);
                              _ville = value;
                              await appUtils.getHorairePriere(context, value.id_ville);
                              Get.offAll(() => InitialScreen());
                            }
                          },
                          isExpanded: true,
                          clearIcon: Icon(Icons.clear, color: Colors.white),
                        );
                    }
                  },
                )
              ),
            ),

            /*
            ListTile(
              leading: Icon(
                Icons.settings,
                color: Colors.white,
                size: 20,
              ),
              title: Text(
                'method_calculating_prayer'.tr,
                style: GoogleFonts.tajawal(
                  color: Colors.white,
                ),
              ),
              trailing: Theme(
                data: Theme.of(context).copyWith(
                  canvasColor: Colors.black,
                ),
                child: DropdownButton<String>(
                  value: dropDownMethod,
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white,
                  ),
                  iconSize: 24,
                  elevation: 16,
                  style: GoogleFonts.tajawal(
                    color: Colors.black,
                  ),
                  underline: Container(
                    height: 1,
                    color: Colors.white24,
                  ),
                  onChanged: (String newValue) async {
                    dropDownMethod = newValue;
                    print(newValue);
                    if (newValue != await getMethod()) {
                      await setMethod(newValue);
                      await DBProvider.db.deleteAll();
                      Navigator.pushReplacementNamed(
                          context, InitialScreen.route);
                    }
                    setState(() {});
                  },
                  items:
                      methodList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: GoogleFonts.tajawal(color: Colors.white),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

             */
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  DropdownButton<String> dropDownSettings(
      Function callback, String drpDwnVal, List<String> items) {
    return DropdownButton<String>(
      value: drpDwnVal,
      icon: Icon(
        Icons.keyboard_arrow_down,
        color: Colors.white,
      ),
      iconSize: 24,
      elevation: 16,
      style: GoogleFonts.tajawal(
        color: Colors.black,
      ),
      underline: Container(
        height: 1,
        color: Colors.white24,
      ),
      onChanged: (String newValue) async {
       // dropDownLng = newValue;
       Locale locale;
       if (newValue.contains('French')) {
         locale = Locale('fr', 'FR');
         await PreferenceUtils.setString(KEY_LOCALE, 'fr');
       } else {
         locale = Locale('ar', 'AR');
         await PreferenceUtils.setString(KEY_LOCALE, 'ar');
       }
       Get.updateLocale(locale);
       setState(() {});
       print('update lung');
      },
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: GoogleFonts.tajawal(color: Colors.white),
          ),
        );
      }).toList(),
    );
  }
}
