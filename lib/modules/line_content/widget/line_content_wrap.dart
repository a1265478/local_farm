import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:local_farm/core/firebase_repository.dart';

class LineContentWrap extends StatelessWidget {
  const LineContentWrap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ScrollController(),
      child: Wrap(
        runSpacing: 20,
        spacing: 20,
        children: [
          ...FirebaseRepository().lineContent.map(
                (e) => SizedBox(
                  width: MediaQuery.of(context).size.width / 4 < 300
                      ? MediaQuery.of(context).size.width < 300
                          ? MediaQuery.of(context).size.width * 0.85
                          : 300
                      : MediaQuery.of(context).size.width / 4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.memory(
                      base64Decode(e.base64),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
        ],
      ),
    );
  }
}
