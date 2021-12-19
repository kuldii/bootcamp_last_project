import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:project_akhir/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeView'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Get.offAllNamed(Routes.LOGIN),
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: controller.products.length,
        itemBuilder: (context, index) => ListTile(
          onTap: () => Get.toNamed(
            Routes.EKSPEDISI,
            arguments: controller.products[index],
          ),
          leading: CircleAvatar(
            child: Text("${controller.products[index]["id"]}"),
          ),
          title: Text("${controller.products[index]["name"].toString().capitalizeFirst}"),
          subtitle: Text("${controller.products[index]["price"]}"),
        ),
      ),
    );
  }
}
