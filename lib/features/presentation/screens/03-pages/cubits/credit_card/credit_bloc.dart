import 'package:bloc/bloc.dart';
import 'package:credit_card_type_detector/credit_card_type_detector.dart';
import 'package:meta/meta.dart';
import 'package:credit_card_type_detector/models.dart';

part 'credit_event.dart';
part 'credit_state.dart';

class CreditBloc extends Bloc<CreditEvent, CreditState> {
  CreditBloc() : super(CreditInitial()) {
    on<CreditEvent>((event, emit) {
      // final newNumber = event.newNumber;
      // emit(
      //   state.copyWith(
      //     cardNumber: newNumber,
      //     cardType: detectCCType(newNumber) as CreditCardType,
      //   ),
      // );
    });
    // on<UpdateExpDate>((event, emit) => emit(state.copyWith(expDate: event.newExp)));
    // on<UpdateCvv>((event, emit) => emit(state.copyWith(cvv: event.newCvv)));
    // on<UpdateCardholderName>((event, emit) => emit(state.copyWith(cardholderName: event.newName)));
  }
}
