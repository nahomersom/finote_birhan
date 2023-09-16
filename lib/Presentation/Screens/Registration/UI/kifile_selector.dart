import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:hisnate_kifele/Business%20Logic/Bloc/cubit/abal_registration/abal_registration_cubit.dart';

import '../../../../Data/Data Providers/colors.dart';

class KifileSelector extends StatefulWidget {
  const KifileSelector({Key? key}) : super(key: key);

  @override
  State<KifileSelector> createState() => _KifileSelectorState();
}

class _KifileSelectorState extends State<KifileSelector> {
  @override
  Widget build(BuildContext context) {
    var sizeH = MediaQuery.of(context).size.height;
    var sizeW = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<AbalCubit, AbalRegistrationState>(
          builder: (BuildContext context, state) {
            if (state.abalRegistrationStatus.isSuccess) {
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
                              .displayLarge
                              ?.copyWith(
                                  color: ColorResources.textColor,
                                  fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
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
                          (index) => ListTile(
                            title: Text(
                              state.kifiles.elementAt(index)['name'],
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge
                                  ?.copyWith(fontWeight: FontWeight.w500),
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
                        )),
                      ],
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.all(0),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          backgroundColor: ColorResources.secondaryColor,
                        ),
                        onPressed: () {
                          BlocProvider.of<AbalCubit>(context).getNestedKifiles(
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
                              ?.copyWith(color: ColorResources.primaryColor),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
            return Column(
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
    );
  }
}
