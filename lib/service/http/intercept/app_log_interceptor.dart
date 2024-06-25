import 'dart:convert';
import 'dart:typed_data';
import 'package:check_list_app/utils/app_print/app_print.dart';
import 'package:dio/dio.dart';

class CustomLoggingInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    AppPrint.info("┌────── Request ───────────────────────────");
    AppPrint.info("│ URL: ${options.uri}");
    AppPrint.info("│");
    AppPrint.info("│ Method: ${options.method}");
    AppPrint.info("│");
    AppPrint.info("|  HEADER:");
    options.headers.forEach((key, value) {
      AppPrint.info("|  $key: $value");
    });
    AppPrint.info("│");

    if (options.data != null) {
      if (options.data is FormData) {
        AppPrint.info("│ Body: FormData");
        FormData formData = options.data as FormData;
        formData.fields.forEach((element) {
          AppPrint.info("|  ${element.key}: ${element.value}");
        });
        formData.files.forEach((element) {
          AppPrint.info("|  ${element.key}: ${element.value.filename}");
        });
      } else if (options.data is Stream<List<int>>) {
        AppPrint.info("│ Body: Stream");
        // Convert the stream to a Uint8List
        Uint8List bodyBytes = await (options.data as Stream<List<int>>)
            .reduce((a, b) => a..addAll(b))
            .then((list) => Uint8List.fromList(list));
        AppPrint.info("│ ${utf8.decode(bodyBytes)}");
      } else {
        AppPrint.info("│ Body:");
        AppPrint.info("│ ${options.data}");
      }
    }

    AppPrint.info("└────────────────────────────────────");
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    AppPrint.info("┌────── Response ─────────────────────────");
    AppPrint.info("│ Status Code: ${response.statusCode}");
    AppPrint.info("│");
    AppPrint.info("│ Headers:");
    response.headers.forEach((key, value) {
      AppPrint.info("│ $key: ${value.join(', ')}");
    });
    AppPrint.info("│");
    AppPrint.info("│ Body:");
    AppPrint.info("│ ${response.data}");
    AppPrint.info("└────────────────────────────────────");
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    AppPrint.error("┌────── Error ───────────────────────────");
    AppPrint.error("│ Message: ${err.message}");
    if (err.response != null) {
      AppPrint.error("│ Status Code: ${err.response?.statusCode}");
      AppPrint.error("│");
      AppPrint.error("│ Headers:");
      err.response?.headers.forEach((key, value) {
        AppPrint.error("│ $key: ${value.join(', ')}");
      });
      AppPrint.error("│");
      AppPrint.error("│ Body:");
      AppPrint.error("│ ${err.response?.data}");
    }
    AppPrint.error("└────────────────────────────────────");
    return super.onError(err, handler);
  }
}
