import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_bazar/presentation/screens/authentication/bloc/authentication_bloc.dart';
import 'package:online_bazar/presentation/screens/authentication/screens/splash_screen.dart';
import 'package:online_bazar/presentation/screens/cart_screen/bloc/cart_bloc/order_bloc.dart';
import 'package:online_bazar/presentation/screens/cart_screen/bloc/location_cubit/location_cubit.dart';
import 'package:online_bazar/presentation/screens/home_screen/products_bloc/products_bloc.dart';
import 'package:online_bazar/presentation/screens/main_page/bloc/mainpage_bloc.dart';
import 'package:online_bazar/presentation/screens/profile_screen/bloc/user_bloc/user_bloc.dart';
import 'core/utils/helpers/dependency_helpers.dart';
import 'data/repostories/authentication_repositories.dart';
import 'data/repostories/location_repositories.dart';
import 'data/repostories/order_repositories.dart';
import 'data/repostories/products_repositories.dart';
import 'data/repostories/user_repositories.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dependencysSetup();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => AuthenticationRepositories()),
        RepositoryProvider(create: (context) => ProductsRepositories()),
        RepositoryProvider(create: (context) => OrderRepositories()),
        RepositoryProvider(create: (context) => UserRepositories()),
        RepositoryProvider(create: (context) => LocationRepositories()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AuthenticationBloc()),
          BlocProvider(create: (context) => MainPageBloc()),
          BlocProvider(create: (context) => ProductsBloc()),
          BlocProvider(create: (context) => OrderBloc()),
          BlocProvider(create: (context) => UserBloc()),
          BlocProvider(create: (context) => LocationCubit()),
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        ),
      ),
    );
  }
}
