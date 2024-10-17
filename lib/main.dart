import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finote_birhan_mobile/Business%20Logic/Bloc/cubit/abals/abal_cubit.dart';
import 'package:finote_birhan_mobile/Business%20Logic/Bloc/cubit/authentication/authentication_cubit.dart';
import 'package:finote_birhan_mobile/Data/Data%20Providers/light_theme.dart';
import 'package:finote_birhan_mobile/Data/Repositories/abal.dart';
import 'package:finote_birhan_mobile/Data/Services/firebase_service.dart';
import 'package:finote_birhan_mobile/Presentation/Routes/app_pages.dart';
import 'package:finote_birhan_mobile/Data/Repositories/user.dart';
import 'package:finote_birhan_mobile/Data/Services/auth_service.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:toastification/toastification.dart';

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
        create: (BuildContext context) => UserRepository(
            authService: FirbaseAuthService(),
            firestoreService: FirestoreService()),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<AuthenticationCubit>(
                create: (BuildContext context) => AuthenticationCubit(
                    userRepository: context.read<UserRepository>())),
            BlocProvider<AbalCubit>(
                create: (BuildContext context) => AbalCubit(
                    abalRepository:
                        AbalRepository(abalService: FirestoreService()))),
          ],
          child: ToastificationWrapper(
            child: GetMaterialApp(
              title: 'Flutter Demo',
              theme: lightTheme,
              initialRoute: RouteConfig.initialLocation,
              getPages: RouteConfig.routes,
              debugShowCheckedModeBanner: false,
            ),
          ),
        ));
  }
}
