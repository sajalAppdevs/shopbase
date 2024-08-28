part of 'credit_bloc.dart';

abstract class CreditState {
  const CreditState();
}

final class CreditInitial extends CreditState {}

class AddCreditCardFormState extends CreditState {
  final String? cardNumber;
  final CreditCardType? cardType;
  final String? expDate;
  final String? cvv;
  final String? cardholderName;

  const AddCreditCardFormState({
    required this.cardNumber,
    required this.cardType,
    required this.expDate,
    required this.cvv,
    required this.cardholderName,
  });

  List<Object> get props =>
      [cardNumber!, cardType!, expDate!, cvv!, cardholderName!];

  AddCreditCardFormState copyWith(
      {String? cardNumber,
      CreditCardType? cardType,
      String? expDate,
      String? cvv,
      String? cardholderName}) {
    return AddCreditCardFormState(
        cardNumber: cardNumber ?? cardNumber,
        cardType: cardType ?? cardType,
        expDate: expDate ?? expDate,
        cvv: cvv ?? cvv,
        cardholderName: cardholderName ?? cardholderName);
  }
}
