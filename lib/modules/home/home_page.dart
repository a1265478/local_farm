import 'package:flutter/material.dart';
import 'package:local_farm/core/tab_view.dart';
import 'package:local_farm/modules/Introduction/Introduction_tab_view.dart';
import 'package:local_farm/modules/Introduction/Introduction_view.dart';
import 'package:local_farm/modules/home/components/footer.dart';
import 'package:local_farm/modules/slide_banner/slide_banner.dart';
import 'package:local_farm/widgets/custom_tab.dart';

class HomePage extends StatelessWidget implements TabView {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          customTab,
          Expanded(
            child: child,
          ),
        ],
      ),
    );
  }

  @override
  Widget get child => _View();

  @override
  CustomTab get customTab => CustomTab(title: "Home");
}

class _View extends StatelessWidget {
  const _View({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: const [
          SlideBanner(),
          IntroductionView(),
          SizedBox(height: 500),
          Footer(),
        ],
      ),
    );
  }
}
