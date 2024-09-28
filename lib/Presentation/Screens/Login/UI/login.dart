import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:hisnate_kifele/Business%20Logic/Bloc/cubit/authentication/authentication_cubit.dart';
import 'package:hisnate_kifele/Data/Data%20Providers/colors.dart';
import 'package:hisnate_kifele/Data/Data%20Providers/light_theme.dart';
import 'package:hisnate_kifele/Presentation/Screens/Home/UI/Dashboard.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../../../Utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ClipPath(
              clipper: WaveClipperTwo(),
              child: Stack(
                children: [
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/kids.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                      color: ColorResources.secondaryColor.withOpacity(
                          0.6), // Adjust opacity and color as needed
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Text(
                    'Welcome Back',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: ColorResources.secondaryColor,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Login to your account',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 32),
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      labelText: 'Full Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      suffixIcon: Icon(Icons.visibility),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Checkbox(value: true, onChanged: (value) {}),
                          Text('Remember Me'),
                        ],
                      ),
                      Text('Forgot Password?'),
                    ],
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Login',
                      style: TextStyle(color: ColorResources.backgroundColor),
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      backgroundColor: ColorResources.secondaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {},
                        child: Text('Sign up'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// class _LoginState extends State<Login> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController _phoneController = new TextEditingController();
//   final TextEditingController _passwordController = new TextEditingController();
//   final TextEditingController _smsCodeController = new TextEditingController();
//   String? smsCode;
//   bool isLoading = false;
//   bool authSuccess = false;
//   String? phoneNumber;

//   @override
//   Widget build(BuildContext context) {
//     final authenticationCubit = BlocProvider.of<AuthenticationCubit>(context);
//     login() async {
//       if (_formKey.currentState!.validate()) {
//         print("phone------ ${phoneNumber}");
//         await authenticationCubit.login(phoneNumber!).then((value) {});
//       }
//     }

//     return Scaffold(
//       body: SingleChildScrollView(
//         child: SafeArea(
//           child: Container(
//             color: ColorResources.primaryColor,
//             height: MediaQuery.of(context).size.height,
//             width: MediaQuery.of(context).size.width,
//             padding: const EdgeInsets.all(0),
//             child: BlocConsumer<AuthenticationCubit, AuthenticationState>(
//                 listener: (context, state) {
//               if (state.authStatus.authenticated) {
//                 context.go('/dashboard');
//               } else if (state.authStatus.codeSent) {
//                 context.push('/verifyOtp');
//               }
//               if (state.authStatus.hasError) {
//                 Utils.showSnackBar(
//                     context, state.errorMessage, Colors.red.shade400);
//               }
//             }, builder: (context, state) {
//               return Column(
//                 children: [
//                   Container(
//                     margin: EdgeInsets.only(
//                         top: MediaQuery.of(context).size.height * 0.16),
//                     child: const Text(
//                       // "እንኳን ደህና መጡ !",
//                       "ፍኖተ ብርሃን",
//                       style: TextStyle(
//                           fontSize: 30, color: ColorResources.textColor),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                   const SizedBox(height: 28),
//                   Container(
//                     padding: EdgeInsets.only(left: 20),
//                     child: const Text(
//                       "እንኳን ደህና መጡ ስልክ ቁጥር በማስገባት ወደ መተግበሪያው ይግቡ ",
//                       style: TextStyle(
//                           fontSize: 15, color: ColorResources.textColor),
//                       textAlign: TextAlign.start,
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   Card(
//                     color: Colors.white,
//                     elevation: 0.2,
//                     margin: EdgeInsets.symmetric(
//                       horizontal: MediaQuery.of(context).size.width * 0.04,
//                       // vertical: MediaQuery.of(context).size.height * 0.1,
//                     ),
//                     child: Container(
//                       alignment: Alignment.center,
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 16, vertical: 26),
//                       child: Column(children: [
//                         Form(
//                           key: _formKey,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const SizedBox(
//                                 height: 20,
//                               ),
//                               IntlPhoneField(
//                                 controller: _phoneController,
//                                 showCountryFlag: false,
//                                 autovalidateMode:
//                                     AutovalidateMode.onUserInteraction,
//                                 decoration: const InputDecoration(
//                                   labelText: 'ስልክ ቁጥር',
//                                   border: OutlineInputBorder(
//                                     borderSide: BorderSide(
//                                         color:
//                                             ColorResources.lightSecondaryColor),
//                                   ),
//                                 ),
//                                 initialCountryCode: 'ET',
//                                 onChanged: (phone) {
//                                   phoneNumber = phone.completeNumber;
//                                 },
//                                 validator: (value) {
//                                   return value == null ||
//                                           value.completeNumber.isEmpty
//                                       ? "please enter phone number"
//                                       : null;
//                                 },
//                               ),
//                               SizedBox(height: 20),
//                               ElevatedButton(
//                                 style: ButtonStyle(
//                                   padding: MaterialStateProperty.all(
//                                     const EdgeInsets.symmetric(vertical: 15),
//                                   ),
//                                   fixedSize: MaterialStateProperty.all(
//                                       Size.fromHeight(55)),
//                                   alignment: Alignment.center,
//                                   backgroundColor: MaterialStateProperty.all(
//                                       ColorResources.secondaryColor),
//                                   shape: MaterialStateProperty.all(
//                                     RoundedRectangleBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(150)),
//                                   ),
//                                 ),
//                                 onPressed: () async {
//                                   if (!isLoading) {
//                                     await login();
//                                   }
//                                 },
//                                 child: state.authStatus.isLoading
//                                     ? const Center(
//                                         child: FittedBox(
//                                           // width: 20,
//                                           // height: 20,
//                                           child: SpinKitFadingCircle(
//                                             color: ColorResources.primaryColor,
//                                           ),
//                                         ),
//                                       )
//                                     : Container(
//                                         // width: MediaQuery.of(context).size.width *
//                                         //     0.3,
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           children: const [
//                                             Text("ይግቡ"),
//                                             // SizedBox(
//                                             //   width: 20,
//                                             //   height: 50,
//                                             // ),
//                                             // Icon(Icons.arrow_forward)
//                                           ],
//                                         ),
//                                       ),
//                               )
//                             ],
//                           ),
//                         )
//                       ]),
//                     ),
//                   ),
//                 ],
//               );
//             }),
//           ),
//         ),
//       ),
//     );
//   }
// }
