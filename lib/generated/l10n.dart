// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Arabic`
  String get arab {
    return Intl.message(
      'Arabic',
      name: 'arab',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get eng {
    return Intl.message(
      'English',
      name: 'eng',
      desc: '',
      args: [],
    );
  }

  /// `Change Language`
  String get change_lang_title {
    return Intl.message(
      'Change Language',
      name: 'change_lang_title',
      desc: '',
      args: [],
    );
  }

  /// `SELECT ITEMS`
  String get on_boarding_title_1 {
    return Intl.message(
      'SELECT ITEMS',
      name: 'on_boarding_title_1',
      desc: '',
      args: [],
    );
  }

  /// `PURCHASE`
  String get on_boarding_title_2 {
    return Intl.message(
      'PURCHASE',
      name: 'on_boarding_title_2',
      desc: '',
      args: [],
    );
  }

  /// `DELIVERY`
  String get on_boarding_title_3 {
    return Intl.message(
      'DELIVERY',
      name: 'on_boarding_title_3',
      desc: '',
      args: [],
    );
  }

  /// `this is subtitle 1, Lorem Ipsum is simply dummy \ntext of the printing and typesetting industry.`
  String get on_boarding_subtitle_1 {
    return Intl.message(
      'this is subtitle 1, Lorem Ipsum is simply dummy \ntext of the printing and typesetting industry.',
      name: 'on_boarding_subtitle_1',
      desc: '',
      args: [],
    );
  }

  /// `this is subtitle 2, Lorem Ipsum is simply dummy \ntext of the printing and typesetting industry.`
  String get on_boarding_subtitle_2 {
    return Intl.message(
      'this is subtitle 2, Lorem Ipsum is simply dummy \ntext of the printing and typesetting industry.',
      name: 'on_boarding_subtitle_2',
      desc: '',
      args: [],
    );
  }

  /// `this is subtitle 3, Lorem Ipsum is simply dummy \ntext of the printing and typesetting industry.`
  String get on_boarding_subtitle_3 {
    return Intl.message(
      'this is subtitle 3, Lorem Ipsum is simply dummy \ntext of the printing and typesetting industry.',
      name: 'on_boarding_subtitle_3',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get get_started {
    return Intl.message(
      'Get Started',
      name: 'get_started',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to ShopBase`
  String get welcome_title {
    return Intl.message(
      'Welcome to ShopBase',
      name: 'welcome_title',
      desc: '',
      args: [],
    );
  }

  /// `Interest with awesome suits, cloathes, and accessories for men 🤗`
  String get welcome_subtitle {
    return Intl.message(
      'Interest with awesome suits, cloathes, and accessories for men 🤗',
      name: 'welcome_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phone {
    return Intl.message(
      'Phone Number',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Forget your password?`
  String get forget_your_password {
    return Intl.message(
      'Forget your password?',
      name: 'forget_your_password',
      desc: '',
      args: [],
    );
  }

  /// `Please! fill the full name field empty!`
  String get name_validation {
    return Intl.message(
      'Please! fill the full name field empty!',
      name: 'name_validation',
      desc: '',
      args: [],
    );
  }

  /// `Please! fill the email field empty!`
  String get email_validation {
    return Intl.message(
      'Please! fill the email field empty!',
      name: 'email_validation',
      desc: '',
      args: [],
    );
  }

  /// `Please! fill the phone number field empty!`
  String get phone_validation {
    return Intl.message(
      'Please! fill the phone number field empty!',
      name: 'phone_validation',
      desc: '',
      args: [],
    );
  }

  /// `Please! fill the password field empty!`
  String get password_validation {
    return Intl.message(
      'Please! fill the password field empty!',
      name: 'password_validation',
      desc: '',
      args: [],
    );
  }

  /// `Please! Check your input again!`
  String get error_login_snackbar {
    return Intl.message(
      'Please! Check your input again!',
      name: 'error_login_snackbar',
      desc: '',
      args: [],
    );
  }

  /// `Sign in using Google`
  String get signin_using_google {
    return Intl.message(
      'Sign in using Google',
      name: 'signin_using_google',
      desc: '',
      args: [],
    );
  }

  /// `Data verifying`
  String get verify {
    return Intl.message(
      'Data verifying',
      name: 'verify',
      desc: '',
      args: [],
    );
  }

  /// `We sent code verification to:`
  String get verify_title {
    return Intl.message(
      'We sent code verification to:',
      name: 'verify_title',
      desc: '',
      args: [],
    );
  }

  /// `Check`
  String get verify_button {
    return Intl.message(
      'Check',
      name: 'verify_button',
      desc: '',
      args: [],
    );
  }

  /// `New`
  String get new_title {
    return Intl.message(
      'New',
      name: 'new_title',
      desc: '',
      args: [],
    );
  }

  /// `You've never seen it before!`
  String get new_subtitle {
    return Intl.message(
      'You\'ve never seen it before!',
      name: 'new_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Sale`
  String get sale_title {
    return Intl.message(
      'Sale',
      name: 'sale_title',
      desc: '',
      args: [],
    );
  }

  /// `Special sales for this season`
  String get sale_subtitle {
    return Intl.message(
      'Special sales for this season',
      name: 'sale_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Show All`
  String get show_all {
    return Intl.message(
      'Show All',
      name: 'show_all',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Street\nClothes`
  String get home_title_1 {
    return Intl.message(
      'Street\nClothes',
      name: 'home_title_1',
      desc: '',
      args: [],
    );
  }

  /// `Fashion\nSale`
  String get home_title_2 {
    return Intl.message(
      'Fashion\nSale',
      name: 'home_title_2',
      desc: '',
      args: [],
    );
  }

  /// `Bags`
  String get bag {
    return Intl.message(
      'Bags',
      name: 'bag',
      desc: '',
      args: [],
    );
  }

  /// `My bags`
  String get bag_title {
    return Intl.message(
      'My bags',
      name: 'bag_title',
      desc: '',
      args: [],
    );
  }

  /// `Shop`
  String get shop {
    return Intl.message(
      'Shop',
      name: 'shop',
      desc: '',
      args: [],
    );
  }

  /// `Favourite`
  String get fav {
    return Intl.message(
      'Favourite',
      name: 'fav',
      desc: '',
      args: [],
    );
  }

  /// `My favourites`
  String get fav_title {
    return Intl.message(
      'My favourites',
      name: 'fav_title',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `My orders`
  String get my_orders {
    return Intl.message(
      'My orders',
      name: 'my_orders',
      desc: '',
      args: [],
    );
  }

  /// `Payment methods`
  String get payment_method {
    return Intl.message(
      'Payment methods',
      name: 'payment_method',
      desc: '',
      args: [],
    );
  }

  /// `Shipping addresses`
  String get shipping_address {
    return Intl.message(
      'Shipping addresses',
      name: 'shipping_address',
      desc: '',
      args: [],
    );
  }

  /// `Promocodes`
  String get promocodes {
    return Intl.message(
      'Promocodes',
      name: 'promocodes',
      desc: '',
      args: [],
    );
  }

  /// `Settings page`
  String get settings {
    return Intl.message(
      'Settings page',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Edit your profile`
  String get edit_your_profile {
    return Intl.message(
      'Edit your profile',
      name: 'edit_your_profile',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get theme {
    return Intl.message(
      'Theme',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get lang {
    return Intl.message(
      'Language',
      name: 'lang',
      desc: '',
      args: [],
    );
  }

  /// `Notification`
  String get notif {
    return Intl.message(
      'Notification',
      name: 'notif',
      desc: '',
      args: [],
    );
  }

  /// `Privacy policy`
  String get priv_policy {
    return Intl.message(
      'Privacy policy',
      name: 'priv_policy',
      desc: '',
      args: [],
    );
  }

  /// `Rate us`
  String get rate_us {
    return Intl.message(
      'Rate us',
      name: 'rate_us',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure to logout?`
  String get logout_title {
    return Intl.message(
      'Are you sure to logout?',
      name: 'logout_title',
      desc: '',
      args: [],
    );
  }

  /// `Sure`
  String get confirm {
    return Intl.message(
      'Sure',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `We work to solve this problem.`
  String get error_title {
    return Intl.message(
      'We work to solve this problem.',
      name: 'error_title',
      desc: '',
      args: [],
    );
  }

  /// `Brand`
  String get brand {
    return Intl.message(
      'Brand',
      name: 'brand',
      desc: '',
      args: [],
    );
  }

  /// `Product Code`
  String get code {
    return Intl.message(
      'Product Code',
      name: 'code',
      desc: '',
      args: [],
    );
  }

  /// `Leather`
  String get leather {
    return Intl.message(
      'Leather',
      name: 'leather',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about_product_title {
    return Intl.message(
      'About',
      name: 'about_product_title',
      desc: '',
      args: [],
    );
  }

  /// `Add to card`
  String get add_to_card {
    return Intl.message(
      'Add to card',
      name: 'add_to_card',
      desc: '',
      args: [],
    );
  }

  /// `Size`
  String get size {
    return Intl.message(
      'Size',
      name: 'size',
      desc: '',
      args: [],
    );
  }

  /// `Quantity`
  String get quantity {
    return Intl.message(
      'Quantity',
      name: 'quantity',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message(
      'Price',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `Color`
  String get color {
    return Intl.message(
      'Color',
      name: 'color',
      desc: '',
      args: [],
    );
  }

  /// `Checkout`
  String get checkout {
    return Intl.message(
      'Checkout',
      name: 'checkout',
      desc: '',
      args: [],
    );
  }

  /// `Product total price`
  String get product_total_price {
    return Intl.message(
      'Product total price',
      name: 'product_total_price',
      desc: '',
      args: [],
    );
  }

  /// `Delivery price`
  String get delivery_price {
    return Intl.message(
      'Delivery price',
      name: 'delivery_price',
      desc: '',
      args: [],
    );
  }

  /// `Total amount`
  String get total_amount {
    return Intl.message(
      'Total amount',
      name: 'total_amount',
      desc: '',
      args: [],
    );
  }

  /// `Success added to favourite!!`
  String get success_add_to_favourite {
    return Intl.message(
      'Success added to favourite!!',
      name: 'success_add_to_favourite',
      desc: '',
      args: [],
    );
  }

  /// `There isn't' news products, yet!!`
  String get no_news_products {
    return Intl.message(
      'There isn\'t\' news products, yet!!',
      name: 'no_news_products',
      desc: '',
      args: [],
    );
  }

  /// `There isn't products in bags, yet!!`
  String get no_bags_data {
    return Intl.message(
      'There isn\'t products in bags, yet!!',
      name: 'no_bags_data',
      desc: '',
      args: [],
    );
  }

  /// `Add new payment credit`
  String get add_payment_credit {
    return Intl.message(
      'Add new payment credit',
      name: 'add_payment_credit',
      desc: '',
      args: [],
    );
  }

  /// `Card number`
  String get card_number {
    return Intl.message(
      'Card number',
      name: 'card_number',
      desc: '',
      args: [],
    );
  }

  /// `Full name (as a credit)`
  String get full_name {
    return Intl.message(
      'Full name (as a credit)',
      name: 'full_name',
      desc: '',
      args: [],
    );
  }

  /// `Add card`
  String get add_card {
    return Intl.message(
      'Add card',
      name: 'add_card',
      desc: '',
      args: [],
    );
  }

  /// `Created successfully!!`
  String get add_credit_success_title {
    return Intl.message(
      'Created successfully!!',
      name: 'add_credit_success_title',
      desc: '',
      args: [],
    );
  }

  /// `Your complete create card payment successfully, Congratulation!`
  String get add_credit_success_subtitle {
    return Intl.message(
      'Your complete create card payment successfully, Congratulation!',
      name: 'add_credit_success_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `This user didn't found.`
  String get login_user_didnt_found {
    return Intl.message(
      'This user didn\'t found.',
      name: 'login_user_didnt_found',
      desc: '',
      args: [],
    );
  }

  /// `Email or password didn't correct.`
  String get login_invalid_password {
    return Intl.message(
      'Email or password didn\'t correct.',
      name: 'login_invalid_password',
      desc: '',
      args: [],
    );
  }

  /// `The email address is not valid.`
  String get login_invalid_email {
    return Intl.message(
      'The email address is not valid.',
      name: 'login_invalid_email',
      desc: '',
      args: [],
    );
  }

  /// `This user account has been disabled.`
  String get login_user_disabled {
    return Intl.message(
      'This user account has been disabled.',
      name: 'login_user_disabled',
      desc: '',
      args: [],
    );
  }

  /// `Operation not allowed. Contact support.`
  String get login_operation_not_allowed {
    return Intl.message(
      'Operation not allowed. Contact support.',
      name: 'login_operation_not_allowed',
      desc: '',
      args: [],
    );
  }

  /// `Too many requests. Try again later.`
  String get login_too_many_requests {
    return Intl.message(
      'Too many requests. Try again later.',
      name: 'login_too_many_requests',
      desc: '',
      args: [],
    );
  }

  /// `Error in Login: `
  String get login_error {
    return Intl.message(
      'Error in Login: ',
      name: 'login_error',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
