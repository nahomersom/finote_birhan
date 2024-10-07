import 'package:finote_birhan_mobile/Presentation/Screens/Home/UI/Dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:finote_birhan_mobile/Business%20Logic/Bloc/cubit/authentication/authentication_cubit.dart';
import 'package:finote_birhan_mobile/Data/Data%20Providers/colors.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:pinput/pinput.dart';
import '../../../../Utils/utils.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _smsCodeController = TextEditingController();
  String? smsCode;
  bool isLoading = false;
  bool authSuccess = false;
  String? phoneNumber;

  @override
  Widget build(BuildContext context) {
    final authenticationCubit = BlocProvider.of<AuthenticationCubit>(context);

    verifyCode(String? verificationId) async {
      await authenticationCubit.verifyOtp(
          verificationId!, _smsCodeController.text);
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(0),
          child: BlocConsumer<AuthenticationCubit, AuthenticationState>(
              listener: (context, state) {
            if (state.authStatus.authenticated) {
              Get.to(DashboardScreen());
            }
            if (state.authStatus.hasError) {
              Utils.showSnackBar(
                  context, state.errorMessage, Colors.red.shade400);
              if (state.verificationId == null) {
                Get.back();
              }
            }
          }, builder: (context, state) {
            return Column(children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                padding: const EdgeInsets.only(top: 120),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorResources.lightSecondaryColor),
                      child: const Icon(
                        Icons.lock_open_rounded,
                        color: Color.fromARGB(255, 119, 86, 160),
                        size: 45,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Center(
                      child: Text(
                        "ኮድ ያስገቡ",
                        style: TextStyle(
                          fontSize: 30,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Center(
                        child: Text(
                          "please enter the code sent to your phone ",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Pinput(
                            length: 6,
                            controller: _smsCodeController,
                            showCursor: true,
                            defaultPinTheme: PinTheme(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: ColorResources.secondaryColor)),
                              textStyle: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                            // onSubmitted: (value) {
                            //   setState(() {
                            //     smsCode = value;
                            //     print("onSubmited------ ${smsCode}");
                            //   });
                            // },
                          )),
                      Padding(
                          padding: const EdgeInsets.all(
                            30,
                          ),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              padding: WidgetStateProperty.all(
                                const EdgeInsets.symmetric(vertical: 15),
                              ),
                              fixedSize: WidgetStateProperty.all(
                                  const Size.fromHeight(55)),
                              alignment: Alignment.center,
                              backgroundColor: WidgetStateProperty.all(
                                  ColorResources.secondaryColor),
                              shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(150)),
                              ),
                            ),
                            onPressed: () async {
                              if (!isLoading) {
                                await verifyCode(state.verificationId);
                              }
                            },
                            child: state.authStatus.isLoading
                                ? const Center(
                                    child: FittedBox(
                                      child: SpinKitFadingCircle(
                                        color: ColorResources.primaryColor,
                                      ),
                                    ),
                                  )
                                : Container(
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("submit"),
                                        // SizedBox(
                                        //   width: 20,
                                        //   height: 50,
                                        // ),
                                        // Icon(Icons.arrow_forward)
                                      ],
                                    ),
                                  ),
                          ))
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
