import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/pengembalian_controller.dart';

class PengembalianView extends GetView<PengembalianController> {
  const PengembalianView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PengembalianView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PengembalianView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
