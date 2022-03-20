import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:local_farm/const/const.dart';
import 'package:local_farm/modules/home/components/section_title.dart';
import 'package:local_farm/modules/service_item/model/service.dart';

import '../../core/firebase_repository.dart';

class ServiceItemSection extends StatelessWidget {
  const ServiceItemSection({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPrimaryColor.withOpacity(0.1),
      padding: const EdgeInsets.only(bottom: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: "服務項目"),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _part(context, "LINE", FirebaseRepository().serviceList),
                const SizedBox(height: 20),
                _part(context, "Web", FirebaseRepository().serviceList),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _serviceContainer(BuildContext context, Service service) => Container(
        height: 650,
        padding: const EdgeInsets.all(10),
        constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width / 3.5 < 250
                ? MediaQuery.of(context).size.width * 0.85
                : MediaQuery.of(context).size.width / 3.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: kDarkGreenColor.withOpacity(0.3), width: 3),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: kDarkGreenColor.withOpacity(0.8),
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Text(
                service.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
            ),
            Expanded(
              child: Container(
                  color: kPrimaryColor.withOpacity(0.3),
                  child: Column(
                    children: [
                      ...service.content.split("\n").map((e) => _listTile(e)),
                    ],
                  )),
            ),
            Container(
              color: kPrimaryColor.withOpacity(0.8),
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Text(
                "NT\$ ${NumberFormat("#,##0", "zh-TW").format(service.price)}",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
          ],
        ),
      );

  Widget _listTile(String content) => ListTile(
        leading: const Icon(
          Icons.star,
          size: 16,
        ),
        title: Text(
          content,
          style: const TextStyle(fontSize: 18),
        ),
      );

  Widget _part(BuildContext context, String type, List<Service> serviceList) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(type, style: kTitle.copyWith(fontSize: 20)),
          const SizedBox(height: 10),
          Flexible(
            child: Wrap(
              spacing: 20,
              runSpacing: 10,
              children: [
                ...serviceList.where((element) => element.type == type).map(
                      (e) => _serviceContainer(context, e),
                    ),
              ],
            ),
          ),
        ],
      );
}
