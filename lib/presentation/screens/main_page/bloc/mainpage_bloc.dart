import 'package:bloc/bloc.dart';

import 'mainpage_bloc_state.dart';

class MainPageBloc extends Cubit<MainPageBlocState> {
  MainPageBloc()
      : super(
          LoadedScreenIndexMainPageBlocState(
            index: 0,
          ),
        );

  void selectScreen(int index){
    emit(LoadedScreenIndexMainPageBlocState(index: index));
  }
}
