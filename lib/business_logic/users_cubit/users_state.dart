part of 'users_cubit.dart';

@immutable
abstract class UsersState {}

class UsersInitial extends UsersState {}

class UsersLoading extends UsersState {}

class UsersLoaded extends UsersState {
  final Mapper model;
  UsersLoaded(this.model);
}

class UsersEmpty extends UsersState {}

class UsersError extends UsersState {}

class UsersActionSuccess extends UsersState {}

class UsersToggleButtonSuccess extends UsersState {}

class UsersRemoveSuccess extends UsersState {}

class UsersSkippedCountSuccess extends UsersState {}
