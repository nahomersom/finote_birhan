import 'package:finote_birhan_mobile/Business%20Logic/Bloc/cubit/abals/abal_cubit.dart';
import 'package:finote_birhan_mobile/Data/Data%20Providers/app_constants.dart';
import 'package:finote_birhan_mobile/Data/Models/abal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AbalListItem extends StatelessWidget {
  final AbalRegistrationModel abal;

  const AbalListItem({super.key, required this.abal});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        height: 300,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(abal.abal.imagePath),
            fit: BoxFit.cover,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: Colors.white,
          border: Border.all(color: const Color(0xffA3ADB6).withOpacity(0.3)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2), // Shadow color
              spreadRadius: 1, // How wide the shadow spreads
              blurRadius: 4, // How blurry the shadow is
              offset: const Offset(0, 2), // Position of the shadow (x, y)
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 0, // Align to the bottom
              left: 0,
              right: 0, // Make it full width
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 3,
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xff6115da)
                          .withOpacity(0.7), // Opacity set to 50%
                      const Color(0xffbd2aec)
                          .withOpacity(0.7), // Opacity set to 50%
                    ],
                    stops: const [0, 1],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          abal.abal.fullName,
                          style: textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Colors
                                .white, // White text to contrast background
                          ),
                        ),
                        Text(
                          abal.abal.kifile,
                          style: textTheme.bodySmall?.copyWith(
                            color: Colors
                                .white, // White text to contrast background
                          ),
                        ),
                      ],
                    ),
                    PopupMenuButton<String>(
                      color: Colors.white,
                      onSelected: (value) {
                        switch (value) {
                          case 'Edit':
                            context.read<AbalCubit>().setSelectedAbal(abal);
                            break;
                          case 'Delete':
                            // Handle delete option
                            break;
                          default:
                            break;
                        }
                      },
                      itemBuilder: (BuildContext context) {
                        return <PopupMenuEntry<String>>[
                          const PopupMenuItem<String>(
                            value: 'Edit',
                            child: Text('Edit'),
                          ),
                          const PopupMenuItem<String>(
                            value: 'Delete',
                            child: Text('Delete'),
                          ),
                        ];
                      },
                      icon: const Icon(Icons.more_vert,
                          color: Colors.white), // White icon
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
