import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project_akhir/app/routes/app_pages.dart';

class LoginController extends GetxController {
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();

  final box = GetStorage();

  RxBool isLoading = false.obs;
  RxBool isHidden = true.obs;
  RxBool rememberme = false.obs;

  List accounts = [
    {
      "email": "admin@gmail.com",
      "pass": "admin",
    },
    {
      "email": "user1@gmail.com",
      "pass": "user1",
    },
    {
      "email": "user2@gmail.com",
      "pass": "user2",
    },
  ];

  void login() async {
    if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
      // coba proses login
      try {
        isLoading.value = true;
        await Future.delayed(Duration(milliseconds: 500));

        bool loginValid = false;

        accounts.forEach((element) {
          if (emailC.text == element["email"] && passC.text == element["pass"]) {
            loginValid = true;
          }
        });

        if (loginValid) {
          // proses login berhasil
          isLoading.value = false;

          if (box.read("rememberme") != null) {
            box.remove("rememberme");
          }

          if (rememberme.isTrue) {
            box.write("rememberme", {
              "email": emailC.text,
              "pass": passC.text,
            });
          }

          Get.offAllNamed(Routes.HOME);
        } else {
          throw "Data user tidak valid.";
        }
      } catch (e) {
        isLoading.value = false;
        Get.snackbar(
          "Error",
          e.toString(),
          duration: Duration(milliseconds: 1500),
        );
      }
    } else {
      isLoading.value = false;
      Get.snackbar(
        "Error",
        "Semua input harus diisi",
        duration: Duration(milliseconds: 1500),
      );
    }
  }
}
