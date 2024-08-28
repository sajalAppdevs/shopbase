part of 'credit_bloc.dart';

abstract class CreditEvent {
  const CreditEvent();
}

class UpdateCardNumber extends CreditEvent {
  final String newNumber;

  const UpdateCardNumber(this.newNumber);
}

class UpdateExpDate extends CreditEvent {
  final String newExp;

  const UpdateExpDate(this.newExp);
}

class UpdateCvv extends CreditEvent {
  final String newCvv;

  const UpdateCvv(this.newCvv);
}

class UpdateCardholderName extends CreditEvent {
  final String newName;

  const UpdateCardholderName(this.newName);
}
