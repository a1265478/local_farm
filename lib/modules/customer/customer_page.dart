import 'package:flutter/material.dart';
import 'package:local_farm/core/tab_view.dart';
import 'package:local_farm/widgets/custom_tab.dart';

class CustomerPage extends StatelessWidget implements TabView {
  const CustomerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          customTab,
          Expanded(
            child: child,
          ),
        ],
      ),
    );
  }

  @override
  Widget get child => const Center(
        child: Text("Customer"),
      );

  @override
  CustomTab get customTab => const CustomTab(title: "客戶專區");
}
