import 'dart:math';

import 'package:fl_database_operations/core/components/ui_elevated_button.dart';
import 'package:fl_database_operations/core/helpers/db_helpers.dart';
import 'package:fl_database_operations/features/user_list/cubit/user_list_cubit.dart';
import 'package:fl_database_operations/features/user_list/model/user_model.dart';
import 'package:fl_database_operations/features/user_list/service/user_list_service.dart';
import 'package:fl_database_operations/features/user_list/test_data/test_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserListView extends StatelessWidget {
  const UserListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          UserListCubit(service: UserListService(dbHelpers: DBHelpers())),
      child: BlocBuilder<UserListCubit, UserListState>(
        builder: (context, state) {
          List<UserModel> userList =
              BlocProvider.of<UserListCubit>(context).userList;

          return Scaffold(
            appBar: AppBar(
              title: const Text("Database Operations"),
            ),
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.indigo.shade100,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (userList.isEmpty)
                      const Center(child: Text("User list is emty")),
                    buildUserList(userList),
                    buildButtons(context, userList),
                    if (state is ErrorUserListState)
                      buildMessage(state.message),
                    if (state is SuccessUserListState)
                      buildMessage(state.message),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Expanded buildUserList(List<UserModel> userList) {
    return Expanded(
      flex: 4,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Wrap(
          children: [
            for (var i = 0; i < userList.length; i++)
              buildListTile(userList, i),
          ],
        ),
      ),
    );
  }

  Widget buildMessage(String message) {
    return Text(message);
  }

  ListTile buildListTile(List<UserModel> userList, int index) {
    return ListTile(
      title: Text(
        "${userList[index].name}, ${userList[index].age}",
      ),
    );
  }

  Expanded buildButtons(BuildContext context, List<UserModel> userList) {
    List<Map<String, dynamic>> testRows = TestData().testRows;
    int randomInt = Random().nextInt(testRows.length);

    return Expanded(
      flex: 2,
      child: Column(
        children: [
          UiElevatedButton(
            icodata: Icons.get_app,
            label: "Fetch Db",
            type: "success",
            onPressed: () {
              BlocProvider.of<UserListCubit>(context).fetchUsersFromDb();
            },
          ),
          UiElevatedButton(
            icodata: Icons.add,
            label: "Add to db",
            type: "success",
            onPressed: () {
              BlocProvider.of<UserListCubit>(context)
                  .addWordToDb(UserModel.fromJson(testRows[randomInt]));
            },
          ),
          UiElevatedButton(
            icodata: Icons.remove,
            type: "danger",
            label: "Remove fb",
            onPressed: () {
              if (userList.isNotEmpty) {
                BlocProvider.of<UserListCubit>(context)
                    .deleteUserFromDb(userList.last.id!);
              }
            },
          )
        ],
      ),
    );
  }
}
