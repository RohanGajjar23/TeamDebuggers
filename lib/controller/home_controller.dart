import 'dart:developer';

import 'package:eventapp/pages/home/events/events.dart';
import 'package:eventapp/pages/home/organize/organize_event.dart';
import 'package:eventapp/pages/home/profile/profile.dart';
import 'package:eventapp/services/blockchain/blockchain_functions.dart';
import 'package:eventapp/services/etherscan/etherscan_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var selectedPage = (0).obs;
  var isLoading = false.obs;
  var privateKey = "".obs;
  var publicId = "".obs;
  final List<Widget> pages = ([
    const Events(),
    const OrganizeEvents(),
    const Profile(),
  ]);
  final BlockChain blockChain = BlockChain();

  var quantity = (01).obs;

  void changePage(int index) {
    selectedPage(index);
    update();
  }

  @override
  void onInit() {
    super.onInit();
    blockChain.initBlockChain();
  }

  void incrementQuantity() {
    if (quantity.value < 9) {
      quantity(quantity.value + 1);
      log("qunatity: ${quantity.value}");
      update();
    } else {
      Get.focusScope!.unfocus();
      Get.snackbar("Maximum Quantity Reached ", "Per Time",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void decrementQuantity() {
    if (quantity.value > 0) {
      quantity(quantity.value - 1);
      log("qunatity: ${quantity.value}");

      update();
    } else {
      Get.focusScope!.unfocus();

      Get.snackbar("Add Some Quantity", "",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<bool> checkTransactionLoading(String txhash) async {
    final data = await EtherScanApi.getTransactionReceiptStatus(txhash);
    return data['result']['status'] == "" ? true : false;
  }
}
