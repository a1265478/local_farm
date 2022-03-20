import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:local_farm/const/const.dart';
import 'package:local_farm/modules/customer/customer_detail.dart';
import 'package:local_farm/modules/customer/model/customer.dart';
import 'package:local_farm/modules/home/components/section_title.dart';
import '../../core/firebase_repository.dart';

class CustomerSection extends StatelessWidget {
  const CustomerSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final customerList = FirebaseRepository().customerList;
    return Container(
      color: kRegularGreenColor.withOpacity(0.3),
      padding: const EdgeInsets.only(bottom: 40),
      child: Column(
        children: [
          const SectionTitle(title: "客戶專區產品展示(道之驛)地產地銷"),
          Wrap(
            runSpacing: 20,
            spacing: 20,
            children: [
              ...customerList.map(
                (e) => CustomThumbnail(customer: e),
              ),
            ],
          ),
          // if (customerList.length > 6)
          //   Padding(
          //     padding: const EdgeInsets.only(top: 40),
          //     child: InkWell(
          //       onTap: () {},
          //       child: Container(
          //         decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(10),
          //           color: kDarkGreenColor,
          //         ),
          //         padding:
          //             const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
          //         child: const Text(
          //           "More",
          //           style: TextStyle(
          //             fontSize: 20,
          //             color: Colors.white,
          //             fontWeight: FontWeight.bold,
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
        ],
      ),
    );
  }
}

class CustomThumbnail extends StatefulWidget {
  const CustomThumbnail({Key? key, required this.customer}) : super(key: key);
  final Customer customer;
  @override
  State<CustomThumbnail> createState() => _CustomThumbnailState();
}

class _CustomThumbnailState extends State<CustomThumbnail> {
  bool _isHover = false;
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width / 4 < 300
        ? MediaQuery.of(context).size.width < 300
            ? MediaQuery.of(context).size.width * 0.85
            : 300
        : MediaQuery.of(context).size.width / 4;
    return InkWell(
      onHover: (isHover) {
        setState(() {
          _isHover = isHover;
        });
      },
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CustomerDetail(
              customer: widget.customer,
            ),
          ),
        );
      },
      child: SizedBox(
        width: width,
        height: width / 4 * 3,
        child: Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FirebaseRepository().customThumbnail[widget.customer.id] !=
                      null
                  ? Image.memory(
                      base64Decode(FirebaseRepository()
                          .customThumbnail[widget.customer.id]),
                      fit: BoxFit.cover,
                    )
                  : const Icon(Icons.error),
            ),
            if (_isHover)
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.center,
                  color: Colors.black.withOpacity(0.4),
                  child: Text(
                    widget.customer.name,
                    maxLines: 3,
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
