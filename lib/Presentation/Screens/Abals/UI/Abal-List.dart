import 'package:finote_birhan_mobile/Data/Data%20Providers/app_constants.dart';
import 'package:finote_birhan_mobile/Presentation/Components/search_bar.dart';
import 'package:finote_birhan_mobile/Presentation/Screens/Abals/Widgetes/user-list-item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:finote_birhan_mobile/Business%20Logic/Bloc/cubit/abals/abal_cubit.dart';

import '../../../../Data/Data Providers/colors.dart';

class AbalListScreen extends StatefulWidget {
  const AbalListScreen({super.key});

  @override
  _AbalListScreenState createState() => _AbalListScreenState();
}

class _AbalListScreenState extends State<AbalListScreen> {
  final List<User> users = [
    User('John Doe', 25, 'john.doe@example.com'),
    User('Jane Smith', 30, 'jane.smith@example.com'),
    User('Mike Johnson', 35, 'mike.johnson@example.com'),
    // Add more users as needed
  ];

  List<User> filteredUsers = [];

  @override
  void initState() {
    super.initState();
    filteredUsers = users;
  }

  void filterUsers(String query) {
    setState(() {
      filteredUsers = users
          .where((user) =>
              user.fullName.toLowerCase().contains(query.toLowerCase()) ||
              user.email.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(
                bottom: 5.0), // Reduce bottom padding of the title
            child: Text(
              'የአባል ዝርዝር',
              style:
                  textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize:
                const Size.fromHeight(80.0), // Adjust height for search bar
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 10),
                  child: SearchPage(
                      onSearch: filterUsers), // Pass callback to filter users
                ),
                const SizedBox(height: 5),
              ],
            ),
          ),
        ),
        body: BlocBuilder<AbalCubit, AbalState>(
          builder: (BuildContext context, state) {
            if (state.abalStatus.isSuccess) {
              return Padding(
                padding: const EdgeInsets.all(AppConstants.bodyPadding),
                child: ListView.separated(
                  itemCount: state.abals.length,
                  itemBuilder: (BuildContext context, int index) {
                    return AbalListItem(abal: state.abals[index]);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(
                      color: Colors.black,
                      thickness: 0.2,
                    );
                  },
                ),
              );
            }

            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SpinKitFadingCircle(
                    color: ColorResources.secondaryColor,
                  ),
                  SizedBox(height: 10),
                  Text('ዝግጅት ላይ'),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class User {
  final String fullName;
  final int age;
  final String email;

  User(this.fullName, this.age, this.email);
}
