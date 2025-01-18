part of 'bottom_nav_bar_cubit.dart';

class BottomNavBarState extends Equatable {
  final int navBar;
  const BottomNavBarState({this.navBar = 0});

  @override
  List<Object> get props => [navBar];

  BottomNavBarState copyWith({
    int? navBar,
  }) {
    return BottomNavBarState(
      navBar: navBar ?? this.navBar,
    );
  }
}
