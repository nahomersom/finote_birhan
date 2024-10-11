import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finote_birhan_mobile/Business%20Logic/Bloc/cubit/abals/abal_cubit.dart';
import 'package:finote_birhan_mobile/Data/Data%20Providers/colors.dart';
import 'package:finote_birhan_mobile/Presentation/Screens/Home/Widgets/dashboard_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});
  final List<String> imageList = [
    'https://i.pinimg.com/236x/5f/13/26/5f13268325d2f87fc621b81c424626db.jpg',
    'https://freedesignfile.com/upload/2018/10/Stock-Photo-Beautiful-woman-face-with-perfect-makeup-02-2.jpg',
    'https://www.refinery29.com/images/11012605.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTvi7HpQ-_PMSMOFrj1hwjp6LDcI-jm3Ro0Xw&s',
  ];
  @override
  Widget build(BuildContext context) {
    var sizeH = MediaQuery.of(context).size.height;
    var sizeW = MediaQuery.of(context).size.width;
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: ColorResources.scaffoldColor,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: sizeH * 0.17,
                color: ColorResources.scaffoldColor,
                child: const Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(
                                    'https://images.pexels.com/photos/1681010/pexels-photo-1681010.jpeg?auto=compress&cs=tinysrgb&w=800'),
                              ),
                              SizedBox(width: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'ሰላም',
                                  ),
                                  Text('ሰላም'),
                                ],
                              ),
                            ],
                          ),
                          Icon(
                            Icons.notifications_none_outlined,
                            size: 25,
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Divider(
                        color: ColorResources.scaffoldColor,
                      ),
                      // SizedBox(height: 5),
                      // Expanded(
                      //   child: SearchPage(),
                      // ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Container(
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.stretch,
                        //     children: [
                        //       Text(
                        //         'የክፍሌ ልጆች',
                        //         style: Theme.of(context)
                        //             .textTheme
                        //             .titleMedium
                        //             ?.copyWith(
                        //                 color: Colors.black,
                        //                 fontWeight: FontWeight.bold),
                        //       ),
                        //       const SizedBox(height: 10),
                        //       SizedBox(
                        //         height: 100,
                        //         child: ListView(
                        //           scrollDirection: Axis.horizontal,
                        //           physics: const BouncingScrollPhysics(),
                        //           children: List.generate(
                        //             7,
                        //             (index) => Column(
                        //               children: [
                        //                 const Padding(
                        //                   padding: EdgeInsets.only(right: 10),
                        //                   child: CircleAvatar(
                        //                     radius: 30,
                        //                     backgroundImage: NetworkImage(
                        //                         'https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg?auto=compress&cs=tinysrgb&w=800'),
                        //                   ),
                        //                 ),
                        //                 const SizedBox(height: 10),
                        //                 Text(
                        //                   'አበበ',
                        //                   style: Theme.of(context)
                        //                       .textTheme
                        //                       .titleSmall
                        //                       ?.copyWith(
                        //                         fontWeight: FontWeight.bold,
                        //                         color: Colors.black,
                        //                       ),
                        //                 ),
                        //               ],
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        CarouselSlider(
                          options: CarouselOptions(height: 140, autoPlay: true),
                          items: imageList
                              .map(
                                (data) => Builder(
                                  builder: (BuildContext context) => Stack(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: const DecorationImage(
                                            image: AssetImage(
                                                'assets/images/kids.jpg'), // Pass the image URL
                                            fit: BoxFit
                                                .cover, // Cover the entire area
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          gradient: LinearGradient(
                                            colors: [
                                              const Color(0xff6115da)
                                                  .withOpacity(
                                                      0.7), // Opacity set to 50%
                                              const Color(0xffbd2aec)
                                                  .withOpacity(
                                                      0.7), // Opacity set to 50%
                                            ],
                                            stops: const [0, 1],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList(), // Convert the map to a list
                        ),

                        const SizedBox(height: 10),
                        Text(
                          'አገልግሎቶች',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisSpacing: 10.0,
                            crossAxisSpacing: 5.0,
                            // childAspectRatio: 1,
                          ),
                          itemCount: dashboardItems.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final item = dashboardItems[index];
                            return DashboardCard(
                              height: 50, // Set the desired height here
                              text: item.text,
                              icon: item.icon,
                              onTap: () => item.onTap(context),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardItem {
  final String text;
  final IconData icon;
  final Function(BuildContext context) onTap;

  DashboardItem({required this.text, required this.icon, required this.onTap});
}

final dashboardItems = [
  DashboardItem(
    text: 'አባል ምዝገባ',
    icon: Icons.app_registration_outlined,
    onTap: (context) {
      // Replace with your actual functionality
      BlocProvider.of<AbalCubit>(context).getKifiles();
      Get.toNamed('/dashboard/kifile');
    },
  ),
  DashboardItem(
    text: 'ህጻናት',
    icon: Icons.child_care_outlined,
    onTap: (context) {
      // Replace with your actual functionality
      BlocProvider.of<AbalCubit>(context).getAbals();
      Get.toNamed('/dashboard/abals');
    },
  ),
  DashboardItem(
    text: 'ውጤት',
    icon: Icons.receipt_outlined,
    onTap: (context) {
      // Replace with your actual functionality
      BlocProvider.of<AbalCubit>(context).getKifiles();
      Get.toNamed('/dashboard/kifile');
    },
  ),
  DashboardItem(
    text: 'አቴንዳንስ',
    icon: Icons.edit_calendar_outlined,
    onTap: (context) {
      // Replace with your actual functionality
      BlocProvider.of<AbalCubit>(context).getKifiles();
      Get.toNamed('/dashboard/kifile');
    },
  ),
  DashboardItem(
    text: 'ሪሶርሶች(መጽሀፎች)',
    icon: Icons.book_outlined,
    onTap: (context) {
      // Replace with your actual functionality
      BlocProvider.of<AbalCubit>(context).getKifiles();
      Get.toNamed('/dashboard/kifile');
    },
  ),
  DashboardItem(
    text: 'ማስታወሻዎች(ፎቶዎች)',
    icon: Icons.perm_media_outlined,
    onTap: (context) {
      // Replace with your actual functionality
      BlocProvider.of<AbalCubit>(context).getKifiles();
      Get.toNamed('/dashboard/kifile');
    },
  ),
  DashboardItem(
    text: 'ካላንደር',
    icon: Icons.calendar_month_outlined,
    onTap: (context) {
      // Replace with your actual functionality
      BlocProvider.of<AbalCubit>(context).getKifiles();
      Get.toNamed('/dashboard/kifile');
    },
  ),
  DashboardItem(
    text: 'ዜናዎች',
    icon: Icons.branding_watermark_outlined,
    onTap: (context) {
      // Replace with your actual functionality
      BlocProvider.of<AbalCubit>(context).getKifiles();
      Get.toNamed('/dashboard/kifile');
    },
  ),
];
