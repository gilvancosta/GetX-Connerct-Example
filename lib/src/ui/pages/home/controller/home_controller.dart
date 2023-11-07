// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:flutter/material.dart';
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
    final user = UserEntity(

      name: 'João Batista',
      email: 'test@test.com',
      password: '123456',
    );

    await _userRepository.insertUser(user);

    findAll();

  }
  void updateUser(UserEntity user) {}
  void deleteUser(UserEntity user) {}
}
