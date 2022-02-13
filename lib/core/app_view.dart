import 'package:flutter/material.dart';
import 'package:local_farm/const/const.dart';
import 'package:local_farm/core/tab_view.dart';
import 'package:local_farm/modules/Introduction/Introduction_view.dart';
import 'package:local_farm/modules/contact_us/contact_us_page.dart';
import 'package:local_farm/modules/customer/customer_page.dart';
import 'package:local_farm/modules/download/download_page.dart';
import 'package:local_farm/modules/home/home_page.dart';
import 'package:local_farm/modules/line_content/line_content_view.dart';
import 'package:local_farm/modules/member/member_page.dart';
import 'package:local_farm/modules/search/search_page.dart';
import 'package:local_farm/modules/service_items/service_items_view.dart';
import 'package:local_farm/widgets/custom_tab_bar.dart';

class AppView extends StatefulWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> with SingleTickerProviderStateMixin {
  late TabController tabController;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  int currentIndex = 0;

  final List<TabView> views = const [
    HomePage(),
    IntroductionView(),
    LineContentView(),
    ServiceItemsView(),
    CustomerPage(),
    MemberPage(),
    ContactUsPage(),
    SearchPage(),
    DownloadPage(),
  ];

  @override
  void initState() {
    tabController = TabController(length: views.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(),
      drawerEnableOpenDragGesture: false,
      key: scaffoldKey,
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 955) {
            return desktopView();
          } else {
            return mobileView();
          }
        },
      ),
    );
  }

  Widget desktopView() => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            color: kNavBarBackgoundColor,
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    tabController.animateTo(0);
                  },
                  child: Container(
                    width: 100,
                    height: 50,
                    alignment: Alignment.center,
                    child: const Text("LOGO"),
                  ),
                ),
                const Spacer(),
                CustomTabBar(
                  controller: tabController,
                  tabs: views.map((e) => e.customTab).toList(),
                  onTapEvent: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: views.map((e) => e.child).toList(),
            ),
          ),
        ],
      );

  Widget mobileView() => SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: kNavBarBackgoundColor,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      scaffoldKey.currentState?.openDrawer();
                    },
                    icon: Icon(Icons.menu),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: views.map((e) => e.child).toList(),
              ),
            ),
          ],
        ),
      );

  Widget drawer() => Drawer(
        child: ListView(
          children: List.generate(
            views.length,
            (index) => ListTile(
              selected: index == currentIndex,
              selectedTileColor: kNavBarBackgoundColor,
              title: Text(
                views[index].customTab.title,
              ),
              onTap: () {
                tabController.animateTo(index);
                setState(() {
                  currentIndex = index;
                });
                Navigator.pop(context);
              },
            ),
          ),
        ),
      );
}
