import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';

class CustomLoggingInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    print("┌────── Request ───────────────────────────");
    print("│ URL: ${options.uri}");
    print("│");
    print("│ Method: ${options.method}");
    print("│");
    print("|  HEADER:");
    options.headers.forEach((key, value) {
      print("|  $key: $value");
    });
    print("│");

    if (options.data != null) {
      if (options.data is FormData) {
        print("│ Body: FormData");
        FormData formData = options.data as FormData;
        formData.fields.forEach((element) {
          print("|  ${element.key}: ${element.value}");
        });
        formData.files.forEach((element) {
          print("|  ${element.key}: ${element.value.filename}");
        });
      } else if (options.data is Stream<List<int>>) {
        print("│ Body: Stream");
        // Convert the stream to a Uint8List
        Uint8List bodyBytes = await (options.data as Stream<List<int>>)
            .reduce((a, b) => a..addAll(b))
            .then((list) => Uint8List.fromList(list));
        print("│ ${utf8.decode(bodyBytes)}");
      } else {
        print("│ Body:");
        print("│ ${options.data}");
      }
    }

    print("└────────────────────────────────────");
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print("┌────── Response ─────────────────────────");
    print("│ Status Code: ${response.statusCode}");
    print("│");
    print("│ Headers:");
    response.headers.forEach((key, value) {
      print("│ $key: ${value.join(', ')}");
    });
    print("│");
    print("│ Body:");
    print("│ ${response.data}");
    print("└────────────────────────────────────");
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print("┌────── Error ───────────────────────────");
    print("│ Message: ${err.message}");
    if (err.response != null) {
      print("│ Status Code: ${err.response?.statusCode}");
      print("│");
      print("│ Headers:");
      err.response?.headers.forEach((key, value) {
        print("│ $key: ${value.join(', ')}");
      });
      print("│");
      print("│ Body:");
      print("│ ${err.response?.data}");
    }
    print("└────────────────────────────────────");
    return super.onError(err, handler);
  }
}
