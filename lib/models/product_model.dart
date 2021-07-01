import 'dart:convert';

class ProductModel {
  final String id;
  final String category;
  final String nameFood;
  final String price;
  final String detail;
  final String image;
  ProductModel({
    required this.id,
    required this.category,
    required this.nameFood,
    required this.price,
    required this.detail,
    required this.image,
  });

  ProductModel copyWith({
    String? id,
    String? category,
    String? nameFood,
    String? price,
    String? detail,
    String? image,
  }) {
    return ProductModel(
      id: id ?? this.id,
      category: category ?? this.category,
      nameFood: nameFood ?? this.nameFood,
      price: price ?? this.price,
      detail: detail ?? this.detail,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category,
      'nameFood': nameFood,
      'price': price,
      'detail': detail,
      'image': image,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'],
      category: map['category'],
      nameFood: map['nameFood'],
      price: map['price'],
      detail: map['detail'],
      image: map['image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) => ProductModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductModel(id: $id, category: $category, nameFood: $nameFood, price: $price, detail: $detail, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ProductModel &&
      other.id == id &&
      other.category == category &&
      other.nameFood == nameFood &&
      other.price == price &&
      other.detail == detail &&
      other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      category.hashCode ^
      nameFood.hashCode ^
      price.hashCode ^
      detail.hashCode ^
      image.hashCode;
  }
}
