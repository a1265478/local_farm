import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:local_farm/const/const.dart';
import 'package:local_farm/core/firebase_repository.dart';
import 'package:local_farm/modules/customer/model/customer.dart';
import 'package:local_farm/modules/home/components/footer.dart';
import 'dart:html' as html;

import 'package:shimmer/shimmer.dart';

class CustomerDetail extends StatelessWidget {
  const CustomerDetail({
    Key? key,
    required this.customer,
  }) : super(key: key);
  final Customer customer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kNavBarBackgoundColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    customer.name,
                    style: kTitle,
                  ),
                  const Divider(
                    thickness: 3,
                    color: kDarkGreenColor,
                    height: 50,
                  ),
                  Builder(builder: (context) {
                    return LayoutBuilder(
                      builder: (context, constrains) {
                        if (constrains.maxWidth > 768) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: TextDetail(
                                  customer: customer,
                                ),
                              ),
                              const SizedBox(width: 20),
                              Flexible(
                                child: ShowCase(
                                  customer: customer,
                                ),
                              ),
                            ],
                          );
                        }
                        return Column(
                          children: [
                            FirebaseRepository().customThumbnail[customer.id] ==
                                    null
                                ? const SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: Image.memory(
                                      base64Decode(
                                        FirebaseRepository()
                                            .customThumbnail[customer.id],
                                      ),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                            TextDetail(customer: customer),
                            const Divider(
                              thickness: 3,
                              color: kDarkGreenColor,
                              height: 50,
                            ),
                            ShowCase(customer: customer),
                          ],
                        );
                      },
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShowCase extends StatelessWidget {
  const ShowCase({
    Key? key,
    required this.customer,
  }) : super(key: key);
  final Customer customer;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        FutureBuilder<List<String>>(
          future: FirebaseRepository().loadImageList(customer.id),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (_, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Shimmer(
                    child: Container(
                      color: Colors.black,
                      height: 200,
                    ),
                    gradient: LinearGradient(
                      colors: [
                        kPrimaryColor.withOpacity(0.7),
                        kPrimaryColor.withOpacity(0.4),
                        kPrimaryColor.withOpacity(0.3),
                        kPrimaryColor.withOpacity(0.4),
                        kPrimaryColor.withOpacity(0.7),
                      ],
                    ),
                  ),
                ),
              );
            }
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (_, index) => Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.memory(
                  base64Decode(
                    snapshot.data![index],
                  ),
                  fit: BoxFit.contain,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class TextDetail extends StatelessWidget {
  const TextDetail({
    Key? key,
    required this.customer,
  }) : super(key: key);
  final Customer customer;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          "品牌介紹",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          customer.brandIntroduction,
          style: const TextStyle(fontSize: 18),
        ),
        const Divider(
          thickness: 3,
          height: 100,
          color: kDarkGreenColor,
        ),
        const Text(
          "網頁設計案例介紹",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          customer.designIntroduction,
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 50),
        InkWell(
          onTap: () {
            html.window.open(customer.webUrl, "_blank");
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: kDarkGreenColor,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(12),
            child: const Text(
              "查看案例網址",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
