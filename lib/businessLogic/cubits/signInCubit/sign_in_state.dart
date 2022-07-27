part of 'sign_in_cubit.dart';

@immutable
abstract class SignInState {}

class SignInInitial extends SignInState {}

class SignInAnonymousLoading extends SignInState {}

class SignInAnonymousLoaded extends SignInState {}

class SignInAnonymousError extends SignInState {
  final String error;
  SignInAnonymousError(this.error);
}

class SignOutAnonymousLoading extends SignInState {}

class SignOutAnonymousLoaded extends SignInState {}

class SignOutAnonymousError extends SignInState {
  final String error;
  SignOutAnonymousError(this.error);
}
