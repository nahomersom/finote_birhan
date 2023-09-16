import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


import '../../../../Data/Repositories/abal.dart';

part 'abals_state.dart';

class AbalsListCubit extends Cubit<AbalListState> {
  final AbalRepository abalRepository;

  AbalsListCubit({required this.abalRepository})
      : super(const AbalListState(errorMessage: ''));
  Future<List> getAbals() async {
    print('a======================abal called');
    emit(state.copyWith(
        abalListStatus: AbalListStatus.initial,
        errorMessage: ''));

    List<dynamic> abals = [];
    try {
      emit(state.copyWith(
          abalListStatus: AbalListStatus.loading,
          errorMessage: ''));
      await abalRepository.getAbals().then((QuerySnapshot querySnapshot) {

        for (var doc in querySnapshot.docs) {
          print( doc.data());

          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          data['id'] = doc.reference.id;

          abals.add(data);
        }
      });
      emit(state.copyWith(
          abals: abals,
          abalListStatus: AbalListStatus.success,
          errorMessage: ''));
      return abals;
    } catch (e) {
      emit(state.copyWith(
          abalListStatus: AbalListStatus.error,
          errorMessage: e.toString()));
      throw Exception(e.toString());
    }
  }
}
