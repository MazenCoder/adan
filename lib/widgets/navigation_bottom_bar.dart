import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'nav_bar_item.dart';



class NavigationBar extends StatefulWidget {
  final Function callback;
  final String selectedItem;
  final double screenHeight;

  NavigationBar({
    @required this.callback,
    @required this.selectedItem,
    @required this.screenHeight,
  });

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/bg.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: BlurryContainer(
        height: widget.screenHeight * .09,
        padding: EdgeInsets.all(0),
        blur: 10,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(0),
          topRight: Radius.circular(0),
        ),
        bgColor: Color(0xFF746F78),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              RawMaterialButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                constraints: BoxConstraints(),
                onPressed: () {
                  widget.callback('home'.tr);
                },
                child: NavBarItem(
                  icon: Icons.home,
                  name: 'home'.tr,
                  selectedItem: widget.selectedItem,
                ),
              ),
              RawMaterialButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                constraints: BoxConstraints(),
                onPressed: () {
                  widget.callback('calendar');
                },
                child: NavBarItem(
                  icon: Icons.calendar_today_outlined,
                  name: 'calendar',
                  selectedItem: widget.selectedItem,
                ),
              ),
              RawMaterialButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                constraints: BoxConstraints(),
                onPressed: () {
                  widget.callback('navigation');
                },
                child: NavBarItem(
                  icon: Icons.navigation,
                  name: 'navigation',
                  selectedItem: widget.selectedItem,
                ),
              ),
              RawMaterialButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                constraints: BoxConstraints(),
                onPressed: () {
                  widget.callback('settings');
                },
                child: NavBarItem(
                  icon: Icons.settings,
                  name: 'settings',
                  selectedItem: widget.selectedItem,
                ),
              ),
              RawMaterialButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                constraints: BoxConstraints(),
                onPressed: () {
                  widget.callback('info');
                },
                child: NavBarItem(
                  icon: Icons.info_outline,
                  name: 'info',
                  selectedItem: widget.selectedItem,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}