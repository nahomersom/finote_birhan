import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:finote_birhan_mobile/Business%20Logic/Bloc/cubit/abals/abal_cubit.dart';
import 'package:finote_birhan_mobile/Data/Data%20Providers/light_theme.dart';

import '../../../../Data/Data Providers/colors.dart';

class KifileSelector extends StatefulWidget {
  const KifileSelector({super.key});

  @override
  State<KifileSelector> createState() => _KifileSelectorState();
}

class _KifileSelectorState extends State<KifileSelector> {
  @override
  Widget build(BuildContext context) {
    var sizeH = MediaQuery.of(context).size.height;
    var sizeW = MediaQuery.of(context).size.width;

    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: ColorResources.scaffoldColor,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: SafeArea(
        child: Scaffold(
          body: BlocBuilder<AbalCubit, AbalState>(
            builder: (BuildContext context, state) {
              if (state.abalStatus.isSuccess) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Text(
                            'ለመመዝገብ የፈለጉት አባል',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'ከታች ከተዘረዘሩት ውስጥ ሊመዘገብ የመጣውን የመጣውን የአባል ክፍል በመምረጥ ወደቀጣዪ ይለፉ',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                    color: ColorResources.lightSecondaryColor,
                                    fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: sizeH * 0.03,
                          ),
                          Column(
                              children: List.generate(
                            state.kifiles.length,
                            (index) => Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8.0), // Adds spacing between tiles
                              decoration: BoxDecoration(
                                color: Colors
                                    .white, // Set background color to white
                                borderRadius: BorderRadius.circular(
                                    10), // Add border radius
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors
                                        .black12, // Optional shadow for better separation
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: ListTile(
                                title: Text(
                                  state.kifiles.elementAt(index)['name'],
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                ),
                                leading: Radio(
                                  activeColor: ColorResources.secondaryColor,
                                  value: state.kifiles.elementAt(index),
                                  groupValue: state.kifiles.elementAt(0),
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                ),
                              ),
                            ),
                          )),
                        ],
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Theme(
                          data: lightTheme,
                          child: TextButton(
                            onPressed: () {
                              BlocProvider.of<AbalCubit>(context)
                                  .getNestedKifiles(
                                      state.kifiles.elementAt(0)['id'],
                                      state.kifiles
                                          .elementAt(0)['childCollectionName']);
                              context.go('/dashboard/kifile/registration');
                            },
                            child: Text(
                              'ወደ ቀጣይ',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }
              return const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SpinKitFadingCircle(
                      color: ColorResources.secondaryColor,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('ዝግጅት ላይ')
                  ]);
            },
          ),
        ),
      ),
    );
  }
}
