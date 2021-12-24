import 'dart:math';

import 'package:faker_dart/faker_dart.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final faker = Faker.instance;
  late List products;

  @override
  void onInit() {
    products = List.generate(
      50,
      (index) => {
        "id": index + 1,
        "name": faker.commerce.productName(),
        "price": 10000 + Random().nextInt(1000000),
        "weight": 1 + Random().nextInt(25000),
      },
    );
    super.onInit();
  }
}
