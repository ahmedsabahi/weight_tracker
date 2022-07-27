part of 'weight_cubit.dart';

@immutable
abstract class WeightState {}

class WeightInitial extends WeightState {}

class AddWeightLoading extends WeightState {}

class AddWeightLoaded extends WeightState {}

class AddWeightError extends WeightState {
  final String error;
  AddWeightError(this.error);
}

class RemoveWeightLoading extends WeightState {}

class RemoveWeightLoaded extends WeightState {}

class RemoveWeightError extends WeightState {
  final String error;
  RemoveWeightError(this.error);
}
