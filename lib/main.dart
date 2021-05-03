import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'injection_container.dart' as di;
import 'package:cubipool2/core/pages/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Dependency injection
  await di.init();

  // Hive
  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);

  runApp(
    ProviderScope(
      child: MainPage(),
    ),
  );
}
