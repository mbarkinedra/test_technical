import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:test_technical/view/screens/pizza_screen.dart';

import 'controllers/pizza_controller.dart';
import 'data/model/pizza_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter(); // Initialize Hive
  //await Hive.initFlutter("hive_db");
  Hive.registerAdapter<Pizza>(PizzaAdapter());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PizzaController(),
      child: MaterialApp(
        title: 'Pizza App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const PizzaScreen(),
      ),
    );
  }
}
