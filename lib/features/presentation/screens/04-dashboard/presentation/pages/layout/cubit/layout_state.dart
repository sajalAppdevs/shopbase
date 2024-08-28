part of 'layout_cubit.dart';

@immutable
sealed class DashboardLayoutState {}

final class LayoutInitial extends DashboardLayoutState {}

class ChangeBottomNavigationBarState extends DashboardLayoutState {
  ChangeBottomNavigationBarState(index);
}