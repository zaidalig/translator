import 'package:translator/translator.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class translate extends StatefulWidget {
  const translate({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _translateState createState() => _translateState();
}

// ignore: camel_case_types
class _translateState extends State<translate> {
  GoogleTranslator translator = GoogleTranslator();
  final text = TextEditingController();
  var translatedText;

  var dropdownValue;

  static const Map<String, String> lang = {
    "Hindi": "hi",
    "English": "en",
    "Urdu": "ur",
    "Arabic":"ar"
  };

  void trans() {
    translator.translate(text.text, to: "$dropdownValue").then((value) {
      setState(() {
        translatedText = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "translate ",
          style: TextStyle(
            fontSize: 30,
            color: Colors.yellow,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(30),
                child: TextField(
                  controller: text,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: const InputDecoration.collapsed(
                    hintText:
                        'Enter Text here to translate from english to urdu ',
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text("Select Language here =>"),
                  DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (var newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                        trans();
                      });
                    },
                    items: lang
                        .map((string, value) {
                          return MapEntry(
                            string,
                            DropdownMenuItem<String>(
                              value: value,
                              child: Text(string),
                            ),
                          );
                        })
                        .values
                        .toList(),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              const Text('Translated Text :'),
              const SizedBox(
                height: 10,
              ),
              Text(
                "$translatedText",
                style: const TextStyle(color: Colors.green),
              )
            ],
          ),
        ),
      ),
    );
  }
}
