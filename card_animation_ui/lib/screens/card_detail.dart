import 'dart:async';
import 'dart:math';

import 'package:card_animation_ui/controllers/card_controller.dart';
import 'package:card_animation_ui/widgets/app_background_design.dart';
import 'package:card_animation_ui/widgets/card_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CardDetailScreen extends StatefulWidget {
  CardDetailScreen({Key? key}) : super(key: key);

  @override
  State<CardDetailScreen> createState() => _CardDetailScreenState();
}

class _CardDetailScreenState extends State<CardDetailScreen> {
  final _cardVM = Get.put(CardDetailViewModel());

  final _adsController = Get.put(CardSliderController());

  @override
  Widget build(BuildContext context) {
    if (_cardVM.cardExpand.value) {
      _cardVM.startFlipTimer();
    } else {}
    return WillPopScope(
      onWillPop: () async {
        _cardVM.cardExpand(false);

        _cardVM.showCvc(false);
        if (!_adsController.isBack.value) {
          _cardVM.flipCard();
        }
        return true;
      },
      child: Scaffold(body: AppBackground(
        child: Obx(() {
          return SizedBox(
            width: Get.width,
            height: Get.height,
            child: Stack(
              children: [
                SizedBox(
                  child: Column(
                    children: [
                      AppBar(
                        backgroundColor: Colors.transparent,
                        centerTitle: true,
                        elevation: 0,
                        title: const Text(
                          "Card Animation UI",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        actions: [
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.more_vert))
                        ],
                        iconTheme: const IconThemeData(color: Colors.white),
                      ),
                      SizedBox(height: Get.height * 0.01),
                      Container(
                        // height: ,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: CardsSliderWidget(
                          height: Get.height * 0.24,
                          width: Get.width,
                          showCardDetails: _cardVM.cardExpand.value,
                          showCvc: _cardVM.showCvc.value,
                        ),
                      ),
                      SizedBox(height: Get.height * 0.02),
                      InkWell(
                        onTap: () {
                          if (_cardVM.showCvc.value) {
                            Clipboard.setData(
                                    const ClipboardData(text: "Copied cvc"))
                                .then((_) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text(
                                  "Copied CVC",
                                  style: TextStyle(color: Colors.white),
                                ),
                                backgroundColor: Colors.blue,
                              ));
                            });
                          } else {
                            Clipboard.setData(const ClipboardData(
                                    text: "Copied card number"))
                                .then((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Copied card number",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: Colors.blue,
                                ),
                              );
                            });
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: Get.width * 0.4,
                          height: Get.height * 0.045,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 2),
                              borderRadius: BorderRadius.circular(25)),
                          child: Text(
                            _cardVM.showCvc.value
                                ? "Copy CVV"
                                : "Copy Card Number",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _cardVM.flipCard();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 30,
                              alignment: Alignment.bottomCenter,
                              child: const Icon(
                                Icons.remove_red_eye_outlined,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                            SizedBox(width: Get.height * 0.005),
                            Container(
                              height: 30,
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                _cardVM.showCvc.value
                                    ? "Show card number"
                                    : "Show CVV",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 500),
                  bottom: 0,
                  right: 0,
                  left: 0,
                  top: _cardVM.cardExpand.value
                      ? Get.height < 700
                          ? Get.height * 0.52
                          : Get.height * 0.46
                      : Get.height < 700
                          ? Get.height * 0.22
                          : Get.height * 0.18,
                  child: Container(
                    color: _cardVM.cardExpand.value
                        ? Colors.transparent
                        : Colors.lightBlue,
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            if (_cardVM.cardExpand.value) {
                              _cardVM.changeCardExpand();
                              if (!_adsController.isBack.value) {
                                _cardVM.flipCard();
                              }
                              if (_cardVM.showCvc.value) {
                                _cardVM.changeShowCvc();
                              }
                            } else {
                              _cardVM.changeCardExpand();
                            }
                          },
                          child: Transform.rotate(
                            angle: _cardVM.cardExpand.value ? pi : 0,
                            child: _cardDetailsBar(
                              reverse: _cardVM.cardExpand.value,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Expanded(
                          child: CustomScrollView(shrinkWrap: true, slivers: [
                            SliverFillRemaining(
                              hasScrollBody: false,
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.lightBlue,
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(height: Get.height * 0.02),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                              width: 1, color: Colors.white),
                                        ),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Text(
                                            "Transaction History",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: Get.height * 0.015),
                                    _transactionItem(
                                      Icons.local_grocery_store,
                                      "Groceries",
                                      "10/08/2020 10:45 AM",
                                      "108,000",
                                      "Credit",
                                    ),
                                    _seperator(),
                                    _transactionItem(
                                      Icons.nat_outlined,
                                      "Cash Received",
                                      "2/08/2020 12:45 PM",
                                      "34,000",
                                      "Debit",
                                    ),
                                    _seperator(),
                                    _transactionItem(
                                      Icons.shopify_rounded,
                                      "Buy Phone",
                                      "10/08/2020 10:45 AM",
                                      "108,000",
                                      "Credit",
                                    ),
                                    _seperator(),
                                    _transactionItem(
                                      Icons.local_grocery_store,
                                      "Groceries",
                                      "10/08/2020 10:45 AM",
                                      "108,000",
                                      "Credit",
                                    ),
                                    _seperator(),
                                    _transactionItem(
                                      Icons.nat_outlined,
                                      "Cash Received",
                                      "2/08/2020 12:45 PM",
                                      "34,000",
                                      "Debit",
                                    ),
                                    _seperator(),
                                    _transactionItem(
                                      Icons.shopify_rounded,
                                      "Buy Phone",
                                      "10/08/2020 10:45 AM",
                                      "108,000",
                                      "Credit",
                                    ),
                                    _seperator(),
                                    _transactionItem(
                                      Icons.local_grocery_store,
                                      "Groceries",
                                      "10/08/2020 10:45 AM",
                                      "108,000",
                                      "Credit",
                                    ),
                                    _seperator(),
                                    _transactionItem(
                                      Icons.nat_outlined,
                                      "Cash Received",
                                      "2/08/2020 12:45 PM",
                                      "34,000",
                                      "Debit",
                                    ),
                                    _seperator(),
                                    _transactionItem(
                                      Icons.shopify_rounded,
                                      "Buy Phone",
                                      "10/08/2020 10:45 AM",
                                      "108,000",
                                      "Credit",
                                    ),
                                    SizedBox(height: Get.height * 0.015),
                                  ],
                                ),
                              ),
                            )
                          ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      )),
    );
  }

  _seperator() {
    return Container(
      margin: const EdgeInsets.only(top: 8, bottom: 8),
      width: Get.width,
      color: Colors.white,
      height: 0.5,
    );
  }

  _transactionItem(IconData iconData, String title, String date, String price,
      String debitType) {
    return SizedBox(
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(50)),
          child: Icon(
            iconData,
            color: Colors.blue,
          ),
        ),
        title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: Get.height * 0.007),
              Text(
                date,
                style: const TextStyle(
                  color: Colors.yellow,
                  fontSize: 13,
                ),
              )
            ]),
        trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  const SizedBox(width: 4),
                  Text(
                    '\$$price',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              SizedBox(height: Get.height * 0.007),
              Text(
                debitType,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                ),
              )
            ]),
      ),
    );
  }

  _cardDetailsBar({Color? color, bool reverse = false}) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: _cardVM.cardExpand.value ? Colors.transparent : Colors.lightBlue,
      ),
      child: Container(
        child: Stack(
          children: [
            SvgPicture.asset(
              "./assets/card-detail.svg",
              color: Colors.lightBlueAccent,
              width: Get.width,
            ),
            Align(
              alignment: Alignment(0.0, 0.0),
              child: Column(
                mainAxisAlignment:
                    reverse ? MainAxisAlignment.center : MainAxisAlignment.end,
                children: [
                  Transform.rotate(
                    angle: reverse ? pi : 0,
                    child: Text(
                      reverse ? "Hide" : "Show",
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.arrow_downward,
                    color: Colors.white,
                    size: 16,
                  ),
                  const SizedBox(height: 12)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
