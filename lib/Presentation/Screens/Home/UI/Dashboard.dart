import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hisnate_kifele/Business%20Logic/Bloc/cubit/abal_registration/abal_registration_cubit.dart';
import 'package:hisnate_kifele/Business%20Logic/Bloc/cubit/abals/abals_cubit.dart';
import 'package:hisnate_kifele/Data/Data%20Providers/colors.dart';
import 'package:hisnate_kifele/Presentation/Routes/routes.dart';
import 'package:hisnate_kifele/Presentation/Screens/Registration/UI/kifile_selector.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var sizeH = MediaQuery.of(context).size.height;
    var sizeW = MediaQuery.of(context).size.width;

    //  return Stack(
    //    children: [
    //      Container(

    //        height: double.infinity,
    //        decoration:  BoxDecoration(
    //            gradient: LinearGradient(
    //              begin: Alignment.topLeft,
    //              end: Alignment.bottomRight,
    //              stops: const [
    //                0.1,
    //                0.9,

    //              ],
    //              colors: [

    //                 ColorResources.secondaryColor,
    //                ColorResources.secondaryColor.withOpacity(0.65),
    //              ],
    //            )
    //        ),
    //      ),
    //      Container(
    //        margin: EdgeInsets.only(top: sizeH * 0.33),
    //        height: double.infinity,
    //        decoration:  const BoxDecoration(
    //          color: ColorResources.primaryColor,
    //          borderRadius: BorderRadius.only(topLeft:Radius.circular(30),topRight:Radius.circular(30))
    //        ),
    //        child: Padding(
    //          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 40),
    //          child: Column(
    //            crossAxisAlignment: CrossAxisAlignment.stretch,
    //            children: [
    //              Text('ድርጊቶች',  style: Theme.of(context)
    //       .textTheme
    //       .displayMedium
    //       ?.copyWith(color: ColorResources.textColor),
    //   ),
    //              SizedBox(height: sizeH * 0.03,),
    //              Expanded(
    //                child: Row(
    //                  children: [
    //                    Expanded(
    //                        child: InkWell(
    //                           onTap: () {
    //                             BlocProvider.of<AbalCubit>(context).getKifiles();
    //                             context.go('/dashboard/kifile');
    //                             },
    //                            // onTap:()=>{ Navigator.pushNamed(context, RouteHelper.kifileSelector)},
    //                            child: DashboardCard(sizeH: sizeH, text: 'አባል ምዝገባ', icon: Icons.account_balance,))),
    //                    SizedBox(width: sizeW * 0.02,),
    //                    Expanded(
    //                        child: DashboardCard(sizeH: sizeH, text: 'ክፍል ዝውውር', icon: Icons.account_balance,)),
    //                    SizedBox(width: sizeW * 0.02,),
    //                    Expanded(
    //                        child: DashboardCard(sizeH: sizeH, text: 'ተጠሪ መመዝገብ', icon: Icons.account_balance,)),
    //                  ],
    //                ),
    //              ),
    //              SizedBox(height: sizeH * 0.01,),
    //              Expanded(child:   Row(
    //                children: [
    //                  Expanded(
    //                      child: DashboardCard(sizeH: sizeH, text: 'የአባላት ዝርዝር', icon: Icons.account_balance,)),
    //                  SizedBox(width: sizeW * 0.02,),
    //                  Expanded(
    //                      child: DashboardCard(sizeH: sizeH, text: 'ንብረት ምዝገባ', icon: Icons.account_balance,)),
    //                  SizedBox(width: sizeW * 0.02,),
    //                  Expanded(
    //                      child: DashboardCard(sizeH: sizeH, text: 'ዩኒፎርም መስጠት', icon: Icons.account_balance,)),
    //                ],
    //              ),
    //              ),

    //              SizedBox(height: sizeH * 0.01,),
    //              Expanded(
    //                child: Row(
    //                  children: [
    //                    Expanded(
    //                        child: DashboardCard(sizeH: sizeH, text: 'አባል ምዝገባ', icon: Icons.account_balance,)),
    //                    SizedBox(width: sizeW * 0.02,),
    //                    Expanded(
    //                        child: DashboardCard(sizeH: sizeH, text: 'አባል ምዝገባ', icon: Icons.account_balance,)),
    //                    SizedBox(width: sizeW * 0.02,),
    //                    Expanded(
    //                        child: DashboardCard(sizeH: sizeH, text: 'አባል ምዝገባ', icon: Icons.account_balance,)),
    //                  ],
    //                ),
    //              )

    //            ],
    //          ),

    //        ),
    //      )
    //    ],
    //  );
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
                top: 0,
                right: 0,
                child: ClipPath(
                  clipper: MyImageClipper(),
                  child: Container(
                    height: sizeH * 0.25,
                    width: sizeW * 0.7,
                    color: Color(0xffE7EDF7),
                    child: const Padding(
                      padding: EdgeInsets.all(40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 35,
                            backgroundColor: Color(0xff151A5C),
                            child: Icon(
                              Icons.notifications_on_outlined,
                              size: 40,
                              color: ColorResources.primaryColor,
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.message_outlined,
                              size: 40,
                              color: Color(0xff151A5C),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
            Container(
                margin: EdgeInsets.only(top: sizeH * 0.28),
                height: sizeH * 0.65,
                padding: EdgeInsets.all(25),
                decoration: const BoxDecoration(
                    color: Color(0xffE7EDF7),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'የክፍሌ ልጆች',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: Color(0xff151A5C)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: ListView(
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          children: List.generate(
                              18,
                              (index) => Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(right: 10),
                                        child: CircleAvatar(
                                          radius: 40,
                                          backgroundImage: NetworkImage(
                                              'https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg?auto=compress&cs=tinysrgb&w=800'),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'አበበ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xffA3ADB6)),
                                      )
                                    ],
                                  ))),
                    ),
                  ],
                )),
            Container(
              margin: EdgeInsets.only(top: sizeH * 0.5),
              height: sizeH * 0.65,
              decoration: const BoxDecoration(
                  color: ColorResources.primaryColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(children: [
                    Row(children: [
                      DashboardCard(
                        sizeH: sizeH,
                        text: 'አባል ምዝገባ',
                        imageUrl: 'assets/images/abal-register.png',
                        onTap: () {
                          BlocProvider.of<AbalCubit>(context).getKifiles();
                          context.go('/dashboard/kifile');
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      DashboardCard(
                        sizeH: sizeH,
                        text: 'የአባል ዝርዝር',
                        imageUrl: 'assets/images/abal-list.png',
                        onTap: () {
                          BlocProvider.of<AbalsListCubit>(context).getAbals();
                          context.go('/dashboard/abals');
                        },
                      ),
                    ]),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(children: [
                      DashboardCard(
                        sizeH: sizeH,
                        text: 'የአባል ዝውውር',
                        imageUrl: 'assets/images/abal-transfer.png',
                        onTap: () {
                          BlocProvider.of<AbalCubit>(context).getKifiles();
                          context.go('/dashboard/kifile');
                        },
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      DashboardCard(
                        sizeH: sizeH,
                        text: 'ተጠሪ መመዝገብ',
                        imageUrl: 'assets/images/teteri-register.png',
                        onTap: () {
                          BlocProvider.of<AbalCubit>(context).getKifiles();
                          context.go('/dashboard/kifile');
                        },
                      ),
                    ]),
                    SizedBox(
                      height: 10,
                    ),
                    Row(children: [
                      DashboardCard(
                        sizeH: sizeH,
                        text: 'ዩኒፎርም መስጠት',
                        imageUrl: 'assets/images/clothes-rack.png',
                        onTap: () {
                          BlocProvider.of<AbalCubit>(context).getKifiles();
                          context.go('/dashboard/kifile');
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      DashboardCard(
                        sizeH: sizeH,
                        text: 'ንብረት መመዝገብ',
                        imageUrl: 'assets/images/inventory.png',
                        onTap: () {
                          BlocProvider.of<AbalCubit>(context).getKifiles();
                          context.go('/dashboard/kifile');
                        },
                      ),
                    ]),
                  ]),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: Color(0xffE7EDF7),
                        child: Icon(
                          Icons.menu,
                          color: Color(0xff2B306B),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: sizeH * 0.08,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(
                                'https://images.pexels.com/photos/1681010/pexels-photo-1681010.jpeg?auto=compress&cs=tinysrgb&w=800'),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'ሽዋንግዛው ሀብቴ',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff2B306B)),
                        )
                      ],
                    ),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}

class MyImageClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path path = Path();

    path.lineTo(0.0, size.height - 200);

    var firstControlPoint = Offset(size.width / 2, size.height - 10);

    var firstEndPoint = Offset(size.width / 2.25, size.height - 80);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondEndPoint = Offset(size.width, size.height - 50);

    var secondControlPoint =
        Offset(size.width - (size.width / 1.25), size.height - 45);

    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height - 40);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class DashboardCard extends StatelessWidget {
  const DashboardCard(
      {super.key,
      required this.sizeH,
      required this.text,
      required this.imageUrl,
      required this.onTap});

  final double sizeH;
  final String text;
  final String imageUrl;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: sizeH * 0.2,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              border: Border.all(color: Color(0xffA3ADB6).withOpacity(0.3))),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Expanded(child: Image.asset(height: 10, width: 100, imageUrl)),
                SizedBox(
                  height: 20,
                ),
                Text(
                  text,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold, color: Color(0xffAAB3BC)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
