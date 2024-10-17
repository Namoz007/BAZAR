
import 'package:yandex_mapkit/yandex_mapkit.dart';

sealed class LocationCubitState {}

final class InitialLocationCubitState extends LocationCubitState{}

final class LoadingLocationCubitState extends LocationCubitState {}

final class LoadedLocationCubitState extends LocationCubitState {
  Point point;

  LoadedLocationCubitState({
    required this.point,
  });
}

final class ErrorLocationCubitState extends LocationCubitState {
  String message;

  ErrorLocationCubitState({
    required this.message,
  });
}
