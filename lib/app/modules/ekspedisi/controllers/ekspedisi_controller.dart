import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:project_akhir/app/routes/app_pages.dart';

class EkspedisiController extends GetxController {
  String idProvinceAsal = "0";
  String idCityAsal = "0";
  String idProvinceTujuan = "0";
  String idCityTujuan = "0";
  String codeCourier = "";

  TextEditingController jumlahC = TextEditingController(text: "1");

  void cekOngkir(int weight) async {
    if (idProvinceAsal != 0 && idProvinceTujuan != 0 && idCityAsal != 0 && idCityTujuan != 0 && codeCourier.isNotEmpty && jumlahC.text.isNotEmpty) {
      // Memenuhi
      // origin : idCityAsal
      // destination : idCityTujuan
      // weight : weight
      // courier : codeCourier

      Uri url = Uri.parse("https://api.rajaongkir.com/starter/cost");
      try {
        var response = await http.post(
          url,
          headers: {
            'content-type': "application/x-www-form-urlencoded",
            "key": "0ae702200724a396a933fa0ca4171a7e",
          },
          body: {
            "origin": idCityAsal,
            "destination": idCityTujuan,
            "weight": weight.toString(),
            "courier": codeCourier,
          },
        );

        var body = json.decode(response.body) as Map<String, dynamic>;
        if (body["rajaongkir"]["status"]["code"] != 200) {
          Get.snackbar(
            "Error",
            "${body["rajaongkir"]["status"]["description"]}",
            duration: Duration(milliseconds: 2000),
          );
        } else {
          Get.toNamed(Routes.ONGKIR, arguments: body);
        }
      } catch (e) {
        print(e);
        Get.snackbar(
          "Error",
          "Tidak dapat mengecek ongkos kirim.",
          duration: Duration(milliseconds: 1500),
        );
      }
    } else {
      Get.snackbar(
        "Error",
        "Semua input harus diisi.",
        duration: Duration(milliseconds: 1500),
      );
    }
  }
}
