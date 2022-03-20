import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:local_farm/const/const.dart';
import 'package:local_farm/core/firebase_repository.dart';
import 'package:local_farm/core/models/introduction.dart';

class IntroductionView extends StatelessWidget {
  const IntroductionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30),
      // color: kLightGreenColor.withOpacity(0.3),
      color: kPrimaryColor.withOpacity(0.1),
      width: MediaQuery.of(context).size.width,
      child: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...FirebaseRepository().introductionList.map(
                  (e) => Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: const BoxDecoration(
                          border: Border(
                              right:
                                  BorderSide(color: Colors.white, width: 3))),
                      child: _section(e),
                    ),
                  ),
                )
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
            style: kTitle,
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
}
