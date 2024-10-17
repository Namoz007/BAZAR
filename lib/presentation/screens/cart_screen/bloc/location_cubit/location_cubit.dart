import 'package:bloc/bloc.dart';

import '../../../../../core/utils/helpers/dependency_helpers.dart';
import '../../../../../data/repostories/location_repositories.dart';
import 'location_cubit_state.dart';

class LocationCubit extends Cubit<LocationCubitState> {
  final LocationRepositories _repositories = getIt<LocationRepositories>();
  LocationCubit() : super(InitialLocationCubitState());

  void getMyLocation() async {
    emit(LoadingLocationCubitState());
    final location = await _repositories.getMyLocation();
    if (location == null) {
      emit(ErrorLocationCubitState(
          message: "Sorry,we could not find your address"));
    } else {
      emit(LoadedLocationCubitState(point: location));
    }
  }
}
