import 'package:flutter/material.dart';
import 'package:local_farm/modules/Introduction/introduction_view.dart';
import 'package:local_farm/modules/line_content/line_content_view.dart';
import 'package:local_farm/modules/slide_banner/slide_banner.dart';
import 'package:local_farm/widgets/go_top_button.dart';

import 'components/footer.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: const GoTopButton(),
      body: SingleChildScrollView(
        key: const PageStorageKey("HOME"),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            SlideBanner(),
            IntroductionView(),
            LineContentView(),
            SizedBox(height: 1500),
            Footer(),
          ],
        ),
      ),
    );
  }
}
