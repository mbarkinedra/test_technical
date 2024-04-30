import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/pizza_controller.dart';

class ShoppingListScreen extends StatelessWidget {
  const ShoppingListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pizzaController = Provider.of<PizzaController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping List'),
      ),
      body: ListView.builder(
        itemCount: pizzaController.shoppingList.length,
        itemBuilder: (context, index) {
          final pizza = pizzaController.shoppingList[index];
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
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                '\$${pizza.price}',
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
              trailing: IconButton(
                icon: Icon(Icons.remove_shopping_cart),
                onPressed: () {
                  pizzaController.removeFromShoppingList(pizza);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Removed from shopping list'),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
