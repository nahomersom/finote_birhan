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
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
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
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(abal.abal.imagePath),
            ),
            // title: Text(user.fullName),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  abal.abal.fullName,
                  style: textTheme.bodySmall
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
                Text(
                  abal.abal.kifile,
                  style: textTheme.bodySmall,
                ),
              ],
            ),
            trailing: PopupMenuButton<String>(
              color: Colors.white,
              onSelected: (value) {
                // Handle the selected option here
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
              icon: const Icon(Icons.more_vert), // Three-dot vertical icon
            ),
          ),
        ),
      ),
    );
  }
}
