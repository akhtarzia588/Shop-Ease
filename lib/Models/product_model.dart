class ProductModel {
  final String id;
  final String name;
  final String price;
  final String description;
  final String imageurl;
  final String category;

  const ProductModel({
    required this.id,
    required this.category,
    required this.description,
    required this.imageurl,
    required this.name,
    required this.price,
  });

  factory ProductModel.fromMap(String id, Map<String, dynamic> map) {
    return ProductModel(
      id: id,
      category: map['category'] ?? '',
      description: map['description'] ?? '',
      imageurl: map['imageurl'] ?? '',
      name: map['name'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
    );
  }
  //Product Model For Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'category': category,
      'description': description,
      'price': price,
      'imageurl': imageurl,
    };
  }
}
