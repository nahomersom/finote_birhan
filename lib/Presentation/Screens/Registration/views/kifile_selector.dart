import 'package:finote_birhan_mobile/Business%20Logic/Controllers/abal/abal_controller.dart';
import 'package:finote_birhan_mobile/Presentation/Components/shared_button.dart';
import 'package:finote_birhan_mobile/Presentation/Components/spinner.dart';
import 'package:finote_birhan_mobile/Presentation/Routes/app_navigator.dart';
import 'package:finote_birhan_mobile/Presentation/Screens/Registration/controllers/form_controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:finote_birhan_mobile/Business%20Logic/Bloc/cubit/abals/abal_cubit.dart';
import 'package:finote_birhan_mobile/Data/Data%20Providers/light_theme.dart';
import 'package:finote_birhan_mobile/Presentation/Screens/Registration/widgets/progress_indicator.dart';

import '../../../../Data/Data Providers/colors.dart';

class KifileSelector extends StatefulWidget {
  const KifileSelector({super.key, required this.navigateToNextPage});
  final VoidCallback navigateToNextPage; // Passed from parent

  @override
  State<KifileSelector> createState() => _KifileSelectorState();
}

class _KifileSelectorState extends State<KifileSelector> {
  int? selectedIndex = 0;
  final AbalController controller = Get.find<AbalController>();
  final formController = Get.put(FormController()); // Initialize the controller

  @override
  void initState() {
    formController.kifile = 'ህጻናት';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var sizeH = MediaQuery.of(context).size.height;
    TextTheme textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<AbalCubit, AbalState>(
          builder: (BuildContext context, state) {
            if (state.abalStatus.isSuccess) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and description section
                    Text(
                      'ለመመዝገብ የፈለጉት አባል',
                      style: textTheme.bodyMedium?.copyWith(
                          color: Color(0xff040404),
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'ከታች ከተዘረዘሩት ውስጥ ሊመዘገብ የመጣውን የመጣውን የአባል ክፍል በመምረጥ ወደቀጣዪ ይለፉ',
                      style: textTheme.titleSmall?.copyWith(
                          color: ColorResources.lightSecondaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: sizeH * 0.03),

                    // Expanded to ensure GridView takes available space
                    Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Number of columns
                          mainAxisSpacing: 15.0,
                          crossAxisSpacing: 15.0,
                        ),
                        itemCount: state.kifiles.length,
                        itemBuilder: (context, index) {
                          String kifileType =
                              state.kifiles.elementAt(index)['name'];

                          // TweenAnimationBuilder for animation on appearance
                          return TweenAnimationBuilder(
                            tween: Tween<double>(
                                begin: 0.0, end: 1.0), // Animation from 0 to 1
                            duration: const Duration(
                                milliseconds: 500), // Animation duration
                            curve: Curves.easeInOut, // Animation curve
                            builder: (context, double value, child) {
                              return Opacity(
                                opacity: value, // Apply opacity animation
                                child: Transform.scale(
                                  scale: value, // Apply scaling animation
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (index == 0) {
                                          selectedIndex =
                                              index; // Update the selected index
                                          formController.kifile = kifileType;
                                        }
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: selectedIndex ==
                                                index // Check if this container is selected
                                            ? const LinearGradient(
                                                colors: [
                                                  Color(0xff6115da),
                                                  Color(0xffbd2aec)
                                                ],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                              )
                                            : null, // Default gradient for the selected item
                                        color: selectedIndex ==
                                                index // Set white for non-selected containers
                                            ? null
                                            : Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            spreadRadius: 1,
                                            blurRadius: 4,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(
                                            selectedIndex == index ? 15 : 10),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          selectedIndex == index
                                              ? Icon(
                                                  _getIconForType(kifileType),
                                                  size: 80,
                                                  color: Colors.white)
                                              : ShaderMask(
                                                  shaderCallback: (bounds) =>
                                                      const LinearGradient(
                                                    colors: [
                                                      Color(0xff6115da),
                                                      Color(0xffbd2aec)
                                                    ],
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                  ).createShader(bounds),
                                                  child: Icon(
                                                      _getIconForType(
                                                          kifileType),
                                                      size: 80,
                                                      color: Colors.white),
                                                ),
                                          Text(
                                            kifileType,
                                            style: TextStyle(
                                              color: selectedIndex == index
                                                  ? Colors
                                                      .white // Change text color to white if selected
                                                  : Colors
                                                      .black, // Text color when not selected
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    SharedButton(
                      buttonText: 'ወደ ቀጣይ',
                      onTap: () {
                        controller.getNestedKifiles(
                          state.kifiles.elementAt(0)['id'],
                          state.kifiles.elementAt(0)['childCollectionName'],
                        );
                        widget.navigateToNextPage();
                        // AppNavigator.startAbalFormRegistration();
                      },
                    )
                  ],
                ),
              );
            }

            // Loading spinner if state is loading or not successful yet
            return const Center(child: Spinner());
          },
        ),
      ),
    );
  }

  // Helper function to get the icon based on the kifileType
  IconData _getIconForType(String kifileType) {
    switch (kifileType) {
      case 'ህጻናት':
        return Icons.child_care_outlined;
      case 'ማዕከላውያን':
        return Icons.boy_outlined;
      default:
        return Icons.emoji_people_outlined;
    }
  }
}
