import 'package:flutter/material.dart';

import '../../../const/const.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Text(
        title,
        style: kTitle,
      ),
    );
  }
}
