import 'package:fl_database_operations/core/helpers/db_helpers.dart';
import 'package:fl_database_operations/features/user_list/model/user_model.dart';

abstract class IUserListService {
  final DBHelpers dbHelpers;

  IUserListService({required this.dbHelpers});

  Future<List<UserModel>> fetchUsers();

  Future<int> insertUser(UserModel userModel);

  Future<bool> updateUser(UserModel userModel);

  Future<void> deleteUser(int id);
}
