import 'package:shopbase_firebase/core/extensions/sized_box_constrained_extention.dart';
import 'package:shopbase_firebase/core/utils/functions/firebase_services.dart';
import 'package:shopbase_firebase/features/data/models/credit_model.dart';
import 'package:shopbase_firebase/features/presentation/widgets/custom_button/build_basic_button_widget.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopbase_firebase/core/utils/color/credit_card_gradiant.dart';
import 'package:shopbase_firebase/features/presentation/widgets/custom_circle_progress_indicator_widget/create_circle_progress_indicator_widget.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../widgets/custom_credit_card/build_credit_card_widget.dart';
import '../../../../widgets/custom_dialog/build_dialog_widget.dart';

class CreditCardPage extends StatefulWidget {
  const CreditCardPage({Key? key}) : super(key: key);

  @override
  State<CreditCardPage> createState() => _HomePageState();
}

class _HomePageState extends State<CreditCardPage> {
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cardHolderNameController = TextEditingController();
  final TextEditingController cardExpiryDateController = TextEditingController();
  final TextEditingController cardCvvController = TextEditingController();
  final FlipCardController flipCardController = FlipCardController();
  var primaryCreditColor = creditGradiant[0];
  final FirebaseServices _firebaseServices = FirebaseServices();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios,
              size: 16,
            )),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12.0, bottom: 5.0),
                child: Text(
                  S.of(context).add_payment_credit,
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    // color: AppConsts.blackAppColor
                  ),
                ),
              ),
              10.kH,
              // buildColorIcons(),
              10.kH,
              FlipCard(
                  fill: Fill.fillFront,
                  direction: FlipDirection.HORIZONTAL,
                  controller: flipCardController,
                  onFlip: () => print('Flip'),
                  flipOnTouch: false,
                  onFlipDone: (isFront) {
                    print('isFront: $isFront');
                  },
                  front: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: buildFrontCreditCard(
                      color: primaryCreditColor,
                      cardExpiration: cardExpiryDateController.text.isEmpty
                          ? "12/24"
                          : cardExpiryDateController.text,
                      cardHolder: cardHolderNameController.text.isEmpty
                          ? "Card Holder"
                          : cardHolderNameController.text.toUpperCase(),
                      cardNumber: cardNumberController.text.isEmpty
                          ? "XXXX XXXX XXXX XXXX"
                          : cardNumberController.text,
                    ),
                  ),
                  back: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: buildBackCreditCard(
                      color: primaryCreditColor,
                      context,
                      cvv: cardCvvController.text.isEmpty ? "322" : cardCvvController.text,
                    ),
                  )),
              40.kH,
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildCardNumTextFieldWidget(context, cardNumberController, function: (value) {
                    var text = value.replaceAll(RegExp(r'\s+\b|\b\s'), ' ');
                    setState(() {
                      cardNumberController.value = cardNumberController.value.copyWith(
                          text: text,
                          selection: TextSelection.collapsed(offset: text.length),
                          composing: TextRange.empty);
                    });
                  }),
                  10.kH,
                  buildFullNameTextField(context, cardHolderNameController, function: (value) {
                    setState(() {
                      cardHolderNameController.value = cardHolderNameController.value.copyWith(
                          text: value,
                          selection: TextSelection.collapsed(offset: value.length),
                          composing: TextRange.empty);
                    });
                  }),
                  10.kH,
                  buildRowTextField(context, cardExpiryDateController, cardCvvController,
                      firstFunction: (value) {
                    var text = value.replaceAll(RegExp(r'\s+\b|\b\s'), ' ');
                    setState(() {
                      cardExpiryDateController.value = cardExpiryDateController.value.copyWith(
                          text: text,
                          selection: TextSelection.collapsed(offset: text.length),
                          composing: TextRange.empty);
                    });
                  }, secondFunction: (value) {
                    setState(() {
                      int length = value.length;
                      if (length == 4 || length == 9 || length == 14) {
                        cardNumberController.text = '$value ';
                        cardNumberController.selection =
                            TextSelection.fromPosition(TextPosition(offset: value.length + 1));
                      }
                    });
                  }, onTap: () {
                    setState(() {
                      Future.delayed(const Duration(milliseconds: 300), () {
                        flipCardController.toggleCard();
                      });
                    });
                  }),
                  40.kH,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: basicButton(
                        title: S.of(context).add_card.toUpperCase(),
                        function: () => Future.delayed(const Duration(milliseconds: 300), () async {
                              final CreditModel creditModel = CreditModel(
                                  fullName: cardHolderNameController.text,
                                  cardNumber: cardNumberController.text,
                                  cardExpired: cardExpiryDateController.text,
                                  cvv: cardCvvController.text);

                              return await _firebaseServices.usersCollection
                                  .doc(_firebaseServices.currentId)
                                  .collection('my_credits')
                                  .doc(_firebaseServices.creditID)
                                  .set(creditModel.toMap())
                                  .then((value) {
                                print("Success!!");
                                showDialog(
                                        context: context,
                                        builder: (context) => buildDefaultDialog(context,
                                            dialogText: S.of(context).add_credit_success_title,
                                            dialogSubtitle:
                                                S.of(context).add_credit_success_subtitle))
                                    .then((value) => Navigator.pop(context));
                                cardCvvController.clear();
                                cardExpiryDateController.clear();
                                cardHolderNameController.clear();
                                cardNumberController.clear();
                                flipCardController.toggleCard();
                              }).catchError((onError) => print(onError.toString()));
                            })),
                  ),
                  10.kH,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
