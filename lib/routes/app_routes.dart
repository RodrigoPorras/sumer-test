import 'package:flutter/material.dart';
import 'package:sumer_test/screens/home/home.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  HomeUI.path: (_) => HomeUI(),
};
