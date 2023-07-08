import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hisnate_kifele/Data/Services/firebase_service.dart';

class AbalRepository{
  final FirestoreService abalService;

  AbalRepository({required this.abalService});
  Future<QuerySnapshot> getKifiles() => abalService.getDocumentsByCollection(collectionName: 'kifiles');


}