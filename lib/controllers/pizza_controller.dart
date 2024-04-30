import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../data/pizza_data.dart';
import '../data/model/pizza_model.dart';

class PizzaController with ChangeNotifier {
  final PizzaData _pizzaData = PizzaData();
  List<Pizza> _pizzas = [];
  final List<Pizza> _shoppingList = [];

  List<Pizza> get pizzas => _pizzas;
  List<Pizza> get shoppingList => _shoppingList;

  Future<String> _loadFromAsset() async {
    return await rootBundle.loadString("assets/pizza_list.json");
  }

  Future parseJson() async {
    String jsonString = await _loadFromAsset();
    final jsonResponse = jsonDecode(jsonString);
    return jsonResponse;
  }

  Future<void> fetchPizzasFromApi() async {
    parseJson();
    try {
      final pizzasFromApi = await parseJson();
      List<Pizza> pizzas = [];
      pizzasFromApi.map((json) => pizzas.add(Pizza.fromJson(json))).toList();
      for (var element in pizzas) {
        PizzaData.addPizza(element);
      }
      getListFromLocalDataBase();
    } catch (e) {
      print('Failed to fetch pizzas: $e');
    }
  }

  getListFromLocalDataBase() async {
    _pizzas = await PizzaData.getPizzas();
    notifyListeners();
  }

  void addToShoppingList(Pizza pizza) {
    _shoppingList.add(pizza);
    notifyListeners();
  }

  void removeFromShoppingList(Pizza pizza) {
    _shoppingList.remove(pizza);
    notifyListeners();
  }
}
