import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finote_birhan_mobile/Data/Models/abal.dart';
import '../../../../Data/Repositories/abal.dart';
import '../../../Algorithm/file-uploader.dart';
part 'abal_state.dart';

class AbalCubit extends Cubit<AbalState> {
  final AbalRepository abalRepository;

  AbalCubit({required this.abalRepository})
      : super(const AbalState(errorMessage: ''));

  Future<List> getKifiles() async {
    emit(state.copyWith(abalStatus: AbalStatus.initial, errorMessage: ''));

    List<dynamic> kifiles = [];
    try {
      emit(state.copyWith(abalStatus: AbalStatus.loading, errorMessage: ''));
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
          kifiles: kifiles, abalStatus: AbalStatus.success, errorMessage: ''));

      kifiles.sort((a, b) => a['step'].compareTo(b['step']));
      return kifiles;
    } catch (e) {
      emit(state.copyWith(
          abalStatus: AbalStatus.error, errorMessage: e.toString()));
      throw Exception(e.toString());
    }
  }

  Future<List> getNestedKifiles(documentId, childCollectionName) async {
    emit(state.copyWith(abalStatus: AbalStatus.initial, errorMessage: ''));

    List<dynamic> nestedKifiles = [];
    try {
      emit(state.copyWith(abalStatus: AbalStatus.loading, errorMessage: ''));
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
          abalStatus: AbalStatus.success,
          errorMessage: ''));

      nestedKifiles.sort((a, b) => a['step'].compareTo(b['step']));
      return nestedKifiles;
    } catch (e) {
      emit(state.copyWith(
          abalStatus: AbalStatus.error, errorMessage: e.toString()));
      throw Exception(e.toString());
    }
  }

  void registerAbal(
      AbalRegistrationModel abal, File? welageImage, File? abalImage) async {
    final FileUploader fileUploader = FileUploader();
    emit(
        state.copyWith(abalStatus: AbalStatus.isRegistering, errorMessage: ''));
    print('--------------------------------first');
    CollectionReference abals = FirebaseFirestore.instance.collection('abals');
    print('===========================================================');
    print(jsonEncode(abal));
    emit(state.copyWith(abalStatus: AbalStatus.registered, errorMessage: ''));
    abals
        .add(abal.toJson())
        .then((res) => {
              print(
                  'firebase response:==================================================='),
              print(res),
              emit(state.copyWith(
                  abalStatus: AbalStatus.registered, errorMessage: ''))
            })
        .catchError((err) => {
              emit(state.copyWith(
                  abalStatus: AbalStatus.error, errorMessage: err.toString()))
            });
  }

  Future<List> getAbals() async {
    print('a======================abal called');
    emit(state.copyWith(abalStatus: AbalStatus.initial, errorMessage: ''));

    List<dynamic> abals = [];
    try {
      emit(state.copyWith(abalStatus: AbalStatus.loading, errorMessage: ''));
      await abalRepository.getAbals().then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          print(doc.data());

          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          data['id'] = doc.reference.id;

          abals.add(data);
        }
      });
      emit(state.copyWith(
          abals: abals, abalStatus: AbalStatus.success, errorMessage: ''));
      return abals;
    } catch (e) {
      emit(state.copyWith(
          abalStatus: AbalStatus.error, errorMessage: e.toString()));
      throw Exception(e.toString());
    }
  }
}
