// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:get/get.dart';

import 'package:getx_connect_example/src/domain/repositories/user/user_repository.dart';
import 'package:getx_connect_example/src/domain/entities/user/user_entity.dart';

class HomeController extends GetxController with StateMixin<List<UserEntity>> {
  final UserRepository _userRepository;
  HomeController({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  @override
  void onReady() {
    findAll();
    super.onReady();
  }

  Future<void> findAll() async {
    try {
      change([], status: RxStatus.loading());

      final users = await _userRepository.findAll();

      var statusReturn = RxStatus.success();

      if (users.isEmpty) {
        statusReturn = RxStatus.empty();
      }

      change(users, status: statusReturn);
    } catch (e, s) {
      log('Erro ao buscar usuários111', error: e, stackTrace: s);
      change(state, status: RxStatus.error());
    }
  }

  void insertUser() async {
    try {
      final user = UserEntity(
        name: 'João Batista',
        email: 'test@test.com',
        password: '123456',
      );

      await _userRepository.insertUser(user);

      findAll();
    } catch (e, s) {
      log('Erro ao Salvar Usuário', error: e, stackTrace: s);
      Get.snackbar('Erro', 'Erro ao Salvar Usuário');
    }
  }

  Future<void> updateUser(UserEntity user) async {
    try {
      user.name = 'João Araújo';
      user.email = 'test1@test.com';
      user.password = '123123';

      await _userRepository.updateUser(user);

      findAll();
    } catch (e, s) {
      log('Erro ao atualizar Usuário', error: e, stackTrace: s);
      Get.snackbar('Erro', 'Erro ao Atualizar Usuário');
    }
  }

  void deleteUser(UserEntity user) async {
    try {
      await _userRepository.deleteUser(user);
      findAll();
      Get.snackbar('Sucesso', 'Usuário Excluído com Sucesso');
    } catch (e, s) {
      log('Erro ao Excluir Usuário', error: e, stackTrace: s);
      Get.snackbar('Erro', 'Erro ao Excluir Usuário');
    }
  }
}
