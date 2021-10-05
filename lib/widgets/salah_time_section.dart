import 'package:adan/database/app_database.dart';
import 'package:flutter/material.dart';
import 'salah_item_widget.dart';


class SalahTimeSection extends StatelessWidget {
  final List<Salah> list;
  final bool fromHome;
  const SalahTimeSection({
    Key key, @required this.list,
    this.fromHome}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext ctx, int index) {
          return SalahItemWidget(
            salah: list[index],
            fromHome: fromHome,
          );
        },
        separatorBuilder: (BuildContext ctx, int index) {
          return SizedBox(
            height: 6,
          );
        },
        itemCount: list.length,
      ),
    );
  }
}