import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    if (box.read("rememberme") != null) {
      controller.emailC.text = box.read("rememberme")["email"];
      controller.passC.text = box.read("rememberme")["pass"];
      controller.rememberme.value = true;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('LoginView'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            controller: controller.emailC,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: "Email",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 15),
          Obx(
            () => TextField(
              controller: controller.passC,
              autocorrect: false,
              keyboardType: TextInputType.text,
              obscureText: controller.isHidden.value,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () => controller.isHidden.toggle(),
                  icon: Icon(
                    controller.isHidden.isTrue ? Icons.remove_red_eye : Icons.remove_red_eye_outlined,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 5),
          Obx(
            () => CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              value: controller.rememberme.value,
              onChanged: (value) => controller.rememberme.toggle(),
              title: Text("Remember me"),
            ),
          ),
          SizedBox(height: 35),
          Obx(
            () => ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(Get.width, 60),
              ),
              onPressed: () {
                if (controller.isLoading.isFalse) {
                  controller.login();
                }
              },
              child: controller.isLoading.isFalse
                  ? Text("LOGIN")
                  : CircularProgressIndicator(
                      color: Colors.white,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
