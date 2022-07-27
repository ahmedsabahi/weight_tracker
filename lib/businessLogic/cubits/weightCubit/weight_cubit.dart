import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'weight_state.dart';

class WeightCubit extends Cubit<WeightState> {
  WeightCubit() : super(WeightInitial());

  static WeightCubit get(BuildContext context) =>
      BlocProvider.of<WeightCubit>(context);

  final users = FirebaseFirestore.instance.collection('users');

  Future<void> addWeight(String userID, String weight) async {
    emit(AddWeightLoading());
    try {
      await users.doc(userID).update({
        'weights': FieldValue.arrayUnion([
          {
            'weight': weight,
            'time': DateTime.now(),
          }
        ]),
      });
      emit(AddWeightLoaded());
    } catch (e) {
      emit(AddWeightError(e.toString()));
    }
  }

  Future<void> removeWeight(
      String userID, Map<String, dynamic> weightObj) async {
    emit(RemoveWeightLoading());
    try {
      await users.doc(userID).update({
        'weights': FieldValue.arrayRemove([weightObj]),
      });
      emit(RemoveWeightLoaded());
    } catch (e) {
      emit(RemoveWeightError(e.toString()));
    }
  }
}
