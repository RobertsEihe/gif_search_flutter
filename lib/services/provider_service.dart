import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'dart:async';

import '../screens/detail_sheet.dart';
import 'error_handle.dart';
import 'gif_service.dart';

class ProviderService with ChangeNotifier {
  final PagingController<int, Map<String, String>> _pagingController =
      PagingController(firstPageKey: 0);
  String _searchQuery = '';
  final GifService _gifService = GifService();
  final GifDetailBottomSheet _gifBottomSheet = GifDetailBottomSheet();
  final ErrorHandle _errorHandle = ErrorHandle();
  BuildContext? _context;
  bool? _searchMode;
  static const int _pageSize = 25;
  Timer? _debounce;

  ProviderService() {
    _pagingController.addPageRequestListener((pageKey) {
      _getPage(pageKey);
    });
  }

  PagingController<int, Map<String, String>> get pagingController =>
      _pagingController;

  String get searchQuery => _searchQuery;

  set context(BuildContext context) {
    _context = context;
  }

  set searchMode(bool searchMode) {
    _searchMode = searchMode;
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    _pagingController.refresh();
    notifyListeners();
  }

  void onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 1000), () {
      setSearchQuery(query);
    });
  }

  void showGifBottomSheet(
      String gifUrl, String gifTitle, BuildContext context) {
    _gifBottomSheet.show(gifUrl, gifTitle, context);
  }

  Future<void> _getPage(int pageKey) async {
    try {
      final newItems =
          await _gifService.getGifs(pageKey, _searchQuery, _searchMode!);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _errorHandle.showError(_context!, error.toString());
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    _debounce?.cancel();
    super.dispose();
  }
}
