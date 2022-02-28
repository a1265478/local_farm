import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:local_farm/const/const.dart';
import 'package:local_farm/core/firebase_repository.dart';
import 'package:local_farm/core/models/introduction.dart';

class IntroductionView extends StatelessWidget {
  const IntroductionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final List<Introduction> introductionList = getIntroductionList();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30),
      color: kPrimaryColor,
      width: MediaQuery.of(context).size.width,
      child: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: const BoxDecoration(
                    border: Border(
                        right: BorderSide(color: Colors.white, width: 3))),
                child: _section(introductionList[0]),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: const BoxDecoration(
                    border: Border(
                        right: BorderSide(color: Colors.white, width: 3))),
                child: _section(introductionList[1]),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: _section(introductionList[2]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _section(Introduction introduction) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          AutoSizeText(
            introduction.title,
            maxLines: 1,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
            maxFontSize: 26,
          ),
          const SizedBox(height: 10),
          ...List.generate(
            introduction.items.split("\n").length,
            (index) => AutoSizeText(
              introduction.items.split("\n")[index],
              style: const TextStyle(fontSize: 18),
              maxLines: 1,
              maxFontSize: 18,
            ),
          ),
          const SizedBox(height: 10),
        ],
      );

  List<Introduction> getIntroductionList() {
    final data = FirebaseRepository().data["introduction"] as List;

    final List<Introduction> introductionList =
        data.map((data) => Introduction.fromJson(data)).toList();

    return introductionList;
  }

  Widget _divider() => const VerticalDivider(
        thickness: 3,
        endIndent: 10,
        indent: 10,
        color: Colors.white,
      );
}
