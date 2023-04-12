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
              )
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
