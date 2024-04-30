import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/pizza_model.dart';

class ApiService {
  static const String baseUrl = 'https://pizza-and-desserts.p.rapidapi.com/pizzas';
  static const Map<String, String> headers = {
    'X-RapidAPI-Key': '64e4b57ebfmsh46bf2a30b50fd90p1bd0efjsn16b7edde7207',
    'X-RapidAPI-Host': 'pizza-and-desserts.p.rapidapi.com'
  };

  static Future<List<Pizza>> fetchPizzas() async {
    final response = await http.get(Uri.parse(baseUrl), headers: headers);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      print("object $data");
      return data.map((json) => Pizza.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load pizzas');
    }
  }
}
