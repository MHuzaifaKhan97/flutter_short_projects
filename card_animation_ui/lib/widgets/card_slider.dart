import 'dart:math';
import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardsSliderWidget extends StatefulWidget {
  @override
  State<CardsSliderWidget> createState() => _CardsSliderWidgetState();

  CardsSliderWidget(
      {required this.height,
      required this.width,
      this.showCardDetails = false,
      this.showCvc = false});
  double height;
  double width;
  bool showCardDetails;
  bool showCvc;
}

class _CardsSliderWidgetState extends State<CardsSliderWidget> {
  late double screenHeightLarge;

  CardSliderController _adsController = Get.put(CardSliderController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: Get.height < 700
          ? widget.height + Get.height * 0.04
          : widget.height + Get.height * 0.03,
      child: CarouselSlider(
        options: CarouselOptions(
            height: widget.height,
            viewportFraction: widget.showCardDetails ? 1 : 0.87,
            autoPlay: false,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            pauseAutoPlayOnTouch: true,
            scrollPhysics: widget.showCardDetails
                ? NeverScrollableScrollPhysics()
                : AlwaysScrollableScrollPhysics(),
            aspectRatio: 2.0,
            onPageChanged: (index, reason) {
              _adsController.cardIndex.value = index;
            }),
        items: _adsController.cards.map((i) {
          return Obx(() {
            return GestureDetector(
              onTap: () async {
                // _adsController.flip();
              },
              child: TweenAnimationBuilder(
                  tween:
                      Tween<double>(begin: 0, end: _adsController.angle.value),
                  duration: Duration(seconds: 1),
                  builder: (BuildContext context, double val, __) {
                    if (val >= (pi / 2)) {
                      _adsController.isBack(false);
                    } else {
                      _adsController.isBack(true);
                    }
                    return Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateY(val),
                      child: _adsController.isBack.value
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Stack(
                                children: [
                                  Image.asset(
                                    "./assets/front.png",
                                    fit: BoxFit.fitWidth,
                                  ),
                                ],
                              ),
                            )
                          : Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.identity()..rotateY(pi),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Stack(
                                  children: [
                                    Image.asset(
                                      "./assets/back.png",
                                      fit: BoxFit.fitWidth,
                                    )
                                  ],
                                ),
                              ),
                            ),
                    );
                  }),
            );
          });
        }).toList(),
      ),
      // _adsIndicator()
      //   ],
      // ),
    );
  }

  Widget _adsIndicator() {
    var adsIndexes = [];
    for (var x = 0; x < _adsController.cards.length; x++) {
      adsIndexes.add(x);
    }
    return Obx(() {
      return Positioned(
        bottom: 10,
        child: Container(
          height: Get.height * 0.02,
          child: FittedBox(
            child: Row(
              children: adsIndexes.map((index) {
                return Container(
                  width: 12.0,
                  height: 12.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 3.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _adsController.cardIndex.value == index
                          ? Colors.grey
                          : Colors.white),
                );
              }).toList(),
            ),
          ),
        ),
      );
    });
  }
}

class CardSliderController extends GetxController {
  RxBool isAdLoading = true.obs;
  RxInt currentAdIndex = 0.obs;
  RxBool isBack = true.obs;
  RxDouble angle = 0.0.obs;
  void flip() {
    angle.value = (angle.value + pi) % (2 * pi);
  }

  List<String> cards = [
    "https://pngpress.com/wp-content/uploads/2020/08/uploads_credit_card_credit_card_PNG13.png",
    "https://pngpress.com/wp-content/uploads/2020/08/uploads_credit_card_credit_card_PNG13.png",
    "https://pngpress.com/wp-content/uploads/2020/08/uploads_credit_card_credit_card_PNG13.png",
    "https://pngpress.com/wp-content/uploads/2020/08/uploads_credit_card_credit_card_PNG13.png"
  ];

  RxInt cardIndex = 0.obs;

  getAdsDigital() async {
    isAdLoading(true);
  }

  void changeIsBack(bool value) {
    isBack(value);
  }
}
