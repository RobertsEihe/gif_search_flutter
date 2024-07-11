import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'dart:convert';

import 'package:gif_search_flutter/services/gif_service.dart';
import 'test_data.dart';

void main() {
  group('getGifs', () {
    final GifService gifService = GifService();

    test('getGifs success', () async {
      final mockJsonResponse = jsonTestingData;

      final mockClient = MockClient((request) async {
        return http.Response(json.encode(mockJsonResponse), 200);
      });

      final gifs = await gifService.getGifs(0, '', false, client: mockClient);

      expect(gifs, [
        {
          'url':
              'https://media1.giphy.com/media/E6pqjeQ5JNj1lxhVOq/200.gif?cid=93756d72z4pd3hjf8tf6y1n3rjkkweqlgju2t80bkbw72pws&ep=v1_gifs_trending&rid=200.gif&ct=g',
          'title': 'Schools Out Fun GIF by Pen Pals',
        }
      ]);
    });
  });
}
