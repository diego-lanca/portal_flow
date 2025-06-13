part of 'main_cubit.dart';

final class MainState extends Equatable {
  const MainState({this.mainTab = MainTab.home});

  final MainTab mainTab;
  
  @override
  List<Object> get props => [mainTab];
}
