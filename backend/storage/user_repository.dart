// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps

import 'package:get/get.dart';
import 'package:getx_connect_example/src/domain/entities/user/user_entity.dart';

class UserRepository {
  final restClient = GetConnect();

  Future<List<UserEntity>> findAll() async {
    final response = await restClient.get('http://10.0.0.112:8080/users');

    if (response.status.hasError) {
      throw Exception('Erro ao Carregar os Usuários (${response.statusText})');
    }

    print('response.body 111: ${response.body}');

    final List<dynamic> data = response.body;

    print('data 222: ${data}');

    final List<UserEntity> users =
        data.map((item) => UserEntity.fromJson(item)).toList();
    print('users 333: ${users}');

    return users;
  }

  Future<void> insertUser(UserEntity user) async {
    final response =
        await restClient.post('http://10.0.0.112:8080/users', user.toMap());

    if (response.hasError) {
      throw Exception('Erro ao inserir usuário (${response.statusText})');
    }
  }

  Future<void> updateUser(UserEntity user) async {
    final response = await restClient.put(
        'http://10.0.0.112:8080/users/${user.id}', user.toMap());

    if (response.hasError) {
      throw Exception('Erro ao update usuário (${response.statusText})');
    }
  }

  Future<void> deleteUser(UserEntity user) async {
    final response =
        await restClient.delete('http://10.0.0.112:8080/users/${user.id}');

    if (response.hasError) {
      throw Exception('Erro ao deletar usuário (${response.statusText})');
    }
  }
}
