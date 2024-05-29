import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  modifyJson();
}

Future<void> modifyJson() async {
  try {
    // Load the JSON file from the assets
    String dataString = await rootBundle.loadString('countries.json');
    List<dynamic> jsonArray = jsonDecode(dataString);

    List<Map<String, dynamic>> modifiedJsonArray = [];

    // Iterate through each element in the array
    for (Map<String, dynamic> jsonData in jsonArray) {
      jsonData.remove('emojiU');
      jsonData.remove('capital');
      jsonData.remove('tld');
      jsonData.remove('latitude');
      jsonData.remove('longitude');
      jsonData.remove('nationality');
      jsonData.remove('native');
      jsonData.remove('region');
      jsonData.remove('subregion');
      jsonData.remove('region_id');
      jsonData.remove('subregion_id');
      jsonData.remove('currency');
      jsonData.remove('currency_name');
      jsonData.remove('currency_symbol');
      jsonData.remove('timezones');

      // Retain only 'es' keys in 'translations' if present
      if (jsonData.containsKey('translations')) {
        Map<String, dynamic> translations = {};
        Map<String, dynamic> currentTranslations = jsonData['translations'];
        if (currentTranslations.containsKey('es')) {
          translations['es'] = currentTranslations['es'];
        }
        jsonData['translations'] = translations;
      }

      if (jsonData.containsKey('states')) {
        List<dynamic> statesArray = jsonData['states'];
        List<Map<String, dynamic>> modifiedStatesArray = [];

        for (Map<String, dynamic> state in statesArray) {
          state.remove('id');
          state.remove('latitude');
          state.remove('longitude');
          modifiedStatesArray.add(state);
        }

        jsonData['states'] = modifiedStatesArray;
      }

      modifiedJsonArray.add(jsonData);
    }

    // Serialize the modified array back to a JSON string
    String modifiedJsonString = jsonEncode(modifiedJsonArray);

    // Print the modified JSON string to the console
    if (kDebugMode) {
      print(modifiedJsonString);
    }
  } catch (e) {
    if (kDebugMode) {
      print('An error occurred: $e');
    }
  }
}
