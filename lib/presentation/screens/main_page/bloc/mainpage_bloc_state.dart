sealed class MainPageBlocState{}

final class LoadedScreenIndexMainPageBlocState extends MainPageBlocState{
  int index;


  LoadedScreenIndexMainPageBlocState({required this.index,});
}