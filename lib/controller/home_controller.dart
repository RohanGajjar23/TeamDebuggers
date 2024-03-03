import 'package:eventapp/pages/home/community/community_connect.dart';
import 'package:eventapp/pages/home/events/events.dart';
import 'package:eventapp/pages/home/events/widgets/events_list_views.dart';
import 'package:eventapp/pages/home/organize/organize_event.dart';
import 'package:eventapp/pages/home/profile/profile.dart';
import 'package:eventapp/pages/home/search/search_events.dart';
import 'package:eventapp/services/blockchain/blockchain_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var selectedPage = (0).obs;
  final List<Widget> pages = ([
    const Events(),
    const OrganizeEvents(),
    const CommunityConnect(),
    const SearchEvents(),
    const Profile(),
  ]);
  final BlockChain blockChain = BlockChain();

  void changePage(int index) {
    selectedPage(index);
    update();
  }

  @override
  void onInit() {
    super.onInit();
    blockChain.initBlockChain();
  }
}
