import 'package:bloc/bloc.dart';
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

  List<Users> users = [];
  List<Users> savedUsers = [];

//future method to call users repository method in it and pass data to model and then ui
  Future<void> getUsers() async {
    emit(UsersLoading());
    try {
      UsersModel _res = await UsersRepo.getUsers();
      if (_res.users!.isNotEmpty) {
        emit(UsersLoaded(_res));
      }
    } catch (error) {
      print('error : ${error.toString()}');
      emit(UsersError());
    }
  }

// toggle method to toggle between remove and add button
  void toggleAddButton(int index) {
    if (!users[index].isAdded) {
      users[index].isAdded = true;
      savedUsers.add(users[index]);
    } else {
      users[index].isAdded = false;
      savedUsers.remove(users[index]);
    }
    emit(UsersToggleButtonSuccess());
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
