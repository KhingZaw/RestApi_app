class ItemModel {
  final String id;
  final String name;
  final ItemData? data;

  ItemModel({
    required this.id,
    required this.name,
    this.data,
  });

  // Convert JSON to ItemModel
  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json['id'],
      name: json['name'],
      data: json['data'] != null
          ? ItemData.fromJson(json['data'])
          : null, // Handle null case
    );
  }
}

class ItemData {
  final String color;
  final String capacity;
  final double? price;
  final String generation;
  final int? year;
  final String cpuModel;
  final String hardDiskSize;
  final String description;
  final String strapColor;
  final String screenSize;

  ItemData({
    required this.color,
    required this.capacity,
    this.price,
    required this.generation,
    this.year,
    required this.cpuModel,
    required this.hardDiskSize,
    required this.description,
    required this.strapColor,
    required this.screenSize,
  });

  /// Convert JSON to ItemData
  factory ItemData.fromJson(Map<String, dynamic> json) {
    return ItemData(
      color: json['color'] ?? "-",
      capacity: json['capacity'] ?? "-",
      price: json['price'] != null
          ? double.tryParse(json['price'].toString())
          : null, // Convert to double
      generation: json['generation'] ?? "-",
      year: json['year'] != null ? int.tryParse(json['year'].toString()) : null,
      cpuModel: json['cpuModel'] ?? "-",
      hardDiskSize: json['hardDiskSize'] ?? "-",
      description: json['description'] ?? "-",
      strapColor: json['strapColor'] ?? "-",
      screenSize: json['screenSize'] ?? "-",
    );
  }
}
