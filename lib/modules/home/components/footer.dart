import 'package:flutter/material.dart';
import 'package:local_farm/const/const.dart';
import 'package:local_farm/core/firebase_repository.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          alignment: Alignment.center,
          color: kDarkGreenColor.withOpacity(0.8),
          child: const Text(
            "公司名稱",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          alignment: Alignment.center,
          color: kDarkGreenColor.withOpacity(0.8),
          child: Wrap(
            spacing: 20,
            runSpacing: 20,
            children: [
              Text("地址：${FirebaseRepository().info.address}"),
              Text("公司電話：${FirebaseRepository().info.phone}"),
              Text("行動電話：${FirebaseRepository().info.mobilePhone}"),
              Text("Email：${FirebaseRepository().info.email}"),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          alignment: Alignment.center,
          color: kNavBarBackgoundColor,
          child: const Text("Copyright © 2022 All Rights Reserved."),
        ),
      ],
    );
  }
}
