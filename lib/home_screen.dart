import 'package:dictionary_provider/Provider/dictionary_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key}); // Removed `const` to allow use of a non-const controller

  final TextEditingController wordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<dictionaryProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dictionary App"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextFormField(
              controller: wordController,
              decoration: InputDecoration(
                label: const Text("Enter Word"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              final inputWord = wordController.text.trim();
              if (inputWord.isNotEmpty) {
                provider.getData(inputWord);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Please enter a word!")),
                );
              }
            },
            child: Container(
              height: 50,
              width: 150,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  "Get Meaning",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ),
          Expanded(
            child: provider.isReady
                ? const Center(child: CircularProgressIndicator())
                : provider.noDataFound
                ? const Center(
              child: Text(
                "No matching word found. Please try again.",
                textAlign: TextAlign.center,
              ),
            )
                : provider.model.isEmpty
                ? const Center(
              child: Text("Please enter a word to search."),
            )
                : ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                final word = provider.model[index]['word'] ?? "Unknown";
                final partOfSpeech = provider.model[index]['meanings']?[0]
                ['partOfSpeech'] ??
                    "No part of speech available";
                final definition = provider.model[index]['meanings']?[0]
                ['definitions']?[0]['definition'] ??
                    "No definition available";
                final example = provider.model[index]['meanings']?[0]
                ['definitions']?[0]['example'] ??
                    "No example available";

                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Card(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                const TextSpan(
                                  text: "Word: ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                TextSpan(
                                  text: word,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text.rich(
                            TextSpan(
                              children: [
                                const TextSpan(
                                  text: "Part Of Speech: ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                TextSpan(
                                  text: partOfSpeech,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text.rich(
                            TextSpan(
                              children: [
                                const TextSpan(
                                  text: "Definition: ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                TextSpan(
                                  text: definition,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text.rich(
                            TextSpan(
                              children: [
                                const TextSpan(
                                  text: "Example: ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                TextSpan(
                                  text: example,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
