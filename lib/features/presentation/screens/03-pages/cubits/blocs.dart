// import 'package:flutter/widgets.dart';
//
// abstract class Bloc {
//   void dispose();
// }
//
// /// Generic BLoC provider
// class BlocProvider<T extends Bloc, Cubit> extends StatefulWidget {
//   BlocProvider({
//     Key? key,
//     required this.child,
//     required this.bloc,
//   }) : super(key: key);
//
//   /// The [Bloc] that is now accessible to members of the widget subtree
//   final T bloc;
//
//   /// The [Widget] that makes it possible to continue the building of the widget tree
//   final Widget child;
//
//   @override
//   _BlocProviderState<T> createState() => _BlocProviderState<T>();
//
//   /// This function allows any widget to access a [Bloc] that was defined
//   ///  earlier in the widget tree based on the [BuildContext]
//   static T of<T extends Bloc>(BuildContext context) {
//     final type = _typeOf<BlocProvider<T>>();
//     BlocProvider<T>? provider = context.findAncestorWidgetOfExactType();
//     return provider!.bloc;
//   }
//
//   /// Gets the [Type] of the [Bloc] so it can be found in the widget tree
//   static Type _typeOf<T>() => T;
// }
//
// /// The state for the [BlocProvider] widget
// class _BlocProviderState<T> extends State<BlocProvider<Bloc>> {
//   @override
//   void dispose() {
//     widget.bloc.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return widget.child;
//   }
// }
