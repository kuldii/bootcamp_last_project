import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/ongkir_controller.dart';

class OngkirView extends GetView<OngkirController> {
  Map<String, dynamic> data = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ongkos Kirim'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          '$data',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
