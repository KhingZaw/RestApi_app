import 'dart:convert';
import 'package:drivers_app/models/item_model.dart';
import 'package:http/http.dart' as http;

class ItemService {
  final String baseUrl = "https://api.restful-api.dev/";

  /// Get all item data
  Future<List<ItemModel>> getAllItemData() async {
    List<ItemModel> allItems = [];
    try {
      var response = await http.get(Uri.parse("$baseUrl/objects"));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        for (var item in data) {
          allItems.add(ItemModel.fromJson(item));
        }
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return allItems;
  }

  /// Create a new item (POST Request)
  Future<ItemModel?> createItem(String name, int year, double price,
      String cpuModel, String hardDiskSize, String? color) async {
    try {
      var response = await http.post(
        Uri.parse("$baseUrl/objects"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": name,
          "data": {
            "year": year,
            "price": price,
            "CPU model": cpuModel,
            "Hard disk size": hardDiskSize,
          }
        }),
      );
      // print("response post:${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        var responseData = jsonDecode(response.body);
        return ItemModel.fromJson(responseData); // Return the created item
      } else {
        throw Exception("Failed to create item: ${response.body}");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Update an existing item (PUT Request)
  Future<ItemModel?> updateItem(String id, String name, int year, double price,
      String cpuModel, String hardDiskSize, String color) async {
    try {
      var response = await http.put(
        Uri.parse("$baseUrl/objects/$id"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": name,
          "data": {
            "year": year,
            "price": price,
            "CPU model": cpuModel,
            "Hard disk size": hardDiskSize,
            "color": color
          }
        }),
      );
      print("response put:${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        var responseData = jsonDecode(response.body);
        return ItemModel.fromJson(responseData); // Return the updated item
      } else {
        throw Exception("Failed to update item: ${response.body}");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Delete Item by ID
  Future<bool> deleteItem(String id) async {
    try {
      var response = await http.delete(Uri.parse("$baseUrl/objects/$id"));
      print("delete response:${response.body}");
      if (response.statusCode == 200) {
        print("Deletion successful");
        return true; // Deletion successful
      } else {
        print("Deletion failed");
        return false; // Deletion failed
      }
    } catch (e) {
      throw Exception("Error deleting item: $e");
    }
  }
}
