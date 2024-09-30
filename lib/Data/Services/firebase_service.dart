import 'dart:convert';
import 'package:finote_birhan_mobile/Data/Services/user_service.dart';
import 'package:finote_birhan_mobile/global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

/*
This class represent all possible CRUD operation for FirebaseFirestore.
It contains all generic implementation needed based on the provided document
path and documentID,since most of the time in FirebaseFirestore design, we will have
documentID and path for any document and collections.
 */

class FirestoreService {
  User? currentUser = FirebaseAuth.instance.currentUser;

  Future<void> storeFCMToken(String userId, String fcmToken) async {
    try {
      CollectionReference fcmtokenCollection =
          FirebaseFirestore.instance.collection('fcmtoken');

      // Get the document reference based on the user ID
      DocumentReference userDocument = fcmtokenCollection.doc(userId);

      // Get the current FCM tokens
      DocumentSnapshot userSnapshot = await userDocument.get();

      List<String> fcmTokens = <String>[];

      if (userSnapshot.exists) {
        // If the document exists, retrieve the 'tokens' field
        dynamic tokensData = userSnapshot.data();

        // Check if 'tokens' is a List of Strings
        if (tokensData['tokens'] is List<dynamic>) {
          // Corrected the line below
          fcmTokens = List<String>.from(tokensData['tokens']);
        }
      }

      // Check if the token already exists
      if (!fcmTokens.contains(fcmToken)) {
        // Add the new token to the array
        fcmTokens.add(fcmToken);

        // Update the document with the new array of tokens
        await userDocument.set({'tokens': fcmTokens});
      }

      print('FCM Token stored successfully for user $userId');
    } catch (error) {
      print('Error storing FCM Token: $error');
    }
  }

  Future<List<dynamic>> getDeviceTokens(userId) async {
    final DocumentSnapshot userDeviceToken = await FirebaseFirestore.instance
        .collection('fcmtoken')
        .doc(userId)
        .get();

    print(
        'userDeviceToken stored successfully for user ${userDeviceToken.data()}');
    if (userDeviceToken.exists) {
      dynamic deviceTokens = userDeviceToken.data();

      return deviceTokens['tokens'] ?? [];
    } else {
      return [];
    }
  }

  Future<List<dynamic>> getAllDeviceTokens() async {
    final userDeviceToken =
        await FirebaseFirestore.instance.collection('fcmtoken').get();
    List<dynamic> tokens = userDeviceToken.docs
        .map((doc) => (doc.data())['tokens'] as List<dynamic>)
        .expand((tokenList) => tokenList)
        .toList();
    print("tokens --------------- $tokens");
    return tokens;
  }

  Future<QuerySnapshot> getDocumentsByCollection({required collectionName}) {
    return FirebaseFirestore.instance.collection(collectionName).get();
    // .then((QuerySnapshot querySnapshot) {
    // querySnapshot.docs.forEach((doc) {
    // print(doc["first_name"]);
    // });
  }

  Future<DocumentSnapshot> getDocumentById(
      {required collectionName, required id}) {
    return FirebaseFirestore.instance.collection(collectionName).doc(id).get();
    // .then((QuerySnapshot querySnapshot) {
    // querySnapshot.docs.forEach((doc) {
    // print(doc["first_name"]);
    // });
  }

  Future<QuerySnapshot> getDocumentsByMultipleId(
      {required collectionName, required List<String> ids}) {
    return FirebaseFirestore.instance
        .collection(collectionName)
        .where(FieldPath.documentId, whereIn: ids)
        .get();
    // .then((QuerySnapshot querySnapshot) {
    // querySnapshot.docs.forEach((doc) {
    // print(doc["first_name"]);
    // });
  }

  CollectionReference<Map<String, dynamic>> getCollectionReference(
      {required collectionName}) {
    return FirebaseFirestore.instance.collection(collectionName);
  }

  Future<void> set({
    required String path,
    required dynamic data,
    bool merge = false,
  }) async {
    print("DXDXDXDXDXDXDXXDDDDDDD");
    print('$path: $data');
    final reference = FirebaseFirestore.instance.doc(path);
    await reference.set(data);
  }

  Future<void> update({
    required String path,
    required dynamic data,
    bool merge = false,
  }) async {
    try {
      await FirebaseFirestore.instance.doc(path).update(data);
    } catch (e) {
      throw e;
    }
  }

  Future<String> addDocument({
    required String path,
    required dynamic data,
    bool merge = false,
  }) async {
    print("DXDXDXDXDXDXDXXDDDDDDD");
    print('$path: $data');
    final reference = FirebaseFirestore.instance.collection(path);
    print("reference-------------$reference");
    try {
      var res = await reference.add(data);
      print("added doc id ${res.id}");
      return res.id;
    } catch (e) {
      print("erorrr ---------------${e.toString()}");
      rethrow;
    }
  }

  Future<void> bulkSet({
    required String path,
    required List<Map<String, dynamic>> datas,
    bool merge = false,
  }) async {
    final reference = FirebaseFirestore.instance.doc(path);
    final batchSet = FirebaseFirestore.instance.batch();

//    for()
//    batchSet.

    print('$path: $datas');
  }

  Future<void> deleteData({required String path}) async {
    final reference = FirebaseFirestore.instance.doc(path);
    print('delete: $path');
    await reference.delete();
  }

  Future<List<QueryDocumentSnapshot>> searchUser(
      String searchText, String? accountType) async {
    try {
      print('accountType0000000000000000: $accountType');
      print(accountType);
      final CollectionReference userCollection =
          FirebaseFirestore.instance.collection('userAccounts');
      Query<Object> query = userCollection as Query<Object>;
      Query<Object> queryF = userCollection as Query<Object>;
      Query<Object> queryL = userCollection as Query<Object>;
      Query<Object> queryOrg = userCollection as Query<Object>;
      var searchTextLower = searchText.toLowerCase();

      List<QueryDocumentSnapshot> combinedResults = [];
      CurrentUser().loadCurrentUser();
      var currentUser = CurrentUser().userAccount;
      bool isCurrentUserAdmin = currentUser != null &&
          (currentUser.isAdmin || currentUser.accountType == "superAdmin");
      if (accountType != null) {
        print("inside iffffffffffffffffffffffffffffffffffffffffff");
        if (isCurrentUserAdmin) {
          print("is current admin");
          queryF = query
              .where("accountType", isEqualTo: "$accountType")
              .orderBy('firstNameSmall')
              .orderBy("status");

          queryL = query
              .where("accountType", isEqualTo: "$accountType")
              .orderBy("lastNameSmall")
              .orderBy("status");
          queryOrg = query
              .where("accountType", isEqualTo: "$accountType")
              .orderBy("organizationNameSmall")
              .orderBy("status");
        } else {
          print("not current admin");

          queryF = query
              .where("accountType", isEqualTo: "$accountType")
              .where("status", isEqualTo: true);

          queryL = query
              .where("accountType", isEqualTo: "$accountType")
              .where("status", isEqualTo: true);
          queryOrg = query
              .where("accountType", isEqualTo: "$accountType")
              .where("status", isEqualTo: true);
        }

        QuerySnapshot firstNameQuery = await queryF
            // .where('firstName', isGreaterThanOrEqualTo: searchText)
            // .where('firstName', isLessThanOrEqualTo: "$searchText\uf7ff")
            .where('firstNameSmall', isGreaterThanOrEqualTo: searchTextLower)
            .where('firstNameSmall',
                isLessThanOrEqualTo: "$searchTextLower\uf7ff")
            .get();

        QuerySnapshot lastNameQuery = await queryL
            // .where('lastName', isGreaterThanOrEqualTo: searchText)
            // .where('lastName', isLessThanOrEqualTo: "$searchText\uf7ff")
            .where('lastNameSmall', isGreaterThanOrEqualTo: searchTextLower)
            .where('lastNameSmall',
                isLessThanOrEqualTo: "$searchTextLower\uf7ff")
            .get();
        QuerySnapshot orgNameQuery = await queryOrg
            // .where('organizationName', isGreaterThanOrEqualTo: searchText)
            // .where('organizationName', isLessThanOrEqualTo: "$searchText\uf7ff")
            .where('organizationNameSmall',
                isGreaterThanOrEqualTo: searchTextLower)
            .where('organizationNameSmall',
                isLessThanOrEqualTo: "$searchTextLower\uf7ff")
            .get();
        // Combine the results
        combinedResults.addAll(firstNameQuery.docs);
        combinedResults.addAll(lastNameQuery.docs);
        combinedResults.addAll(orgNameQuery.docs);
      } else {
        if (isCurrentUserAdmin) {
          print("is current admin");

          queryF = query.orderBy('firstNameSmall').orderBy("status");
          queryL = query.orderBy("lastNameSmall").orderBy("status");
          queryOrg = query.orderBy("organizationNameSmall").orderBy("status");
        } else {
          queryF = query.where("status", isEqualTo: true);

          queryL = query.where("status", isEqualTo: true);
          queryOrg = query.where("status", isEqualTo: true);
        }

        QuerySnapshot firstNameStudentQuery = await queryF
            .where("accountType", isEqualTo: "student")
            // .where('firstName', isGreaterThanOrEqualTo: searchText)
            // .where('firstName', isLessThanOrEqualTo: "$searchText\uf7ff")
            .where('firstNameSmall', isGreaterThanOrEqualTo: searchTextLower)
            .where('firstNameSmall',
                isLessThanOrEqualTo: "$searchTextLower\uf7ff")
            .get();

        QuerySnapshot lastNameStudentQuery = await queryL
            .where("accountType", isEqualTo: "student")
            // .where('lastName', isGreaterThanOrEqualTo: searchText)
            // .where('lastName', isLessThanOrEqualTo: "$searchText\uf7ff")
            .where('lastNameSmall', isGreaterThanOrEqualTo: searchTextLower)
            .where('lastNameSmall',
                isLessThanOrEqualTo: "$searchTextLower\uf7ff")
            .get();
        QuerySnapshot firstNameTeacherQuery = await queryF
            .where("accountType", isEqualTo: "teacher")
            // .where('firstName', isGreaterThanOrEqualTo: searchText)
            // .where('firstName', isLessThanOrEqualTo: "$searchText\uf7ff")
            .where('firstNameSmall', isGreaterThanOrEqualTo: searchTextLower)
            .where('firstNameSmall',
                isLessThanOrEqualTo: "$searchTextLower\uf7ff")
            // .orderBy("firstName")
            // .orderBy("status")
            .get();

        QuerySnapshot lastNameTeacherQuery = await queryL
            .where("accountType", isEqualTo: "teacher")
            // .where('lastName', isGreaterThanOrEqualTo: searchText)
            // .where('lastName', isLessThanOrEqualTo: "$searchText\uf7ff")
            .where('lastNameSmall', isGreaterThanOrEqualTo: searchTextLower)
            .where('lastNameSmall',
                isLessThanOrEqualTo: "$searchTextLower\uf7ff")
            .get();
        // QuerySnapshot firstNameCharityQuery = await queryF
        //     .where("accountType", isEqualTo: "charity")
        //     .where('firstName', isGreaterThanOrEqualTo: searchText)
        //     .where('firstName', isLessThanOrEqualTo: "$searchText\uf7ff")
        //     // .orderBy("firstName")
        //     // .orderBy("status")
        //     .get();

        QuerySnapshot organizaitonNameCharity = await queryOrg
            .where("accountType", isEqualTo: "charity")
            // .where('organizationName', isGreaterThanOrEqualTo: searchText)
            // .where('organizationName', isLessThanOrEqualTo: "$searchText\uf7ff")
            .where('organizationNameSmall',
                isGreaterThanOrEqualTo: searchTextLower)
            .where('organizationNameSmall',
                isLessThanOrEqualTo: "$searchTextLower\uf7ff")
            .get();
        // Combine the results
        combinedResults.addAll(firstNameStudentQuery.docs);
        combinedResults.addAll(lastNameStudentQuery.docs);
        combinedResults.addAll(firstNameTeacherQuery.docs);
        combinedResults.addAll(lastNameTeacherQuery.docs);
        combinedResults.addAll(organizaitonNameCharity.docs);
      }

      print('.........................................');

      // Update recent searches in the background without waiting for it
      updateRecentSearches(searchText);
      print("searched count  ;: ----------${combinedResults.length}");

      return combinedResults;
    } catch (e) {
      print("error ----------------${e.toString()}");
      return [];
    }
  }

  Future<void> updateRecentSearches(String searchQuery) async {
    int maxSearches = 5;

    if (currentUser != null) {
      final CollectionReference recentSearchesCollection =
          FirebaseFirestore.instance.collection('recentSearches');

      // Get the current recent searches
      List<String> currentSearches = await getRecentSearches();

      // Add the new search query
      currentSearches.add(searchQuery);

      // Trim the list to the maximum allowed searches
      if (currentSearches.length > maxSearches) {
        // Replace the first stored element with the new one
        currentSearches = currentSearches.sublist(1, maxSearches + 1);
      }

      // Update the recent searches
      await recentSearchesCollection.doc(currentUser?.uid).set({
        'searches': currentSearches,
      });
    }
  }

  updateFollowers({required userId, required bool follow}) async {
    final CollectionReference followingDoc =
        FirebaseFirestore.instance.collection('following');
    // Get the current recent searches
    List<String> currentFollowers = await getFollowers();
    print('currentFollowers $currentFollowers  ${currentUser!.uid}');
    if (follow) {
      if (currentFollowers.length == 0 ||
          !currentFollowers.contains(currentUser?.uid)) {
        currentFollowers.add(currentUser!.uid);
      }
    } else {
      currentFollowers.length > 0
          ? currentFollowers.remove(currentUser?.uid)
          : null;
    }
    // Update the followers

    await followingDoc.doc(userId).set({
      'followers': currentFollowers,
    });
  }

  Future<List<String>> getFollowing() async {
    try {
      final DocumentSnapshot followingDoc = await FirebaseFirestore.instance
          .collection('following')
          .doc(currentUser?.uid)
          .get();

      if (followingDoc.exists) {
        final dynamic followings = followingDoc['followings'];

        if (followings != null && followings is List<dynamic>) {
          return followings.cast<String>().toList();
        } else {
          // 'followings' is either null or not a List, handle accordingly
          return [];
        }
      } else {
        // Document does not exist
        return [];
      }
    } catch (e) {
      // Handle exceptions
      print('Error fetching followings: $e');
      return [];
    }
  }

  Future<List<String>> getFollowers() async {
    try {
      final DocumentSnapshot followingDoc = await FirebaseFirestore.instance
          .collection('following')
          .doc(currentUser?.uid)
          .get();

      if (followingDoc.exists) {
        final dynamic followers = followingDoc['followers'];

        if (followers != null && followers is List<dynamic>) {
          return followers.cast<String>().toList();
        } else {
          // 'followers' is either null or not a List, handle accordingly
          return [];
        }
      } else {
        // Document does not exist
        return [];
      }
    } catch (e) {
      // Handle exceptions
      print('Error fetching followers: $e');
      return [];
    }
  }

  Future<void> updateFollow(bool follow, userId) async {
    final CollectionReference recentSearchesCollection =
        FirebaseFirestore.instance.collection('following');

    // Get the current recent searches
    List<String> currentFollowings = await getFollowing();

    if (follow) {
      if (currentFollowings.length == 0 ||
          !currentFollowings.contains(userId)) {
        currentFollowings.add(userId);
      }
    } else {
      currentFollowings.length > 0 ? currentFollowings.remove(userId) : null;
    }

    // Update the recent searches
    await recentSearchesCollection.doc(currentUser?.uid).set({
      'followings': currentFollowings,
    });

    await updateFollowers(userId: userId, follow: follow);
  }

  Future<List<String>> getRecentSearches() async {
    final DocumentSnapshot recentSearchesDoc = await FirebaseFirestore.instance
        .collection('recentSearches')
        .doc(currentUser?.uid)
        .get();

    if (recentSearchesDoc.exists) {
      final List<dynamic> searches = recentSearchesDoc['searches'];
      List<String> reversedSearches =
          searches.cast<String>().toList().reversed.toList();
      return reversedSearches;
    } else {
      return [];
    }
  }

  getNotifications(String receiverId) async {
    final DocumentSnapshot recentSearchesDoc = await FirebaseFirestore.instance
        .collection('notifications')
        .doc(receiverId)
        .get();

    if (recentSearchesDoc.exists) {
      return recentSearchesDoc['myNotifications'];
    } else {
      return [];
    }
  }

  Future<QuerySnapshot> getUSerByAccountType(
      {required String? accountType}) async {
    final CollectionReference userCollection =
        FirebaseFirestore.instance.collection('userAccounts');

    userCollection
        .where('accountType', isEqualTo: accountType)
        .get()
        .then((value) {});
    return userCollection.where('accountType', isEqualTo: accountType).get();
  }

  void searchUserWithAccountType(
    String? searchText,
    String? accountType,
  ) async {
    final CollectionReference userCollection =
        FirebaseFirestore.instance.collection('userAccounts');
  }

  Stream<List<T>> collectionStream<T>({
    required String path,
    required T builder(Map<String, dynamic> data, String documentID),
    Query queryBuilder(Query query)?,
    int sort(T lhs, T rhs)?,
  }) {
    Query query = FirebaseFirestore.instance.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    final Stream<QuerySnapshot> snapshots = query.snapshots();
    return snapshots.map((snapshot) {
      final result = snapshot.docs
          .map((snapshot) =>
              builder(snapshot.data() as Map<String, dynamic>, snapshot.id))
          .where((value) => value != null)
          .toList();
      if (sort != null) {
        result.sort(sort);
      }
      return result;
    });
  }

  Stream<T> documentStream<T>({
    required String path,
    required T builder(Map<String, dynamic> data, String documentID),
  }) {
    final DocumentReference reference = FirebaseFirestore.instance.doc(path);
    final Stream<DocumentSnapshot> snapshots = reference.snapshots();
    return snapshots.map((snapshot) =>
        builder(snapshot.data() as Map<String, dynamic>, snapshot.id));
  }

  Future<String> getCurrentUserId() async {
    if (currentUser != null) {
      String userId = currentUser!.uid;
      print('Current User ID: $userId');
      return userId;
    } else {
      return '123';
    }
  }

  Future<QuerySnapshot> getNestedDocumentsByCollection(
      {required parentCollection,
      required documentName,
      required childCollectionName}) {
    return FirebaseFirestore.instance
        .collection(parentCollection)
        .doc(documentName)
        .collection(childCollectionName)
        .get();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getDocumentbyId(
      String collectionPath, String id) {
    return FirebaseFirestore.instance.collection(collectionPath).doc(id).get();
  }
}
