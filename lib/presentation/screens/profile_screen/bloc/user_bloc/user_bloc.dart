import 'package:bloc/bloc.dart';
import 'package:online_bazar/presentation/screens/profile_screen/bloc/user_bloc/user_bloc_event.dart';
import 'package:online_bazar/presentation/screens/profile_screen/bloc/user_bloc/user_bloc_state.dart';

import '../../../../../core/utils/details/app_details.dart';
import '../../../../../core/utils/helpers/dependency_helpers.dart';
import '../../../../../data/repostories/user_repositories.dart';

class UserBloc extends Bloc<UserBlocEvent,UserBlocState>{
  final _repositories = getIt<UserRepositories>();
  UserBloc(): super(InitialUserBlocState()){
    on<GetMyUserFromSourcesUserBlocEvent>(_getUserFromSources);
    on<GetMyUserUserBlocEvent>(_getMyUser);
    on<EditUserBlocEvent>(_editMyUser);
  }

  void _editMyUser(EditUserBlocEvent event,emit) async{
    AppDetails.model = await _repositories.editUser(event.model,event.file,);
   emit(LoadedUserUserBlocState(userModel: AppDetails.model!));
  }

  void _getMyUser(GetMyUserUserBlocEvent event,emit){
    emit(LoadingUserBlocState());
    emit(LoadedUserUserBlocState(userModel: AppDetails.model!));
  }

  void _getUserFromSources(GetMyUserFromSourcesUserBlocEvent even,emit) async{
    emit(LoadingUserBlocState());
    AppDetails.model = await _repositories.getMyUser();
    emit(LoadedUserUserBlocState(userModel: AppDetails.model!));
  }
}