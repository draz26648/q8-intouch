import 'package:q8intouch_task/data/api/network.dart';
import 'package:q8intouch_task/data/models/mapper_models/users_model.dart';

abstract class UsersRepo {
  static Future<dynamic> getUsers({
    required int skippedUsers,
  }) async {
    Map<String, dynamic> _query = {
      'limit': 10,
      'skip': skippedUsers.toString(),
    };
    return await NetworkHelper()
        .get(url: 'users', model: UsersModel(), query: _query);
  }

  static Future<dynamic> getSearchResult({
    required String search,
  }) async {
    Map<String, dynamic> _query = {
      'q': search,
    };
    return await NetworkHelper()
        .get(url: 'users/search', model: UsersModel(), query: _query);
  }
}
