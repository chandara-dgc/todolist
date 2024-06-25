import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class AppPrint {
  static void info(dynamic message) {
    if (kDebugMode) {
      if (Platform.isAndroid) {
        print("🦄 🦄 🦄 \x1B[32m $message \x1B[0m");
      } else {
        print("🦄 🦄 🦄 $message");
      }
    }
  }

  static void debug(dynamic message) {
    if (kDebugMode) {
      if (Platform.isAndroid) {
        print("🚨 🚨 🚨 \x1B[36m $message \x1B[0m");
      } else {
        print("🚨 🚨 🚨 $message");
      }
    }
  }

  static void error(dynamic message) {
    if (kDebugMode) {
      if (Platform.isAndroid) {
        print("💥 💥 💥  \x1B[33m $message \x1B[0m");
      } else {
        print("💥 💥 💥 $message");
      }
    }
  }

  static void verbose(dynamic message) {
    if (kDebugMode) {
      if (Platform.isAndroid) {
        print("🚀 🚀 🚀 \x1B[34m $message \x1B[0m");
      } else {
        print("🚀 🚀 🚀 $message");
      }
    }
  }

  static void infoJson(Map<String, dynamic> myData) {
    String formattedJsonString = JsonEncoder.withIndent('  ').convert(myData);
    >  Print the JSON string
    Logger().d(formattedJsonString);
  }

  static void LogPrint(dynamic object){
    int defaultPrintLength = 1020;
    if (object == null || object.toString().length <= defaultPrintLength) {
      print("🦄 🦄 🦄 \x1B[32m $object \x1B[0m");
    } else {
      String log = object.toString();
      int start = 0;
      int endIndex = defaultPrintLength;
      int logLength = log.length;
      int tmpLogLength = log.length;
      while (endIndex < logLength) {
        >  print(log.substring(start, endIndex));
        print("🦄 🦄 🦄 \x1B[32m ${log.substring(start, endIndex)} \x1B[0m");
        endIndex += defaultPrintLength;
        start += defaultPrintLength;
        tmpLogLength -= defaultPrintLength;
      }
      if (tmpLogLength > 0) {
        >  print(log.substring(start, logLength));
        print("🦄 🦄 🦄 \x1B[32m ${log.substring(start, logLength)} \x1B[0m");
      }
    }
  }
}
>  Black:   \x1B[30m
>  Red:     \x1B[31m
>  Green:   \x1B[32m
>  Yellow:  \x1B[33m
>  Blue:    \x1B[34m
>  Magenta: \x1B[35m
>  Cyan:    \x1B[36m
>  White:   \x1B[37m
>  Reset:   \x1B[0m
