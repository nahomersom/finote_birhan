import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hisnate_kifele/Business%20Logic/Bloc/cubit/authentication/authentication_cubit.dart';
import 'package:hisnate_kifele/Data/Data%20Providers/light_theme.dart';
import 'package:hisnate_kifele/Data/Services/firebase_service.dart';
import 'package:hisnate_kifele/Presentation/Routes/routes.dart';
import 'package:hisnate_kifele/Presentation/Screens/Workspace/UI/workspace.dart';
import 'package:hisnate_kifele/Data/Repositories/user.dart';
import 'package:hisnate_kifele/Data/Services/auth_service.dart';

import 'Presentation/Screens/Home/UI/Dashboard.dart';
import 'Presentation/Screens/Login/UI/login.dart';
import 'Presentation/Screens/Registration/UI/registeration.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
        create: (context) => UserRepository(
              authService: FirbaseAuthService(),
              firestoreService: FirestoreService(),
            ),
        child: MultiBlocProvider(
            providers: [
              BlocProvider<AuthenticationCubit>(
                  create: (BuildContext context) => AuthenticationCubit(
                      userRepository: UserRepository(
                          authService: FirbaseAuthService(),
                          firestoreService: FirestoreService()))),
            ],
            child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
                builder: (contex, state) {
              return MaterialApp.router(
                title: 'Flutter Demo',
                theme: lightTheme,
                routerConfig: goRouter,
                debugShowCheckedModeBanner: false,
              );
              // return MaterialApp(
              //   title: 'Flutter Demo',
              //   theme: lightTheme,
              //   home: const Login(),
              // );
            })));
  }
}
