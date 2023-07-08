import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

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
        querySnapshot.docs.forEach((doc) {
          kifiles.add(doc);
        });
      });
      return kifiles;
    }catch(e){

      emit(state.copyWith(
          updatedAbalRegistrationStatus: AbalRegistrationStatus.error, errorMessage: e.toString()));
      throw Exception(e.toString());
    }
    }
}