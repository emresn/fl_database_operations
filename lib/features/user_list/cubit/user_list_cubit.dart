import 'package:fl_database_operations/features/user_list/model/user_model.dart';
import 'package:fl_database_operations/features/user_list/service/user_list_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserListCubit extends Cubit<UserListState> {
  final UserListService service;
  UserListCubit({required this.service}) : super(InitialUserListState());

  List<UserModel> userList = [];

  void addWordToDb(UserModel userModel) async {
    try {
      int responseId = await service.insertUser(userModel);
      userList.add(
          UserModel(age: userModel.age, id: responseId, name: userModel.name));

      emit(SuccessUserListState());
    } catch (e) {
      emit(ErrorUserListState(message: e.toString()));
    }
  }

  void fetchUsersFromDb() async {
    try {
      userList = await service.fetchUsers();

      emit(SuccessUserListState(message: "Successfully fetched"));
    } catch (e) {
      emit(ErrorUserListState(message: e.toString()));
    }
  }

  void deleteUserFromDb(int id) async {
    try {
      if (userList.isNotEmpty) {
        await service.deleteUser(id);
        userList.removeWhere((element) => element.id == id);

        emit(SuccessUserListState(message: "Successfully deleted"));
      }
    } catch (e) {
      emit(ErrorUserListState(message: e.toString()));
    }
  }
}

abstract class UserListState {}

class InitialUserListState extends UserListState {}

class LoadingUserListState extends UserListState {}

class UpdatedUserListState extends UserListState {}

class SuccessUserListState extends UserListState {
  String message;
  SuccessUserListState({this.message = "Successfully updated"});
}

class ErrorUserListState extends UserListState {
  String message;
  ErrorUserListState({this.message = "Error"});
}
