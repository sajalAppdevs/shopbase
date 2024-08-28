import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'show_orders_state.dart';

class ShowOrdersCubit extends Cubit<ShowOrdersState> {
  ShowOrdersCubit() : super(ShowOrdersInitial());

}
