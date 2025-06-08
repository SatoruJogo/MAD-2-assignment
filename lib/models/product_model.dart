class Product {
  final int id;
  final String name;
  final String description;
  final String price;
  final int quantity;
  final String category;
  final String imagePath;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.category,
    required this.imagePath,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      quantity: json['quantity'],
      category: json['category'],
      imagePath: json['image_path'],
    );
  }
}
