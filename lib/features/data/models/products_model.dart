import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsModel {
  final String productCategory;
  dynamic productSubCategory;
  final String productId, productTitle, productDescription, productImage, productQuantity;
  final double productPrice;
  final double productSale;
  Timestamp? createdAt;

  ProductsModel(
      {required this.productId,
      required this.productTitle,
      required this.productPrice,
      required this.productSale,
      required this.productCategory,
      required this.productSubCategory,
      required this.productDescription,
      required this.productImage,
      required this.productQuantity,
      this.createdAt});

  factory ProductsModel.fromFirestore(Map<String, dynamic> data) => ProductsModel(
      productId: data['productId'] as String,
      productTitle: data['productTitle'] as String,
      // productPrice: data['productPrice'].toString() as double,
      productPrice: (data['productPrice'] is String)
          ? double.tryParse(data['productPrice']) ?? 0.0
          : data['productPrice'] as double,
      // productSale: data['productSale'] as double,
      productSale: (data['productSale'] is String)
          ? double.tryParse(data['productSale']) ?? 0.0 // Attempt to parse String to double
          : data['productSale'] as double,
      productCategory: data['productCategory'] as String,
      productSubCategory: data['productSubCategory'] as dynamic,
      productDescription: data['productDescription'] as String,
      productImage: data['productImage'] as String,
      productQuantity: data['productQuantity'] as String,
      createdAt: data['createdAt'] ?? Timestamp.now());
}
