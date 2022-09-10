import 'package:q8intouch_task/data/api/mapper.dart';

import '../basic_models/user_model.dart';

// here we inherit from mapper single mapper properties to let mapper handel response
class UsersModel extends SingleMapper {
  List<Users>? users;
  int? total;
  int? skip;
  int? limit;
  UsersModel({
    this.users,
    this.total,
    this.skip,
    this.limit,
  });

  @override
  Mapper fromJson(Map<String, dynamic> json) {
    return UsersModel(
      users: json['users'] == null
          ? null
          : List<Users>.from(json['users'].map((e) => Users.fromJson(e))),
      total: json['total'],
      skip: json['skip'],
      limit: json['limit'],
    );
  }
}
