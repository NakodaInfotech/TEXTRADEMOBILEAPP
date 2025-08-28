import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:textrade/Common/Constants.dart';
import 'package:textrade/HomeScreen/HomeScreen.dart';
import 'package:textrade/Outstanding/Outstanding.dart';
import 'package:textrade/Reports/Reports.dart';

class TabBar extends StatefulWidget {
  int selectedIndex = 1;
  TabBar({Key? key}) : super(key: key);

  @override
  State<TabBar> createState() => _TabBarState();
}

class _TabBarState extends State<TabBar> {
  List<Widget>? _children;

  @override
  void initState() {
    _children = [
      OutstandingScreen(),
      HomeScreen(),
      ReportScreen(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _children![widget.selectedIndex],
        bottomNavigationBar: ConvexAppBar(
          height: 55,
          curveSize: 80,
          style: TabStyle.reactCircle,
          top: -20,
          backgroundColor: Colors.white,
          color: appColor,
          activeColor: appColor,
          items: [
            TabItem(
              title: "Outstanding",
              icon: Image.asset(
                "assets/Outstanding.png",
                color: (widget.selectedIndex == 0) ? Colors.black : appColor,
              ),
            ),
            TabItem(
                title: "Dashboard",
                icon: Image.asset(
                  "assets/Dashboard.png",
                  color: (widget.selectedIndex == 1) ? Colors.black : appColor,
                )),
            TabItem(
                title: "Reports",
                icon: Image.asset(
                  "assets/Reports.png",
                  color: (widget.selectedIndex == 2) ? Colors.black : appColor,
                )),
          ],
          initialActiveIndex: 1,
          onTap: (index) {
            setState(() {
              widget.selectedIndex = index;
            });
          },
        ));
  }
}
