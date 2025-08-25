import 'package:flutter/material.dart';
import 'package:lang_chang/constcolor.dart';
import 'package:translator/translator.dart';
import 'dart:async';

class LangTranstation extends StatefulWidget {
  const LangTranstation({super.key});

  @override
  State<LangTranstation> createState() => _LangTranstationState();
}

class _LangTranstationState extends State<LangTranstation> {
  var lang = [
    'Hindi',
    'English',
    'Spanish',
    'French',
    'German',
    'Chinese',
    'Japanese',
    'Russian',
    'Arabic',
    'Portuguese',
  ];
  var fromLang = 'Hindi';
  var toLang = 'English';
  var changelang = '';
  var outputText = '';
  bool isLoading = false;

  TextEditingController langController = TextEditingController();

  Future<void> translators(String src, String tolang, String inputText) async {
    // Translation logic to be implemented
    setState(() {
      isLoading = true;
      outputText = "Translating...";
    });
    try {
      GoogleTranslator translator = GoogleTranslator();
      var translation = await translator.translate(
        inputText,
        from: src,
        to: tolang,
      );
      Timer(const Duration(seconds: 2), () {
        setState(() {
          outputText = translation.text;
          isLoading = false;
        });
      });
    } catch (e) {
      Timer(const Duration(seconds: 2), () {
        setState(() {
          outputText = "Translation Failed, Try Again !";
          isLoading = false;
        });
      });
      if (src == "-- " || tolang == "-- ") {
        setState(() {
          outputText = "Please select the languages";
        });
      }
    }
  }

  String getlangcode(String langCode) {
    switch (langCode) {
      case 'Hindi':
        return 'hi';
      case 'English':
        return 'en';
      case 'Spanish':
        return 'es';
      case 'French':
        return 'fr';
      case 'German':
        return 'de';
      case 'Chinese':
        return 'zh-cn';
      case 'Japanese':
        return 'ja';
      case 'Russian':
        return 'ru';
      case 'Arabic':
        return 'ar';
      case 'Portuguese':
        return 'pt';
      default:
        return 'en';
    }
  }

  void swapLang() {
    setState(() {
      changelang = fromLang;
      fromLang = toLang;
      toLang = changelang;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Language Translator',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF10223E),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Image.asset('images/logo.png', height: 150, width: 150),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: DropdownButtonFormField(
                      value: fromLang,
                      focusColor: PrimaryColors,
                      iconDisabledColor: Colors.white,
                      iconEnabledColor: Colors.white,
                      dropdownColor: Colors.white,
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: PrimaryColors,
                      ),
                      items: lang.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          fromLang = newValue!;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 40),
                  IconButton(
                    icon: Icon(Icons.arrow_right_alt_outlined),
                    color: PrimaryColors,
                    onPressed: () {
                      setState(() {
                        swapLang();
                      });
                    },
                  ),
                  SizedBox(width: 50),

                  Expanded(
                    flex: 1,
                    child: DropdownButtonFormField(
                      focusColor: Colors.white,
                      iconDisabledColor: PrimaryColors,
                      iconEnabledColor: PrimaryColors,
                      value: toLang,
                      dropdownColor: Colors.white,
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: PrimaryColors,
                      ),
                      items: lang.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Center(child: Text(items)),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          toLang = newValue!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.all(8),
                child: Container(
                  width: 300,
                  child: TextFormField(
                    cursorColor: PrimaryColors,
                    autofocus: false,
                    style: TextStyle(color: PrimaryColors, fontSize: 18),

                    decoration: InputDecoration(
                      label: Text(
                        'Enter Text',
                        style: TextStyle(color: PrimaryColors, fontSize: 15),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: PrimaryColors,
                          width: 1.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: PrimaryColors,
                          width: 1.0,
                        ),
                      ),
                      errorStyle: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 15,
                      ),
                    ),

                    controller: langController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text to translate';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(10)),
              ElevatedButton(
                onPressed: isLoading
                    ? null
                    : () {
                        translators(
                          getlangcode(fromLang),
                          getlangcode(toLang),
                          langController.text,
                        );
                      },
                child: isLoading
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        'Translate',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF10223E),
                ),
              ),
              SizedBox(height: 20),
              Text(
                outputText,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: PrimaryColors,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
