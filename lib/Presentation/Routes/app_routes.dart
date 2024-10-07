part of 'app_pages.dart';

abstract class AppRoutes {
  static const LOGIN = 'login';
  static const WORKSPACE = 'workspace';
  static const DASHOBARD = 'dashboard';
  static const KIFILE = 'kifile';
  static const REGISTRAION = 'registration';
  static const ABALS = 'abals';
}

//add / and convert it to lower case
extension RoutesExtension on String {
  String toRoute() => '/${toLowerCase()}';
}
