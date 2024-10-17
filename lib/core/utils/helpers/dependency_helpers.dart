import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/datasources/authentication_sources.dart';
import '../../../data/datasources/order_sources.dart';
import '../../../data/datasources/products_sources.dart';
import '../../../data/datasources/user_sources.dart';
import '../../../data/repostories/authentication_repositories.dart';
import '../../../data/repostories/location_repositories.dart';
import '../../../data/repostories/order_repositories.dart';
import '../../../data/repostories/products_repositories.dart';
import '../../../data/repostories/user_repositories.dart';

final getIt = GetIt.instance;

Future<void> dependencysSetup() async {
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);
  getIt.registerSingleton(AuthenticationSources());
  getIt.registerSingleton(FirebaseAuth.instance);
  getIt.registerSingleton(ProductsSources());
  getIt.registerSingleton(ProductsRepositories());
  getIt.registerSingleton(AuthenticationRepositories());
  getIt.registerSingleton(OrderSources());
  getIt.registerSingleton(OrderRepositories());
  getIt.registerSingleton(UserSources());
  getIt.registerSingleton(UserRepositories());
  getIt.registerSingleton(LocationRepositories());
}
