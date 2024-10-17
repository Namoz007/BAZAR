import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../../../core/utils/helpers/dependency_helpers.dart';
import '../../../../data/repostories/location_repositories.dart';
import '../../main_page/bloc/mainpage_bloc.dart';
import '../bloc/cart_bloc/order_bloc.dart';
import '../bloc/cart_bloc/order_bloc_event.dart';
import '../bloc/location_cubit/location_cubit.dart';
import '../bloc/location_cubit/location_cubit_state.dart';

class SelectMyLocation extends StatefulWidget {
  const SelectMyLocation({super.key});

  @override
  State<SelectMyLocation> createState() => _SelectMyLocationState();
}

class _SelectMyLocationState extends State<SelectMyLocation> {
  late YandexMapController mapController;

  Point myCurrentLocation = const Point(
    latitude: 41.2856806,
    longitude: 69.9034646,
  );

  void onMapCreated(YandexMapController controller) async {
    mapController = controller;
    final myLocation = await getIt<LocationRepositories>().getMyLocation();
    if (myLocation != null) {
      mapController.moveCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: myLocation,
            zoom: 200,
          ),
        ),
      );
    }
  }

  void onCameraPositionChanged(
    CameraPosition position,
    CameraUpdateReason reason,
    bool finished,
  ) async {
    myCurrentLocation = position.target;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LocationCubit, LocationCubitState>(
        listener: (context, state) {
          if(state is LoadedLocationCubitState){
            setState(() {
              myCurrentLocation = state.point;
              onCameraPositionChanged(CameraPosition(target: state.point), CameraUpdateReason.application, false);
            });
          }
          if (state is ErrorLocationCubitState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              YandexMap(
                mapType: MapType.vector,
                onMapCreated: onMapCreated,
                onCameraPositionChanged: onCameraPositionChanged,
                mapObjects: [
                  PlacemarkMapObject(
                    mapId: const MapObjectId("My Location"),
                    point: myCurrentLocation,
                    icon: PlacemarkIcon.single(
                      PlacemarkIconStyle(
                        image: BitmapDescriptor.fromAssetImage(
                          "assets/images/place.png",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50, right: 20),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    width: 40,
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () {
                            mapController.moveCamera(CameraUpdate.zoomIn());
                          },
                          child: const Icon(Icons.add),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: 40,
                          color: Colors.black,
                          height: 2,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        InkWell(
                          onTap: () {
                            mapController.moveCamera(CameraUpdate.zoomOut());
                          },
                          child: const Icon(Icons.remove),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        context.read<OrderBloc>().add(OrderingProductsOrderBlocEvent(address: myCurrentLocation));
        context.read<MainPageBloc>().selectScreen(3);
        Navigator.pop(context);
      },child: const Icon(CupertinoIcons.right_chevron),),
    );
  }
}
