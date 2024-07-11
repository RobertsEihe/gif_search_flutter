import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../services/provider_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final providerService = Provider.of<ProviderService>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Giphy Search",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
        centerTitle: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                context.go('/homeScreen/searchScreen');
                providerService.pagingController.refresh();
              },
              style: ButtonStyle(
                fixedSize: WidgetStateProperty.all(const Size(250.0, 60.0)),
                shape: WidgetStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0))),
                foregroundColor: WidgetStateProperty.all(Colors.white),
                backgroundColor: WidgetStateProperty.all(
                    const Color.fromARGB(255, 255, 45, 85)),
              ),
              child: const Text(
                "Search GIFs",
                style: TextStyle(fontSize: 16),
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 8)),
            ElevatedButton(
              onPressed: () {
                context.go('/homeScreen/trendingScreen');
                providerService.pagingController.refresh();
              },
              style: ButtonStyle(
                fixedSize: WidgetStateProperty.all(const Size(250.0, 60.0)),
                shape: WidgetStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0))),
                foregroundColor: WidgetStateProperty.all(Colors.white),
                backgroundColor: WidgetStateProperty.all(
                    const Color.fromARGB(255, 0, 199, 190)),
              ),
              child: const Text(
                "Trending GIFs",
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
