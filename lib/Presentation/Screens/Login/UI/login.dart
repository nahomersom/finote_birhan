import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:finote_birhan_mobile/Data/Data%20Providers/colors.dart';

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
                    decoration: const BoxDecoration(
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
                  const Text(
                    'Welcome Back',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: ColorResources.secondaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Login to your account',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 32),
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person),
                      labelText: 'Full Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      suffixIcon: const Icon(Icons.visibility),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Checkbox(value: true, onChanged: (value) {}),
                          const Text('Remember Me'),
                        ],
                      ),
                      const Text('Forgot Password?'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: ColorResources.secondaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(color: ColorResources.backgroundColor),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Sign up'),
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
//                 Get.toNamed('/dashboard');
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
