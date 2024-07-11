import 'package:flutter/material.dart';

class GifDetailBottomSheet {
  void show(String gifUrl, String gifTitle, BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    'Done',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: const [BoxShadow(blurRadius: 2.0)]),
                child: Image.network(
                  gifUrl,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16.0),
              const Text("Gif title:",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8.0),
              Text(gifTitle,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.normal)),
              const SizedBox(height: 40.0),
            ],
          ),
        ),
      ),
    );
  }
}
