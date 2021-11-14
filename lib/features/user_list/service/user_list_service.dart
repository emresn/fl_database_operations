import 'package:fl_database_operations/core/helpers/db_helpers.dart';
import 'package:fl_database_operations/features/user_list/model/user_model.dart';
import 'package:fl_database_operations/features/user_list/service/i_user_list_service.dart';

class UserListService extends IUserListService {
  UserListService({required DBHelpers dbHelpers}) : super(dbHelpers: dbHelpers);

  @override
  Future<List<UserModel>> fetchUsers() async {
    List<Map<String, dynamic>> queryList = await dbHelpers.queryAllRows();
    List<UserModel> userList = [];

    for (var row in queryList) {
      userList.add(UserModel.fromJson(row));
    }
    return userList;
  }

  @override
  Future<int> insertUser(UserModel userModel) async {
    int newId = await dbHelpers.insert(UserModel().toMap(userModel));
    return newId;
  }

  @override
  Future<bool> updateUser(UserModel userModel) async {
    Map<String, dynamic> row = UserModel().toMap(userModel);

    await dbHelpers.update(row);
    return true;
  }

  @override
  Future<void> deleteUser(int id) async {
    await dbHelpers.delete(id);
  }
}
