import 'package:flutter/material.dart';
import 'package:local_farm/const/const.dart';
import '../home/components/section_title.dart';
import 'widget/line_content_wrap.dart';

class LineContentView extends StatelessWidget {
  const LineContentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 40),
      // color: kPrimaryColor.withOpacity(0.2),
      color: kRegularGreenColor.withOpacity(0.3),
      child: Column(
        children: const [
          SectionTitle(title: "LINE圖文"),
          LineContentWrap(),
        ],
      ),
    );
  }
}
