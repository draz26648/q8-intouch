import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';
import 'package:q8intouch_task/data/api/mapper.dart';
import 'package:q8intouch_task/data/models/basic_models/user_model.dart';
import 'package:q8intouch_task/data/models/mapper_models/users_model.dart';
import 'package:q8intouch_task/data/repositories/users_repo.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit() : super(UsersInitial());

//main users list
  List<Users> users = [];
  //users list in top screen
  List<Users> savedUsers = [];
  // skipped users count it's allows pagination in api
  int skippedUsers = 0;
// There is next page or not
  bool hasNextPage = true;
// Used to display loading indicators when getUsers method is running
  bool isFirstLoadRunning = false;
// Used to display loading indicators when loadMore method is running
  bool isLoadMoreRunning = false;
  // used to control page count
  int page = 0;

  late ScrollController controller;

//future method to call users repository method in it and pass data to model and then ui and
  Future<void> getUsers() async {
    emit(UsersLoading());
    isFirstLoadRunning = true;
    try {
      UsersModel _res = await UsersRepo.getUsers(skippedUsers: skippedUsers);
      if (_res.users!.isNotEmpty) {
        emit(UsersLoaded(_res));
      }
    } catch (error) {
      print('error : ${error.toString()}');
      emit(UsersError());
    }
    isFirstLoadRunning = false;
    emit(UsersActionSuccess());
  }

// this method totally control pagination request
  Future<void> getNextUsers() async {
    if (hasNextPage &&
        !isFirstLoadRunning &&
        !isLoadMoreRunning &&
        controller.position.extentAfter < 100) {
      emit(UsersLoading());
      updateSkippedUsers(skippedUsersCount: 10);
      isLoadMoreRunning = true;
      page += 1;
      try {
        UsersModel _res = await UsersRepo.getUsers(skippedUsers: skippedUsers);
        if (_res.users!.isNotEmpty) {
          emit(UsersLoaded(_res));
        } else {
          hasNextPage = false;
          emit(UsersEmpty());
        }
      } catch (error) {
        print('error : ${error.toString()}');
        emit(UsersError());
      }
      isLoadMoreRunning = false;
      emit(UsersActionSuccess());
    }
  }

// toggle method to toggle between remove and add button
  void toggleAddButton(int index) {
    if (savedUsers.length < 10) {
      if (!users[index].isAdded) {
        if (savedUsers.contains(users[index])) {
          Fluttertoast.showToast(msg: 'user already saved');
        } else {
          users[index].isAdded = true;
          savedUsers.add(users[index]);
        }
      } else {
        users[index].isAdded = false;
        savedUsers.remove(users[index]);
      }
    } else {
      Fluttertoast.showToast(
          msg: 'sorry you can not add more users maximum is 10');
    }
    emit(UsersToggleButtonSuccess());
  }

  void removeSavedItem(int index) {
    users.firstWhere((element) => element.id == savedUsers[index].id).isAdded =
        false;
    savedUsers.remove(savedUsers[index]);
    emit(UsersRemoveSuccess());
  }

// used to update limit count in api request
  void updateSkippedUsers({
    required int skippedUsersCount,
  }) {
    if (skippedUsers == 0) {
      skippedUsers = skippedUsersCount;
      emit(UsersSkippedCountSuccess());
    } else {
      skippedUsers += skippedUsersCount;
      emit(UsersSkippedCountSuccess());
    }
  }

  Future<void> search(String value) async {
    emit(UsersLoading());
    try {
      UsersModel _res = await UsersRepo.getSearchResult(search: value);
      if (_res.users!.isNotEmpty) {
        emit(UsersLoaded(_res));
      } else {
        Fluttertoast.showToast(msg: 'There is no items');
      }
    } catch (error) {
      print('error : ${error.toString()}');
      emit(UsersError());
    }
  }
}
