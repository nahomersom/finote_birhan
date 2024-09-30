import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finote_birhan_mobile/Data/Models/abal.dart';
import '../../../../Data/Repositories/abal.dart';
import '../../../Algorithm/file-uploader.dart';
part 'abal_registration_state.dart';

class AbalCubit extends Cubit<AbalRegistrationState> {
  final AbalRepository abalRepository;

  AbalCubit({required this.abalRepository})
      : super(const AbalRegistrationState(errorMessage: ''));

  Future<List> getKifiles() async {
    emit(state.copyWith(
        updatedAbalRegistrationStatus: AbalRegistrationStatus.initial,
        errorMessage: ''));

    List<dynamic> kifiles = [];
    try {
      emit(state.copyWith(
          updatedAbalRegistrationStatus: AbalRegistrationStatus.loading,
          errorMessage: ''));
      print('1111111111111111****************kifiles');

      await abalRepository.getKifiles().then((QuerySnapshot querySnapshot) {
        print('****************kifiles $querySnapshot');
        for (var doc in querySnapshot.docs) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          data['id'] = doc.reference.id;

          kifiles.add(data);
        }
      });
      emit(state.copyWith(
          kifiles: kifiles,
          updatedAbalRegistrationStatus: AbalRegistrationStatus.success,
          errorMessage: ''));

      kifiles.sort((a, b) => a['step'].compareTo(b['step']));
      return kifiles;
    } catch (e) {
      emit(state.copyWith(
          updatedAbalRegistrationStatus: AbalRegistrationStatus.error,
          errorMessage: e.toString()));
      throw Exception(e.toString());
    }
  }

  Future<List> getNestedKifiles(documentId, childCollectionName) async {
    emit(state.copyWith(
        updatedAbalRegistrationStatus: AbalRegistrationStatus.initial,
        errorMessage: ''));

    List<dynamic> nestedKifiles = [];
    try {
      emit(state.copyWith(
          updatedAbalRegistrationStatus: AbalRegistrationStatus.loading,
          errorMessage: ''));
      await abalRepository
          .getNestedKifiles(documentId, childCollectionName)
          .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          data['id'] = doc.reference.id;

          nestedKifiles.add(data);
        }
      });
      emit(state.copyWith(
          nestedKifiles: nestedKifiles,
          updatedAbalRegistrationStatus: AbalRegistrationStatus.success,
          errorMessage: ''));

      nestedKifiles.sort((a, b) => a['step'].compareTo(b['step']));
      return nestedKifiles;
    } catch (e) {
      emit(state.copyWith(
          updatedAbalRegistrationStatus: AbalRegistrationStatus.error,
          errorMessage: e.toString()));
      throw Exception(e.toString());
    }
  }

  void registerAbal(
      AbalRegistrationModel abal, File? welageImage, File? abalImage) async {
    final FileUploader fileUploader = FileUploader();
    emit(state.copyWith(
        updatedAbalRegistrationStatus: AbalRegistrationStatus.isRegistering,
        errorMessage: ''));
    print('--------------------------------first');
    CollectionReference abals = FirebaseFirestore.instance.collection('abals');
    // print('--------------------------------second');
    //
    // String abalImagePath = await fileUploader.uploadFile('ህጻናት/አባል', abalImage);
    //
    // String welageImagePath =
    //     await fileUploader.uploadFile('ህጻናት/ወላጅ', welageImage);
    //
    // abal.abal.imagePath = abalImagePath;
    // abal.familyInfo.imagePath = welageImagePath;
    print('===========================================================');
    print(jsonEncode(abal));
    emit(state.copyWith(
        updatedAbalRegistrationStatus: AbalRegistrationStatus.registered,
        errorMessage: ''));
    abals
        .add(abal.toJson())
        .then((res) => {
              print(
                  'firebase response:==================================================='),
              print(res),
              emit(state.copyWith(
                  updatedAbalRegistrationStatus:
                      AbalRegistrationStatus.registered,
                  errorMessage: ''))
            })
        .catchError((err) => {
              emit(state.copyWith(
                  updatedAbalRegistrationStatus: AbalRegistrationStatus.error,
                  errorMessage: err.toString()))
            });
  }
}
