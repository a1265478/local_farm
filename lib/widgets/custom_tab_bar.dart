import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    Key? key,
    required this.controller,
    required this.tabs,
    required this.onTapEvent,
  }) : super(key: key);

  final TabController controller;
  final List<Widget> tabs;
  final Function(int) onTapEvent;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double tabBarScale = screenWidth > 1400
        ? 0.7
        : screenWidth > 1100
            ? 0.8
            : 0.85;
    return SizedBox(
      width: screenWidth * tabBarScale,
      height: 50,
      child: TabBar(
        controller: controller,
        tabs: tabs,
        onTap: onTapEvent,
      ),
    );
  }
}
