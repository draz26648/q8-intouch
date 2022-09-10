part of 'users_cubit.dart';

@immutable
abstract class UsersState {}

class UsersInitial extends UsersState {}

class UsersLoading extends UsersState {}

class UsersLoaded extends UsersState {
  final Mapper model;
  UsersLoaded(this.model);
}

class UsersError extends UsersState {}

class UsersToggleButtonSuccess extends UsersState {}
