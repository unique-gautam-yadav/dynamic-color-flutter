import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  String mail;
  String displayName;
  String password;
  User({
    required this.mail,
    required this.displayName,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'mail': mail,
      'displayName': displayName,
      'password': password,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      mail: map['mail'] as String,
      displayName: map['displayName'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}

class ProductModel {
  String id;
  String productId;
  String productName;
  String expiryDate;
  int quantity;
  ProductModel({
    required this.id,
    required this.productId,
    required this.productName,
    required this.expiryDate,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'productId': productId,
      'productName': productName,
      'expiryDate': expiryDate,
      'quantity': quantity,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['_id'] as String,
      productId: map['productId'] as String,
      productName: map['productName'] as String,
      expiryDate: map['expiryDate'] as String,
      quantity: map['quantity'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class ShoeModel {
  String id;
  String name;
  String description;
  String img;
  int price;
  ShoeModel({
    required this.id,
    required this.name,
    required this.description,
    required this.img,
    required this.price,
  });
}
