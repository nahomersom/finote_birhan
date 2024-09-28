import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hisnate_kifele/Business%20Logic/Bloc/cubit/abal_registration/abal_registration_cubit.dart';
import 'package:hisnate_kifele/Business%20Logic/Bloc/cubit/authentication/authentication_cubit.dart';
import 'package:hisnate_kifele/Data/Data%20Providers/light_theme.dart';
import 'package:hisnate_kifele/Data/Repositories/abal.dart';
import 'package:hisnate_kifele/Data/Services/firebase_service.dart';
import 'package:hisnate_kifele/Presentation/Routes/route_config.dart';
import 'package:hisnate_kifele/Presentation/Routes/routes.dart';
import 'package:hisnate_kifele/Presentation/Screens/Workspace/UI/workspace.dart';
import 'package:hisnate_kifele/Data/Repositories/user.dart';
import 'package:hisnate_kifele/Data/Services/auth_service.dart';

import 'Presentation/Screens/Abals/UI/Abal-List.dart';
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
          child: MaterialApp.router(
            title: 'Flutter Demo',
            theme: lightTheme,
            routerConfig: RouteConfig.returnRouter(isAuth: true),
            debugShowCheckedModeBanner: false,
          ),
        ));
    // return MaterialApp(
    //     title: 'Flutter Demo',
    //     theme: lightTheme,
    //     debugShowCheckedModeBanner: false,
    //     home: Scaffold(
    //       backgroundColor: Colors.white,
    //       body: Padding(
    //         padding: EdgeInsets.all(20),
    //         child: Center(
    //             child: ClipPath(
    //           clipper: MyImageClipper(),
    //           child: Image.network(
    //               'https://images.pexels.com/photos/39561/solar-flare-sun-eruption-energy-39561.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
    //         )),
    //       ),
    //     ));
  }
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();

    path.lineTo(0.0, size.height);

    final Offset firstControlPoint = Offset(size.width / 4, size.height);
    final Offset firstEndPoint = Offset(size.width / 2.25, size.height - 30.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    final Offset secondControlPoint =
        Offset(size.width - (size.width / 3.25), size.height - 65);
    final Offset secondEndPoint = Offset(size.width, size.height - 10);

    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height - 40);

    path.lineTo(size.width, 0.0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class BottomWaveClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();

    path.lineTo(0.0, size.height - 15);

    final Offset firstControlPoint = Offset(size.width / 4, size.height + 20);
    final Offset firstEndPoint = Offset(size.width / 1.6, size.height - 30.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    final Offset secondControlPoint =
        Offset(size.width / 1.2, size.height - 65);
    final Offset secondEndPoint = Offset(size.width, size.height - 20);

    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height - 20);

    path.lineTo(size.width, 0.0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class BottomWaveClipper3 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();

    path.lineTo(0.0, size.height - 35);

    final Offset firstControlPoint = Offset(size.width / 4, size.height - 65);
    final Offset firstEndPoint = Offset(size.width / 2, size.height - 10.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    final Offset secondControlPoint =
        Offset(size.width - (size.width / 3.25), size.height + 20);
    final Offset secondEndPoint = Offset(size.width, size.height - 30);

    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height - 20);

    path.lineTo(size.width, 0.0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
