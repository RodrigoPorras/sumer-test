import 'package:flutter/material.dart';
import 'package:sumer_test/settings/dependency_inyection.dart';

import 'app/app.dart';

void main() async {
  await setupDependencyInjection();

  runApp(const App());
}
