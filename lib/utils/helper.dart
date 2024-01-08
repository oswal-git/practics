import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:practics/config/config.dart';
import 'package:timezone/data/latest.dart' as tzl;
import 'package:timezone/timezone.dart' as tz;

class EglHelper {
  static dynamic showMultChoiceDialog(
    List<Map<String, dynamic>> questions,
    String question, {
    required BuildContext context,
    required ValueChanged<String> onChanged,
  }) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("mSelectQuestion"),
        content: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: questions
                  .map(
                    (e) => InkWell(
                      onTap: () {
                        onChanged(e['option']);
                      },
                      child: Column(
                        children: [
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Icon(
                                        e['icon'],
                                        size: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 9,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10.0),
                                      child: Row(
                                        children: [
                                          Flexible(
                                            child: Text(
                                              e['texto'],
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 5,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }

  static DateTime obtenerFechaHoraActual() {
    // final now = DateTime.now();
    // Cargar la base de datos de zonas horarias
    tzl.initializeTimeZones();
    final now = tz.TZDateTime.now(tz.getLocation('Europe/Madrid'));
    final formatter = DateFormat('yyyy-MM-dd').add_Hms();
    return formatter.parse(formatter.format(now));
  }

  static dynamic eglLogger(String type, String message, {dynamic object = ''}) {
    final Logger logger = Logger();
    String resto = '';
    String fragmento = message;

    do {
      if (fragmento.length <= 950) {
        resto = '';
        fragmento = fragmento;
      } else {
        resto = fragmento.substring(950);
        fragmento = fragmento.substring(0, 950);
      }
      switch (type) {
        case 'i':
          object == '' ? logger.i('eglLogger(${obtenerFechaHoraActual()}): $fragmento') : logger.i('eglLogger: $fragmento, $object');
          break;
        case 'e':
          object == '' ? logger.e('eglLogger(${obtenerFechaHoraActual()}): $fragmento') : logger.e('eglLogger: $fragmento, $object');
          break;
        case 'd':
          object == '' ? logger.d('eglLogger(${obtenerFechaHoraActual()}): $fragmento') : logger.d('eglLogger: $fragmento, $object');
          break;
        case 'w':
          object == '' ? logger.w('eglLogger(${obtenerFechaHoraActual()}): $fragmento') : logger.w('eglLogger: $fragmento, $object');
          break;
        case 'v':
          object == '' ? logger.t('eglLogger(${obtenerFechaHoraActual()}): $fragmento') : logger.t('eglLogger: $fragmento, $object');
          break;
        default:
      }

      fragmento = resto;
      resto = '';
    } while (fragmento.isNotEmpty);
  }

  static String generateChain({int length = 8, String type = 'all'}) {
    String keyspace = '';

    switch (type) {
      case 'number':
        keyspace = EglKeysConfig.KEYSPACE_NUMBER;
        break;

      case 'letters':
        keyspace = EglKeysConfig.KEYSPACE_LETTERS;
        break;

      case 'all':
      default:
        keyspace = EglKeysConfig.KEYSPACE_ALL;
        break;
    }

    String str = '';
    int max = keyspace.length;
    Random rng = Random();
    if (max < 1) {
      eglLogger('e', 'keyspace must be at least two characters long');
      return '';
    }
    for (int i = 0; i < length; ++i) {
      str = '$str${keyspace[rng.nextInt(max)]}';
    }

    return str;
  }

  static String getNameFilePath(String path, {String fileSeparator = '/', String extSeparator = '.'}) => path.substring(
      path.lastIndexOf(fileSeparator) == -1 ? 0 : path.lastIndexOf(fileSeparator) + 1,
      path.lastIndexOf(extSeparator) == -1 ? path.length : path.lastIndexOf(extSeparator));

  static String getExtFilePath(String path, {String extSeparator = '.'}) =>
      path.substring(path.lastIndexOf(extSeparator) == -1 ? path.length : path.lastIndexOf(extSeparator) + 1, path.length);
//
}
