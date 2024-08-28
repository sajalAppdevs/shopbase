part of 'layout_cubit.dart';

@immutable
sealed class LayoutState {}

final class LayoutInitial extends LayoutState {}

class ChangeBottomNavigationBarState extends LayoutState {
  ChangeBottomNavigationBarState(index);
}