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
        "price": faker.commerce.price(symbol: "Rp ", decimals: 2, min: 10000, max: 5000000),
      },
    );
    super.onInit();
  }
}
