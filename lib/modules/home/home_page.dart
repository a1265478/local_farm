import 'package:flutter/material.dart';
import 'package:local_farm/modules/contact_us/contact_us_section.dart';
import 'package:local_farm/modules/home/components/footer.dart';
import 'package:local_farm/modules/service_item/service_item_section.dart';
import 'package:local_farm/widgets/go_top_button.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../const/const.dart';
import '../Introduction/Introduction_view.dart';
import '../customer/customer_section.dart';
import '../line_content/line_content_view.dart';
import '../slide_banner/slide_banner.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.isDesktop}) : super(key: key);
  final bool isDesktop;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  final Map<String, Widget> items = const {
    "Home": SlideBanner(),
    "公司簡介": IntroductionView(),
    "LINE圖文": LineContentView(),
    "服務項目": ServiceItemSection(),
    "客戶專區產品展示(道之驛)地產地銷": CustomerSection(),
    "聯絡我們": ContactUsSection(),
    "": Footer(),
  };

  var scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 0;
  @override
  void initState() {
    itemPositionsListener.itemPositions.addListener(() {
      final indices = itemPositionsListener.itemPositions.value
          .where((element) {
            // print(
            //     "${element.index} ${element.itemLeadingEdge} : ${element.itemTrailingEdge}");

            return element.itemLeadingEdge >= 0;
          })
          .map((e) => e.index)
          .toList();

      if (indices.isNotEmpty) {
        setState(() {
          _currentIndex = indices.first;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      key: scaffoldKey,
      drawer: widget.isDesktop ? null : _drawer(),
      appBar: widget.isDesktop ? _desktopAppBar() : _mobileAppBar(),
      floatingActionButton: GoTopButton(
        scrollTop: () {
          itemScrollController.scrollTo(
              index: 0, duration: const Duration(milliseconds: 300));
        },
      ),
      body: ScrollablePositionedList.builder(
        itemCount: items.length,
        itemBuilder: (context, index) => items[items.keys.toList()[index]]!,
        itemScrollController: itemScrollController,
        itemPositionsListener: itemPositionsListener,
      ),
    );
  }

  Widget _drawer() => Drawer(
        child: ListView(
          children: List.generate(
            items.length - 1,
            (index) => ListTile(
              selected: index == _currentIndex,
              selectedTileColor: kNavBarBackgoundColor,
              title: Text(
                items.keys.toList()[index],
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: index == _currentIndex
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: index == _currentIndex
                        ? Colors.black
                        : Colors.black.withOpacity(0.6)),
              ),
              onTap: () {
                itemScrollController.scrollTo(
                    index: index, duration: const Duration(milliseconds: 300));
                Navigator.pop(context);
              },
            ),
          ),
        ),
      );

  PreferredSizeWidget _desktopAppBar() => AppBar(
        backgroundColor: kNavBarBackgoundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ...List.generate(
              items.length - 1,
              (index) => TextButton(
                onPressed: () {
                  itemScrollController.scrollTo(
                      index: index,
                      duration: const Duration(milliseconds: 300));
                },
                child: Text(
                  items.keys.toList()[index],
                  style: TextStyle(
                    color: _currentIndex == index
                        ? Colors.black
                        : Colors.black.withOpacity(0.8),
                    fontWeight: _currentIndex == index
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
            )
          ],
        ),
      );

  PreferredSizeWidget _mobileAppBar() => AppBar(
        backgroundColor: kNavBarBackgoundColor,
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.black,
          ),
          onPressed: () {
            scaffoldKey.currentState?.openDrawer();
          },
        ),
      );
}
