import 'package:get/get.dart';

import 'package:project_akhir/app/modules/ekspedisi/bindings/ekspedisi_binding.dart';
import 'package:project_akhir/app/modules/ekspedisi/views/ekspedisi_view.dart';
import 'package:project_akhir/app/modules/home/bindings/home_binding.dart';
import 'package:project_akhir/app/modules/home/views/home_view.dart';
import 'package:project_akhir/app/modules/login/bindings/login_binding.dart';
import 'package:project_akhir/app/modules/login/views/login_view.dart';
import 'package:project_akhir/app/modules/ongkir/bindings/ongkir_binding.dart';
import 'package:project_akhir/app/modules/ongkir/views/ongkir_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.EKSPEDISI,
      page: () => EkspedisiView(),
      binding: EkspedisiBinding(),
    ),
    GetPage(
      name: _Paths.ONGKIR,
      page: () => OngkirView(),
      binding: OngkirBinding(),
    ),
  ];
}
