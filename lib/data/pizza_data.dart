import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:test_technical/data/model/pizza_model.dart';

class PizzaData {
  static const  boxName = 'pizzaBox';

 static Future<void> savePizzas(List<Pizza> pizzas) async {

    final box = await Hive.openBox<Pizza>("boxName");
    await box.clear();
    await box.addAll(pizzas);
  }

  static Future<List<Pizza>> getPizzas() async {

    final box = await Hive.openBox<Pizza>( "boxName");
    return box.values.toList();
  }

  static Future<void> addPizza(Pizza pizza) async {

    final box = await Hive.openBox<Pizza>( "boxName");
    await box.put(pizza.id,pizza);
  }

  static Future<void> removePizza(Pizza pizza) async {
   // Hive.initFlutter("hive_db");
   // Hive.registerAdapter<Pizza>(PizzaAdapter());
    final box = await Hive.openBox<Pizza>("boxName");
    await box.delete(pizza.id);
  }

  static Future<void> updatePizza(Pizza updatedPizza) async {
    Hive.initFlutter("hive_db");
    Hive.registerAdapter<Pizza>(PizzaAdapter());
    final box = await Hive.openBox<Pizza>("boxName");
    await box.put(updatedPizza.id, updatedPizza);
  }
}
