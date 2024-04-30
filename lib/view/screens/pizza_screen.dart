import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/pizza_controller.dart';
import '../widgets/pizza_widget.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'shopping_list_screen.dart';

class PizzaScreen extends StatelessWidget {
  const PizzaScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final pizzaController = Provider.of<PizzaController>(context, listen: false);
    pizzaController.fetchPizzasFromApi();

    String searchWord = '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pizza Shopping'),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ShoppingListScreen()),
                  );
                },
              ),
              Positioned(
                right: 5,
                top: 5,
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Consumer<PizzaController>(
                    builder: (context, controller, child) {
                      int itemCount = controller.shoppingList.length;
                      return Text(
                        itemCount.toString(),
                        style: TextStyle(color: Colors.white),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),

        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                searchWord = value;
                pizzaController.notifyListeners();
              },
              decoration: InputDecoration(
                hintText: 'Search for pizza...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: Consumer<PizzaController>(
              builder: (context, controller, child) {
                if (controller.pizzas.isEmpty) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
                    itemCount: controller.pizzas.length,
                    itemBuilder: (context, index) {
                      final pizza = controller.pizzas[index];
                      if (pizza.name.toLowerCase().contains(searchWord.toLowerCase())) {
                        return PizzaTile(
                          pizza: pizza,
                          controller: controller,
                        );
                      } else {
                        return SizedBox();
                      }
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
