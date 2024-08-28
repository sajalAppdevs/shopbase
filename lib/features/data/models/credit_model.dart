class CreditModel {
  final String fullName;
  final dynamic cardNumber, cardExpired, cvv;

  CreditModel({
      required this.fullName,
      required this.cardNumber,
      required this.cardExpired,
      required this.cvv});

  Map<String, dynamic> toMap() => {
    'fullName': fullName,
    'cardNumber': cardNumber,
    'cardExpired': cardExpired,
    'cvv': cvv
  };

  factory CreditModel.fromFirebaseFirestore(Map<String, dynamic> data) => CreditModel(
      fullName: data['fullName'] as String,
      cardNumber: data['cardNumber'],
      cardExpired: data['cardExpired'],
      cvv: data['cvv']);
}
