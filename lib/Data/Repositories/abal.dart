import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finote_birhan_mobile/Data/Services/firebase_service.dart';

class AbalRepository {
  final FirestoreService abalService;

  AbalRepository({required this.abalService});
  Future<QuerySnapshot> getKifiles() =>
      abalService.getDocumentsByCollection(collectionName: 'yeabale kifile');
  Future<QuerySnapshot> getNestedKifiles(documentName, childCollectionNAme) =>
      abalService.getNestedDocumentsByCollection(
          parentCollection: 'yeabale kifile',
          documentName: documentName,
          childCollectionName: childCollectionNAme);
  Future<QuerySnapshot> getAbals() =>
      abalService.getDocumentsByCollection(collectionName: 'abals');
}
