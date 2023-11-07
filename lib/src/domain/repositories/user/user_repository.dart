// ignore_for_file: avoid_print

import 'dart:developer' as developer;
import 'dart:developer';

import 'package:get/get.dart';
import 'package:getx_connect_example/src/domain/entities/user/user_entity.dart';

class UserRepository {
  //final restClient = GetConnect();
  final restClient = GetConnect(
    timeout: const Duration(milliseconds: 600), // o valor padrão é 5 segundos
  );

  UserRepository() {
    restClient.httpClient.baseUrl = 'http://10.0.0.112:8080';

    // restClient.httpClient.maxAuthRetries = 3;

    restClient.httpClient.addAuthenticator<Object?>((request) async {
      final response = await restClient.post('/auth', {
        'email': 'test1@test.com',
        'password': '123123',
      });

      if (!response.hasError) {
        final accessToken = response.body['access_token'];
        final type = response.body['type'];

        if (accessToken != null) {
          request.headers['authorization'] = '$type $accessToken';
        }
      }

      return request;
    });

    restClient.httpClient.addRequestModifier<Object?>((request) {
      // developer.log('hhhhhhhh');

      request.headers['start-time'] = DateTime.now().toString();
      return request;
    });

    restClient.httpClient.addResponseModifier<Object?>((request, response) {
      response.headers?['end-time'] = DateTime.now().toString();
      return response;
    });
  }

  Future<List<UserEntity>> findAll() async {
    final response = await restClient.get('/users');

    if (response.hasError) {
      throw Exception('Erro ao Carregar os Usuários (${response.statusText})');
    }
    log(response.request?.headers['start-time'] ?? '');
    log(response.headers?['end-time'] ?? '');

    final List<dynamic> data = response.body;

    final List<UserEntity> users =
        data.map<UserEntity>((user) => UserEntity.fromMap(user)).toList();

    return users;
  }

  Future<void> insertUser(UserEntity user) async {
    final response = await restClient.post('/users', user.toMap());

    if (response.hasError) {
      throw Exception('Erro ao inserir usuário (${response.statusText})');
    }
  }

  Future<void> updateUser(UserEntity user) async {
    final response = await restClient.put('/users/${user.id}', user.toMap());

    if (response.hasError) {
      throw Exception('Erro ao update usuário (${response.statusText})');
    }
  }

  Future<void> deleteUser(UserEntity user) async {
    final response = await restClient.delete('/users/${user.id}');

    if (response.hasError) {
      throw Exception('Erro ao deletar usuário (${response.statusText})');
    }
  }
}
