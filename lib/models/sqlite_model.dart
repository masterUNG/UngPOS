import 'dart:convert';

class SQLModel {
  final int? id;
  final String idproduct;
  final String name;
  final String price;
  final String amount;
  final String sum;
  SQLModel({
    required this.id,
    required this.idproduct,
    required this.name,
    required this.price,
    required this.amount,
    required this.sum,
  });

  SQLModel copyWith({
    int? id,
    String? idproduct,
    String? name,
    String? price,
    String? amount,
    String? sum,
  }) {
    return SQLModel(
      id: id ?? this.id,
      idproduct: idproduct ?? this.idproduct,
      name: name ?? this.name,
      price: price ?? this.price,
      amount: amount ?? this.amount,
      sum: sum ?? this.sum,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idproduct': idproduct,
      'name': name,
      'price': price,
      'amount': amount,
      'sum': sum,
    };
  }

  factory SQLModel.fromMap(Map<String, dynamic> map) {
    return SQLModel(
      id: map['id'],
      idproduct: map['idproduct'],
      name: map['name'],
      price: map['price'],
      amount: map['amount'],
      sum: map['sum'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SQLModel.fromJson(String source) => SQLModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SQLModel(id: $id, idproduct: $idproduct, name: $name, price: $price, amount: $amount, sum: $sum)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is SQLModel &&
      other.id == id &&
      other.idproduct == idproduct &&
      other.name == name &&
      other.price == price &&
      other.amount == amount &&
      other.sum == sum;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      idproduct.hashCode ^
      name.hashCode ^
      price.hashCode ^
      amount.hashCode ^
      sum.hashCode;
  }
}
