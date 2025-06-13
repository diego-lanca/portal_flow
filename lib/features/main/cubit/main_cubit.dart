import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:portal_flow/core/core.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(const MainState());

  void setTab(MainTab tab) => emit(MainState(mainTab: tab));
}
