import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hisnate_kifele/Business%20Logic/Bloc/cubit/authentication/authentication_cubit.dart';
import 'package:hisnate_kifele/Data/Data%20Providers/light_theme.dart';
import 'package:hisnate_kifele/Presentation/Screens/Home/UI/Dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();

  bool isLoading = false;
  bool authSuccess = false;

  @override
  Widget build(BuildContext context) {
    final _authenticationCubit = BlocProvider.of<AuthenticationCubit>(context);
    login() async {
      if (_formKey.currentState!.validate()) {
        await _authenticationCubit
            .login(_emailController.text, _passwordController.text)
            .then((value) {});
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(0),
          child: BlocConsumer<AuthenticationCubit, AuthenticationState>(
              listener: (context, state) {
            if (state.authStatus.authenticated) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const DashboardScreen(),
                ),
              );
            }
            if (state.authStatus.hasError) {
              print(state.errorMessage);
            }
          }, builder: (context, state) {
            if (state.authStatus.hasError) {
              print(state.errorMessage);
            }
            return Column(children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                padding: const EdgeInsets.only(top: 120),
                // child: Image.asset(
                //   "assets/images/bible_study_no_bg.png",
                //   opacity: const AlwaysStoppedAnimation(.6),
                //   height: 310,
                //   width: 310,
                //   alignment: Alignment.center,
                // ),
              ),
              Expanded(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 18),
                        child: Text(
                          "እንኳን ደህና መጡ !",
                          style: TextStyle(
                            fontSize: 30,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            label: Text("ኢሚይል"),

                            // icon: Icon(Icons.person),
                          ),
                          validator: (value) {
                            return RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value!)
                                ? null
                                : "Please Enter Correct Email";
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            label: Text("የይለፍ ቃል"),
                            // icon: Icon(Icons.remove_red_eye_rounded),
                          ),
                          validator: (value) {
                            return value == null || value.isEmpty
                                ? "Please Enter password"
                                : null;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 30,
                            left: MediaQuery.of(context).size.width * 0.55,
                            right: 30),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            // padding: MaterialStateProperty.all(
                            //   const EdgeInsets.symmetric(
                            //       horizontal: 50, vertical: 20),
                            // ),

                            backgroundColor:
                                MaterialStateProperty.all(Color(0xff686FC6)),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(150)),
                            ),
                          ),
                          onPressed: () async {
                            if (!isLoading) {
                              await login();
                            }
                          },
                          child: state.authStatus.isLoading
                              ? const Center(
                                  child: SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  ),
                                )
                              : Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: const [
                                      Text("ይግቡ"),
                                      SizedBox(
                                        width: 20,
                                        height: 50,
                                      ),
                                      Icon(Icons.arrow_forward)
                                    ],
                                  ),
                                ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ]);
          }),
        ),
      ),
    );
  }
}
