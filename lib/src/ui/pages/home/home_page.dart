import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home page'),
      ),
      body: controller.obx(
        (state) {
          if (state == null) {
            return const Center(
              child: Text('Nenhum usuário encontrado'),
            );
          }
          return ListView.builder(
            itemCount: state.length,
            itemBuilder: (context, index) {
              final user = state[index];
              return ListTile(
                title: Text('${user.id} - ${user.name}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                subtitle: Text(user.email),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => controller.deleteUser(user),
                ),
              );
            },
          );
        },
        onEmpty: const Center(
          child: Text('Nenhum usuário encontrado'),
        ),
        onError: (error) => const Center(
          child: Text('Erro ao buscar usuários333'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.insertUser,
        child: const Icon(Icons.add),
      ),
    );
  }
}
