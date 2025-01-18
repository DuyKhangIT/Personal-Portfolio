import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'bottom_nav_bar_state.dart';

class BottomNavBarCubit extends Cubit<BottomNavBarState> {
  BottomNavBarCubit() : super(const BottomNavBarState());

  void onItemTapped(int index) {
    if (index != state.navBar) {
      emit(state.copyWith(navBar: index));
    }
  }
}
