import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/koleksi_controller.dart';

class KoleksiView extends GetView<KoleksiController> {
  const KoleksiView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KoleksiView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'KoleksiView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
