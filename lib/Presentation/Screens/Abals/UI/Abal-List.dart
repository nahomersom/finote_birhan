import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:finote_birhan_mobile/Business%20Logic/Bloc/cubit/abal_registration/abal_registration_cubit.dart';
import 'package:finote_birhan_mobile/Business%20Logic/Bloc/cubit/abals/abals_cubit.dart';

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
    var sizeH = MediaQuery.of(context).size.height;
    var sizeW = MediaQuery.of(context).size.width;

    return SafeArea(child: Scaffold(
      body: BlocBuilder<AbalsListCubit, AbalListState>(
        builder: (BuildContext context, state) {
          if (state.abalsListStatus.isSuccess) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: filterUsers,
                    decoration: const InputDecoration(
                      labelText: 'Search',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredUsers.length,
                    itemBuilder: (BuildContext context, int index) {
                      return UserListItem(user: filteredUsers[index]);
                    },
                  ),
                ),
              ],
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
              Text('ዝግጅት ላይ'),
            ],
          );
        },
      ),
    ));
  }
}

class User {
  final String fullName;
  final int age;
  final String email;

  User(this.fullName, this.age, this.email);
}

class UserListItem extends StatelessWidget {
  final User user;

  const UserListItem({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(user.fullName[0]),
      ),
      title: Text(user.fullName),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Age: ${user.age}'),
          Text('Email: ${user.email}'),
        ],
      ),
    );
  }
}
