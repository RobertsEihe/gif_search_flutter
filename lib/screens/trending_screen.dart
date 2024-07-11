import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../services/provider_service.dart';

class TrendingScreen extends StatelessWidget {
  const TrendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final providerService = Provider.of<ProviderService>(context);
    providerService.context = context;
    providerService.searchMode = false;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Trending GIFs",
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: PagedGridView<int, Map<String, String>>(
        pagingController: providerService.pagingController,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        padding: const EdgeInsets.all(10),
        builderDelegate: PagedChildBuilderDelegate<Map<String, String>>(
          itemBuilder: (context, item, index) => GestureDetector(
            onTap: () => providerService.showGifBottomSheet(
                item['url']!, item['title']!, context),
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
              child: SizedBox(
                height: 50,
                child: Image.network(
                  item['url']!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          noItemsFoundIndicatorBuilder: (context) => const Center(
            child: Text('No items found'),
          ),
        ),
      ),
    );
  }
}
