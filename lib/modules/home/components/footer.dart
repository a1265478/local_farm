import 'package:flutter/material.dart';
import 'package:local_farm/const/const.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: kNavBarBackgoundColor,
      height: 50,
      child: Text("Copyright"),
    );
  }
}
