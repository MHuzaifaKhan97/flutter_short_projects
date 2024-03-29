import 'package:env_dart_defines_example/env/env.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String apiKey = "", stripeKey = "", apiURL = "";
  @override
  void initState() {
    super.initState();
    getKey();
  }

  getKey() async {
    const myAPIKey = String.fromEnvironment("MY_API_KEY");
    const myStripeKey = String.fromEnvironment("STRIPE_KEY");
    const myApiURL = String.fromEnvironment("MY_API_URL");

    if (myAPIKey.isNotEmpty) {
      apiKey = myAPIKey;
    }
    if (myStripeKey.isNotEmpty) {
      stripeKey = myStripeKey;
    }
    if (myApiURL.isNotEmpty) {
      apiURL = myApiURL;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dart Define & .ENV"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("API KEY"),
                  Text(
                    apiKey,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("STRIPE KEY"),
                  Text(
                    stripeKey,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Api URL"),
                  Text(
                    apiURL,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Api KEY from Env"),
                  Text(
                    Env.apiKEY,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("STRIPE Env"),
                  Text(
                    Env.stripeKey,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Default key"),
                  Text(
                    Env.key3,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Three Ways
// 1. hardcoded in file.
// 2. dart define 
      // - flutter run --dart-define MY_API_KEY=a1b2c33d4e5f6g7h8i9jakblc
// 3. Envied package (also provide obfuscation)



// flutter run \
//   --dart-define MY_API_KEY=a1b2c33d4e5f6g7h8i9jakblc \
//   --dart-define STRIPE_KEY=pk_test_aposdjpa309u2n230ibt23908g \
//   --dart-define MY_API_URL=https://google.com.pk
// add launch.json file in .gitignore as well


// Envoid
// Keys update when we change the file name

// flutter pub add envied
// flutter pub add --dev envied_generator
// flutter pub add --dev build_runner

// Command to create env.g.dart file
// flutter pub run build_runner build --delete-conflicting-outputs