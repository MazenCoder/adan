import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:adan/initial_app/data/models/ville_model.dart';
import 'package:adan/database/app_database.dart';
import 'package:adan/usecases/flash_helper.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:adan/screens/home_page.dart';
import 'package:adan/helpers/app_utils.dart';
import 'package:adan/mobx/mobx_app.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:get/get.dart';



class BuildLoadedApp extends StatelessWidget {
  final VilleModel model;
  BuildLoadedApp({this.model, Key key}) : super(key: key);

  final TextEditingController _search = TextEditingController();
  final AppUtils appUtils = GetIt.I.get<AppUtils>();
  final MobxApp _mobx = MobxApp();
  int idVille = 1;


  @override
  Widget build(BuildContext context) {
    final db = Provider.of<AppDatabase>(context);
    final locale = Get.locale.languageCode;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text('choose_city'.tr,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 14
              ),
            ),
            IconButton(
              icon: Icon(Icons.check),
              onPressed: () async {
                if (_mobx.index != null) {
                  await appUtils.getHorairePriere(context, idVille).then((value) {
                    if (value??false) {
                      Get.offAll(() => HomePage());
                    }
                  });
                } else {
                  FlashHelper.infoBar(context, message: 'choose_city'.tr);
                }
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "Search",
                          fillColor: Colors.blue,
                          prefixIcon: Icon(Icons.search,
                            color: Colors.grey,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          hintStyle: TextStyle(
                            color: Colors.grey.shade400
                          )
                      ),
                      controller: _search,
                      onChanged: _mobx.setQuery,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: IconButton(
                          icon: Icon(MdiIcons.close,
                            color: Colors.grey.shade700,
                          ),
                          onPressed: () {
                            _mobx.setQuery('');
                            _search.clear();
                          }
                      )
                  ),
                ],
              )
          ),
          Expanded(
            child: Observer(
              builder: (_) {
                return StreamBuilder<List<Ville>>(
                  stream: db.villesDao.watchAllVilleByQuery(_mobx.query),
                  builder: (context, snapshot) {
                    switch(snapshot.connectionState) {
                      case ConnectionState.waiting: return Center(
                        child: CircularProgressIndicator(),
                      );
                      default:
                        final ville = snapshot.data ?? [];
                        return ListView.builder(
                          itemCount: ville?.length??0,
                          itemBuilder: (context, index) {
                            if (locale.contains('fr')) {
                              return Observer(
                                builder: (_) => Card(
                                  color: (_mobx.index == index) ? Colors.blue.shade200 : null,
                                  child: ListTile(
                                    onTap: () {
                                      this.idVille = ville[index].id_ville;
                                      _mobx.setIndex(index);
                                    },
                                    title: Text('${ville[index].ville}',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: (_mobx.index == index) ? Colors.white : null,
                                      ),
                                    ),
                                    trailing: (_mobx.index == index) ?
                                    Icon(Icons.check_circle_outline_rounded, color: Colors.white) :
                                    Icon(MdiIcons.checkboxBlankCircleOutline),
                                  ),
                                ),
                              );
                            } else {
                              return Observer(
                                builder: (_) => Card(
                                  color: (_mobx.index == index) ? Colors.blue.shade200 : null,
                                  child: ListTile(
                                    onTap: () {
                                      this.idVille = ville[index].id_ville;
                                      _mobx.setIndex(index);
                                    },
                                    title: Text('${ville[index].ville_ar}',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: (_mobx.index == index) ? Colors.white : null,
                                      ),
                                    ),
                                    trailing: (_mobx.index == index) ?
                                    Icon(Icons.check_circle_outline_rounded, color: Colors.white) :
                                    Icon(MdiIcons.checkboxBlankCircleOutline),
                                  ),
                                ),
                              );
                            }
                          },
                        );
                    }
                  },
                );
              },
            )
          ),
        ],
      )
    );
  }
}

/*
class LoadedTopProducts extends StatefulWidget {
  final TopProductsModel model;
  final BuildContext context;
  LoadedTopProducts({this.model, this.context});

  @override
  _LoadedTopProductsState createState() => _LoadedTopProductsState();
}

class _LoadedTopProductsState extends State<LoadedTopProducts> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 1),
      () => Navigator.of(widget.context).pushReplacement(MaterialPageRoute(
         builder: (BuildContext context) => NavigationApp())));
  }

  @override
  Widget build(BuildContext context) {
    return LoadingApp();
  }
}

 */