import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial());

  static SignInCubit get(BuildContext context) =>
      BlocProvider.of<SignInCubit>(context);

  final users = FirebaseFirestore.instance.collection('users');

  User? get user => _user;
  User? _user;

  Future<void> signInAnonymous() async {
    emit(SignInAnonymousLoading());
    try {
      final userCredential = await FirebaseAuth.instance.signInAnonymously();
      _user = userCredential.user;
      await users.doc(_user!.uid).set({'weights': []});
      emit(SignInAnonymousLoaded());
    } catch (e) {
      emit(SignInAnonymousError(e.toString()));
    }
  }

  Future<void> signOut() async {
    emit(SignOutAnonymousLoading());
    try {
      await FirebaseAuth.instance.signOut();
      emit(SignOutAnonymousLoaded());
    } catch (e) {
      emit(SignOutAnonymousError(e.toString()));
    }
  }
}
