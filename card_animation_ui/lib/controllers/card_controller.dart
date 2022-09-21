import 'dart:async';

import 'package:card_animation_ui/widgets/card_slider.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class CardDetailViewModel extends GetxController {
  final _adsController = Get.put(CardSliderController());

  // Card Detail Screen
  var cardExpand = false.obs;
  var showCvc = false.obs;
  RxInt flipTime = 30.obs;

  void changeCardExpand() {
    cardExpand(!cardExpand.value);
  }

  void changeShowCvc() {
    showCvc(!showCvc.value);
  }

  startFlipTimer() async {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!cardExpand.value) {
        flipTime(30);
        timer.cancel();
      }
      if (flipTime.value == 0) {
        flipCard();
        flipTime(30);
        return;
      } else {
        flipTime(flipTime.value - 1);
      }
    });
  }

  void flipCard() {
    _adsController.flip();
    flipTime(30);
    changeShowCvc();
  }
}
