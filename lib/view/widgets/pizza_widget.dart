import 'package:flutter/material.dart';

import '../../controllers/pizza_controller.dart';
import '../../data/model/pizza_model.dart';
import '../../data/pizza_data.dart';
import '../screens/shopping_list_Screen.dart';


class PizzaTile extends StatelessWidget {
  final Pizza pizza;
  final PizzaController controller;

  const PizzaTile({
    required this.pizza,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), // Adjust the border radius as needed
            image: DecorationImage(
              image: NetworkImage(pizza.img),
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(
          pizza.name,
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          '${pizza.description}\nPrice: \$${pizza.price}',
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: controller.shoppingList.contains(pizza)
                  ? const Icon(Icons.remove_shopping_cart, color: Colors.red)
                  : const Icon(Icons.add_shopping_cart, color: Colors.green),
              onPressed: () {
                if (controller.shoppingList.contains(pizza)) {
                  controller.removeFromShoppingList(pizza);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Removed from shopping list'),
                    ),
                  );
                } else {
                  controller.addToShoppingList(pizza);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Added to shopping list'),
                    ),
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ShoppingListScreen(),
                    ),
                  );
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Delete Pizza?'),
                      content: Text('Are you sure you want to delete ${pizza.name}?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            PizzaData.removePizza(pizza);
                            controller.notifyListeners();
                            controller.getListFromLocalDataBase();
                            Navigator.of(context).pop();
                          },
                          child: const Text('Delete'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
