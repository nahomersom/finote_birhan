import 'package:finote_birhan_mobile/Business%20Logic/Controllers/abal/abal_controller.dart';
import 'package:finote_birhan_mobile/Presentation/Components/search_bar.dart';
import 'package:finote_birhan_mobile/Presentation/Screens/Abals/Widgetes/user-list-item.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class AbalListScreen extends StatefulWidget {
  const AbalListScreen({super.key});

  @override
  AbalListScreenState createState() => AbalListScreenState();
}

class AbalListScreenState extends State<AbalListScreen> {
  final AbalController controller = Get.find<AbalController>();
  List<User> filteredUsers = [];
  final List<User> users = [
    User('John Doe', 25, 'john.doe@example.com'),
    User('Jane Smith', 30, 'jane.smith@example.com'),
    User('Mike Johnson', 35, 'mike.johnson@example.com'),
    // Add more users as needed
  ];
  @override
  void initState() {
    super.initState();
    // Fetch abals on initState
    controller.getAbals();
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
            padding: const EdgeInsets.only(bottom: 5.0),
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
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                  child: SearchPage(
                      onSearch: filterUsers), // Pass callback to filter users
                ),
                const SizedBox(height: 5),
              ],
            ),
          ),
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            // Show loading indicator when fetching data
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 10),
                  Text('Loading...'),
                ],
              ),
            );
          } else if (controller.hasError.value) {
            // Show error message when an error occurs
            return const Center(
              child: Text('Failed to load data.'),
            );
          } else if (controller.abals.isEmpty) {
            // Show placeholder when there are no abals
            return const Center(
              child: Text('No abals found.'),
            );
          } else {
            // Show the list of abals when data is successfully fetched
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio:
                      0.75, // Adjust this ratio to make the height larger (1.0 means width = height)
                ),
                itemCount: controller.abals.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: AbalListItem(abal: controller.abals[index]),
                  );
                },
              ),
            );
          }
        }),
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
