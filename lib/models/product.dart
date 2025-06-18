class Product {
  final String id;
  final String name;
  final String category;
  final String image;
  final String description;
  final double price;

  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.image,
    required this.description,
    required this.price,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'category': category,
    'image': image,
    'description': description,
    'price': price,
  };

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json['id'],
    name: json['name'],
    category: json['category'],
    image: json['image'],
    description: json['description'],
    price: json['price'].toDouble(),
  );
}
