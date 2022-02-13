import 'package:flutter/material.dart';
import 'package:local_farm/widgets/custom_tab.dart';

abstract class TabView {
  const TabView({Key? key, required this.child, required this.customTab});
  final Widget child;
  final CustomTab customTab;
}
