import 'package:dictionary_provider/Provider/dictionary_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    TextEditingController word = TextEditingController();
    final provider = Provider.of<dictionaryProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Dictionary App"),
          centerTitle: true,
        ),
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextFormField(
              controller: word,
              decoration: InputDecoration(
                  label: Text("Enter Word"),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15))),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Provider.of<dictionaryProvider>(context, listen: false)
                  .getData(word.text.toString());
            },
            child: Container(
              height: 50,
              width: 120,
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(10)),
              child: Center(
                  child: Text(
                "Get Meaning ",
                style: TextStyle(color: Colors.white, fontSize: 18),
              )),
            ),
          ),
          Expanded(
            child: provider.noDataFound?Center(child: Text("No matching word found. Please try again.")):Builder(
              builder: (context) {
                final provider = Provider.of<dictionaryProvider>(context);
                if (provider.isReady == true) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (provider.model.isEmpty) {
                  return Center(
                    child: Text("Please enter a word to search."),
                  );


                }

                return   ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    // Handle potential null values in the response
                    final word = provider.model[index]['word'] ?? "Unknown";
                    final partOfSpeech = provider.model[index]['meanings']?[0]
                    ['partOfSpeech'] ??
                        "No part of speech available";
                    final definition = provider.model[index]['meanings']?[0]
                    ['definitions']?[0]['definition'] ??
                        "No definition available";
                    final example = provider.model[index]['meanings']?[2]
                    ['definitions']?[1]['example'] ??
                        "No example available";
                    return Padding(
                      padding: const EdgeInsets.all(40),
                      child: Card(
                        child: Container(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.start,
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Word: ",
                                      style: TextStyle(
                                          fontWeight:
                                          FontWeight.bold,
                                          color:
                                          Colors.blueAccent),
                                    ),
                                    TextSpan(
                                      text: word
                                          .toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Part Of Speech: ",
                                      style: TextStyle(
                                          fontWeight:
                                          FontWeight.bold,
                                          color:
                                          Colors.blueAccent),
                                    ),
                                    TextSpan(
                                      text:  partOfSpeech,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Definition: ",
                                      style: TextStyle(
                                          fontWeight:
                                          FontWeight.bold,
                                          color:
                                          Colors.blueAccent),
                                    ),
                                    TextSpan(
                                      text: definition,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Example: ",
                                      style: TextStyle(
                                          fontWeight:
                                          FontWeight.bold,
                                          color:
                                          Colors.blueAccent),
                                    ),
                                    TextSpan(
                                      text:  example,
                                      style: TextStyle(
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
                );
              },
            ),
          ),
        ]));
  }
}
