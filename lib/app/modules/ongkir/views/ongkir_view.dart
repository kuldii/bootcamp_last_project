import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/ongkir_controller.dart';

class OngkirView extends GetView<OngkirController> {
  Map<String, dynamic> data = Get.arguments;
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> product = data["product"];
    Map<String, dynamic> ongkir = data["ongkir"]["rajaongkir"];
    List service = data["ongkir"]["rajaongkir"]["results"][0]["costs"] as List;

    print(service);

    controller.total.value = product["total_price"];

    return Scaffold(
      appBar: AppBar(
        title: Text('Ongkos Kirim'),
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
                    "Jumlah Barang",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("${product["jumlah"]} pcs"),
                  SizedBox(height: 5),
                  Text(
                    "Total Harga",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("Rp ${product["total_price"]}"),
                  SizedBox(height: 5),
                  Text(
                    "Total Berat",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("${product["total_weight"]} gram"),
                  SizedBox(height: 20),
                  DropdownSearch<dynamic>(
                    mode: Mode.BOTTOM_SHEET,
                    items: service,
                    popupItemBuilder: (context, dynamic item, isSelected) {
                      return ListTile(
                        isThreeLine: true,
                        title: Text("${ongkir["results"][0]["name"]} - ${item["service"]}"),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Rp ${item["cost"][0]["value"]}"),
                            Text(
                              item["cost"][0]["etd"] == "1-1" ? "Estimasi : 1 hari" : "Estimasi : ${item["cost"][0]["etd"]} hari",
                            ),
                          ],
                        ),
                      );
                    },
                    itemAsString: (dynamic item) => "Paket " + item["service"],
                    onChanged: (value) {
                      controller.isHidden.value = false;
                      controller.total.value = product["total_price"] + value["cost"][0]["value"] as int;
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Card(
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "Keterangan Pengiriman",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Ekspedisi",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("${ongkir["results"][0]["name"]}"),
                  SizedBox(height: 5),
                  Text(
                    "Provinsi Asal",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("${ongkir["origin_details"]["province"]}"),
                  SizedBox(height: 5),
                  Text(
                    "Kota/Kabupaten Asal",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("${ongkir["origin_details"]["type"]} ${ongkir["origin_details"]["city_name"]}"),
                  SizedBox(height: 5),
                  Text(
                    "Provinsi Tujuan",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("${ongkir["destination_details"]["province"]}"),
                  SizedBox(height: 5),
                  Text(
                    "Kota/Kabupaten Tujuan",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("${ongkir["destination_details"]["type"]} ${ongkir["destination_details"]["city_name"]}"),
                ],
              ),
            ),
          ),
          SizedBox(height: 30),
          Obx(
            () => (controller.isHidden.isFalse)
                ? Text(
                    "TOTAL : Rp ${controller.total}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  )
                : SizedBox(),
          ),
        ],
      ),
    );
  }
}
