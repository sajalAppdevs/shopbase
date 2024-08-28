import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id, name, image, email, phone;
  final Timestamp createdAt;

  UserModel({
      required this.id,
      required this.name,
      required this.image,
      required this.email,
      required this.phone,
      required this.createdAt});

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return UserModel(
        id: data['userId'] ?? '',
        name: data['userName'] ?? '',
        email: data['userEmail'] ?? '',
        phone: data['userPhone'] ?? '',
        image: data['userImage'] ?? '',
        createdAt: data['createdAt'] ?? Timestamp.now()
    );
  }
}