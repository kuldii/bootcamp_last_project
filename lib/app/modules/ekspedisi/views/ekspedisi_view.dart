import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:project_akhir/app/data/models/city_model.dart';
import 'package:project_akhir/app/data/models/province_model.dart';

import '../controllers/ekspedisi_controller.dart';

class EkspedisiView extends GetView<EkspedisiController> {
  Map<String, dynamic> product = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pilih Ekspedisi'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Card(
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "Keterangan Produk",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Nama Produk",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("${product["name"]}"),
                  SizedBox(height: 5),
                  Text(
                    "Harga Produk",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("Rp ${product["price"]}"),
                  SizedBox(height: 5),
                  Text(
                    "Berat Produk",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("${product["weight"]} gram"),
                ],
              ),
            ),
          ),
          SizedBox(height: 25),
          TextField(
            controller: controller.jumlahC,
            autocorrect: false,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Jumlah Barang",
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 22),
            ),
          ),
          SizedBox(height: 15),
          // provinsi asal
          DropdownSearch<Province>(
            dropdownSearchDecoration: InputDecoration(
              labelText: "Provinsi Asal",
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            ),
            onFind: (String? filter) async {
              Uri url = Uri.parse("https://api.rajaongkir.com/starter/province");

              try {
                final response = await http.get(
                  url,
                  headers: {
                    "key": "0ae702200724a396a933fa0ca4171a7e",
                  },
                );

                var data = json.decode(response.body) as Map<String, dynamic>;

                var statusCode = data["rajaongkir"]["status"]["code"];

                if (statusCode != 200) {
                  throw data["rajaongkir"]["status"]["description"];
                }

                var listAllProvince = data["rajaongkir"]["results"] as List<dynamic>;

                var models = Province.fromJsonList(listAllProvince);
                return models;
              } catch (err) {
                print(err);
                return List<Province>.empty();
              }
            },
            popupItemBuilder: (context, item, isSelected) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Text(
                  "${item.province}",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              );
            },
            showSearchBox: true,
            onChanged: (value) => controller.idProvinceAsal = value!.provinceId!,
            itemAsString: (item) => item!.province!,
          ),
          SizedBox(height: 15),
          // kota asal
          DropdownSearch<City>(
            dropdownSearchDecoration: InputDecoration(
              labelText: "Kota/Kabupaten Asal",
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            ),
            onFind: (String? filter) async {
              Uri url = Uri.parse("https://api.rajaongkir.com/starter/city?province=${controller.idProvinceAsal}");

              try {
                final response = await http.get(
                  url,
                  headers: {
                    "key": "0ae702200724a396a933fa0ca4171a7e",
                  },
                );

                var data = json.decode(response.body) as Map<String, dynamic>;

                var statusCode = data["rajaongkir"]["status"]["code"];

                if (statusCode != 200) {
                  throw data["rajaongkir"]["status"]["description"];
                }

                var listAllCity = data["rajaongkir"]["results"] as List<dynamic>;

                var models = City.fromJsonList(listAllCity);
                return models;
              } catch (err) {
                print(err);
                return List<City>.empty();
              }
            },
            popupItemBuilder: (context, item, isSelected) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Text(
                  "${item.type.toString().capitalizeFirst} ${item.cityName.toString().capitalizeFirst}",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              );
            },
            showSearchBox: true,
            onChanged: (value) => controller.idCityAsal = value!.cityId!,
            itemAsString: (item) => "${item!.type.toString().capitalizeFirst} ${item.cityName.toString().capitalizeFirst}",
          ),
          SizedBox(height: 15),
          // provinsi tujuan
          DropdownSearch<Province>(
            dropdownSearchDecoration: InputDecoration(
              labelText: "Provinsi Tujuan",
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            ),
            onFind: (String? filter) async {
              Uri url = Uri.parse("https://api.rajaongkir.com/starter/province");

              try {
                final response = await http.get(
                  url,
                  headers: {
                    "key": "0ae702200724a396a933fa0ca4171a7e",
                  },
                );

                var data = json.decode(response.body) as Map<String, dynamic>;

                var statusCode = data["rajaongkir"]["status"]["code"];

                if (statusCode != 200) {
                  throw data["rajaongkir"]["status"]["description"];
                }

                var listAllProvince = data["rajaongkir"]["results"] as List<dynamic>;

                var models = Province.fromJsonList(listAllProvince);
                return models;
              } catch (err) {
                print(err);
                return List<Province>.empty();
              }
            },
            popupItemBuilder: (context, item, isSelected) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Text(
                  "${item.province}",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              );
            },
            showSearchBox: true,
            onChanged: (value) => controller.idProvinceTujuan = value!.provinceId!,
            itemAsString: (item) => item!.province!,
          ),
          SizedBox(height: 15),
          // kota tujuan
          DropdownSearch<City>(
            dropdownSearchDecoration: InputDecoration(
              labelText: "Kota/Kabupaten Tujuan",
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            ),
            onFind: (String? filter) async {
              Uri url = Uri.parse("https://api.rajaongkir.com/starter/city?province=${controller.idProvinceTujuan}");

              try {
                final response = await http.get(
                  url,
                  headers: {
                    "key": "0ae702200724a396a933fa0ca4171a7e",
                  },
                );

                var data = json.decode(response.body) as Map<String, dynamic>;

                var statusCode = data["rajaongkir"]["status"]["code"];

                if (statusCode != 200) {
                  throw data["rajaongkir"]["status"]["description"];
                }

                var listAllCity = data["rajaongkir"]["results"] as List<dynamic>;

                var models = City.fromJsonList(listAllCity);
                return models;
              } catch (err) {
                print(err);
                return List<City>.empty();
              }
            },
            popupItemBuilder: (context, item, isSelected) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Text(
                  "${item.type.toString().capitalizeFirst} ${item.cityName.toString().capitalizeFirst}",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              );
            },
            showSearchBox: true,
            onChanged: (value) => controller.idCityTujuan = value!.cityId!,
            itemAsString: (item) => "${item!.type.toString().capitalizeFirst} ${item.cityName.toString().capitalizeFirst}",
          ),
          SizedBox(height: 15),
          DropdownSearch<Map<String, dynamic>>(
            mode: Mode.BOTTOM_SHEET,
            items: [
              {
                "code": "jne",
                "name": "JNE",
              },
              {
                "code": "tiki",
                "name": "TIKI",
              },
              {
                "code": "pos",
                "name": "POS INDONESIA",
              },
            ],
            onChanged: (value) => controller.codeCourier = value!["code"],
            itemAsString: (item) => "${item!['name']}",
            popupItemBuilder: (context, item, isSelected) => Container(
              padding: EdgeInsets.all(20),
              child: Text(
                "${item['name']}",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => controller.cekOngkir(
              product,
              (product["weight"] as int) * int.parse(controller.jumlahC.text),
            ),
            child: Text("CEK ONGKOS KIRIM"),
          ),
        ],
      ),
    );
  }
}
