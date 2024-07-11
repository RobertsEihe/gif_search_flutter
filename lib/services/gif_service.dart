import 'package:http/http.dart' as http;
import 'dart:convert';

import 'error_handle.dart';

class GifService {
  static const String _apiKey = "hRkoDriDnlklR6dqQHyscRDR3OcP5FLS";
  static const int _pageSize = 25;

  Future<List<Map<String, String>>> getGifs(
      int offset, String searchQuery, bool searchMode,
      {http.Client? client}) async {
    client ??= http.Client();
    const int limit = _pageSize;
    String url;

    if (searchMode) {
      url =
          "https://api.giphy.com/v1/gifs/search?api_key=$_apiKey&q=$searchQuery&limit=$limit&offset=$offset&rating=g";
    } else {
      url =
          "https://api.giphy.com/v1/gifs/trending?api_key=$_apiKey&limit=$limit&offset=$offset&rating=g";
    }

    try {
      final response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        try {
          final Map<String, dynamic> data = json.decode(response.body);
          final List<dynamic> gifs = data['data'];
          return gifs
              .map((gif) => {
                    'url': gif['images']['fixed_height']['url'] as String,
                    'title': gif['title'] as String,
                  })
              .toList();
        } catch (error) {
          throw ErrorHandle.invalidData;
        }
      } else {
        throw ErrorHandle.invalidResponse;
      }
    } catch (error) {
      rethrow;
    }
  }
}
