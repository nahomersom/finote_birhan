import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Data/Repositories/abal.dart';
part 'abal_registration_state.dart';

class AbalCubit extends Cubit<AbalRegistrationState> {
  final AbalRepository abalRepository;

  AbalCubit({required this.abalRepository})
      : super(const AbalRegistrationState(errorMessage: ''));

  Future<List> getKifiles() async {

    emit(state.copyWith(updatedAbalRegistrationStatus: AbalRegistrationStatus.initial, errorMessage:''));

    List<dynamic> kifiles = [];
    try{
      emit(state.copyWith(updatedAbalRegistrationStatus: AbalRegistrationStatus.loading, errorMessage: ''));
      await abalRepository.getKifiles().then((QuerySnapshot querySnapshot) {


        for (var doc in querySnapshot.docs) {

        Map<String,dynamic> data = doc.data() as Map<String,dynamic>;
        data['id'] = doc.reference.id;


          kifiles.add(data);
        }
      });
      emit(state.copyWith(
          kifiles: kifiles,
          updatedAbalRegistrationStatus: AbalRegistrationStatus.success, errorMessage: ''));

       kifiles.sort((a, b) => a['step'].compareTo(b['step']));
      return kifiles;
    }catch(e){

      emit(state.copyWith(
          updatedAbalRegistrationStatus: AbalRegistrationStatus.error, errorMessage: e.toString()));
      throw Exception(e.toString());
    }
    }

  Future<List> getNestedKifiles(documentId,childCollectionName) async {

    emit(state.copyWith(updatedAbalRegistrationStatus: AbalRegistrationStatus.initial, errorMessage:''));

    List<dynamic> nestedKifiles = [];
    try{
      emit(state.copyWith(updatedAbalRegistrationStatus: AbalRegistrationStatus.loading, errorMessage: ''));
      await abalRepository.getNestedKifiles(documentId, childCollectionName).then((QuerySnapshot querySnapshot) {


        for (var doc in querySnapshot.docs) {


          Map<String,dynamic> data = doc.data() as Map<String,dynamic>;
          data['id'] = doc.reference.id;


          nestedKifiles.add(data);
        }
      });
      emit(state.copyWith(
          nestedKifiles: nestedKifiles,
          updatedAbalRegistrationStatus: AbalRegistrationStatus.success, errorMessage: ''));

      nestedKifiles.sort((a, b) => a['step'].compareTo(b['step']));
      print('=======================================================');
      print(nestedKifiles);
      print('=======================================================');

      return nestedKifiles;
    }catch(e){

      emit(state.copyWith(
          updatedAbalRegistrationStatus: AbalRegistrationStatus.error, errorMessage: e.toString()));
      throw Exception(e.toString());
    }
  }
}