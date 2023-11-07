import 'package:get/get.dart';
import 'package:getx_connect_example/src/domain/entities/user/user_entity.dart';

class UserRepository {
  final restClient = GetConnect();

  Future<List<UserEntity>> findAll() async {
    final response =
        await restClient.get('http://http://10.0.0.112:8080/users');

    if (response.hasError) {
      throw Exception('Erro ao Carregar os Usuários (${response.statusText})');
    }

    return response.body
        .map<UserEntity>((user) => UserEntity.fromMap(user))
        .toList();
  }

  Future<void> insertUser(UserEntity user) async {
    final response = await restClient.post(
        'http://http://10.0.0.112:8080/users', user.toMap());

    if (response.hasError) {
      throw Exception('Erro ao inserir usuário (${response.statusText})');
    }
  }

  Future<void> updateUser(UserEntity user) async {
    final response = await restClient.put(
        'http://http://10.0.0.112:8080/users/${user.id}', user.toMap());

    if (response.hasError) {
      throw Exception('Erro ao update usuário (${response.statusText})');
    }
  }

  Future<void> deleteUser(UserEntity user) async {
    final response = await restClient
        .delete('http://http://10.0.0.112:8080/users/${user.id}');

    if (response.hasError) {
      throw Exception('Erro ao deletar usuário (${response.statusText})');
    }
  }
}
