import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveExamplePage extends StatefulWidget {
  @override
  _HiveExamplePageState createState() => _HiveExamplePageState();
}

class _HiveExamplePageState extends State<HiveExamplePage> {
  @override
  void initState() {
    initializeHive();
    super.initState();
  }

  void initializeHive() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ElevatedButton(child: Text('Guardar'), onPressed: saveItem),
            ElevatedButton(child: Text('Cargar'), onPressed: loadItem),
          ],
        ),
      ),
    );
  }

  void saveItem() async {
    final box = await Hive.openBox<String>('myBox');
    await box.put('TITLE', 'CUBIPOOL');
  }

  void loadItem() async {
    final box = await Hive.openBox<String>('myBox');
    print(box.get('TITLE'));
  }
}
