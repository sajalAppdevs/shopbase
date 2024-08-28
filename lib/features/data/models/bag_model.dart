class BagModel {
  final String productId, productName, productImage;
  final String color;
  final int quantity;
  final double totalPrice;
  final dynamic size;

  BagModel(
      {required this.productId,
      required this.productName,
      required this.productImage,
      required this.quantity,
      required this.size,
      required this.totalPrice,
      this.color = 'black'});

  Map<String, dynamic> toMap() => {
        'productId': productId,
        'productName': productName,
        'productImage': productImage,
        'quantity': quantity,
        'size': size,
        'totalPrice': totalPrice,
        'color': color,
      };
}
