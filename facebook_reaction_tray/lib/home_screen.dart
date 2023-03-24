import 'package:facebook_reaction_tray/model.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  final List<Emoji> emojis = [
    Emoji(path: 'assets/like.json', scale: 1.7),
    Emoji(path: 'assets/love.json', scale: 1.5),
    Emoji(path: 'assets/care.json', scale: 0.7),
    Emoji(path: 'assets/laughing.json', scale: 0.8),
    Emoji(path: 'assets/wow.json', scale: 0.85),
    Emoji(path: 'assets/crying.json', scale: 0.85),
    Emoji(path: 'assets/angry.json', scale: 0.85),
  ];

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  int currentHoverEmoji = 100;
  double currentHoverPosition = 0;
  double height = 0;
  double width = 0;

  void nextEmoji() {
    if (currentHoverEmoji < emojis.length - 1) {
      setState(() {
        currentHoverEmoji++;
      });
    }
  }

  void previousEmoji() {
    if (currentHoverEmoji > 0) {
      setState(() {
        currentHoverEmoji--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Facebook Reaction Tray",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedContainer(
            alignment: Alignment.center,
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 10),
            // width: double.infinity,
            height: height,
            width: width,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(100),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (int i = 0; i < emojis.length; i++)
                  Transform.scale(
                    scale: emojis[i].scale + (currentHoverEmoji == i ? 0.7 : 0),
                    child: Lottie.asset(
                      emojis[i].path,
                      height: 40,
                      controller: currentHoverEmoji == i ? _controller : null,
                      animate: false,
                      fit: BoxFit.cover,
                    ),
                  )
              ],
            ),
          ),
          GestureDetector(
            onLongPress: () {
              setState(() {
                height = 40;
                width = MediaQuery.of(context).size.width;
              });
              _controller.repeat();
            },
            onLongPressEnd: (_) {
              setState(() {
                currentHoverEmoji = 100;
                height = 0;
                width = 0;
              });
              _controller.stop();
              _controller.reset();
            },
            onLongPressDown: (details) {
              setState(() {
                currentHoverEmoji = 2;
                currentHoverPosition = details.localPosition.dx;
              });
            },
            onLongPressMoveUpdate: ((details) {
              final dragDifference =
                  details.localPosition.dx - currentHoverPosition;
              if (dragDifference.abs() > 40) {
                dragDifference > 0 ? nextEmoji() : previousEmoji();
              }
            }),
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(100),
              ),
              child: const Text(
                "Like",
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
