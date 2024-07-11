import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import 'screens/home_screen.dart';
import 'screens/search_screen.dart';
import 'screens/trending_screen.dart';
import 'services/provider_service.dart';

void main() {
  runApp(const MyApp());
}

GoRouter router() {
  return GoRouter(
    initialLocation: '/homeScreen',
    routes: [
      GoRoute(
        path: '/homeScreen',
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(
              path: 'searchScreen',
              builder: (context, state) => const SearchScreen()),
          GoRoute(
              path: 'trendingScreen',
              builder: (context, state) => const TrendingScreen()),
        ],
      ),
    ],
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProviderService()),
      ],
      child: MaterialApp.router(
        routerConfig: router(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
