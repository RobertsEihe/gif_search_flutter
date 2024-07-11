import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../services/provider_service.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final providerService = Provider.of<ProviderService>(context);
    providerService.context = context;
    providerService.searchMode = true;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Search GIFs",
            style: TextStyle(fontWeight: FontWeight.bold)),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Search GIFs',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (query) {
                providerService.onSearchChanged(query);
              },
            ),
          ),
        ),
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
