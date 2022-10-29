import 'package:dio/dio.dart';
import 'package:tanlants_valley_application/data/controller/auth_controller.dart';
import 'package:tanlants_valley_application/router/router.dart';
import 'package:provider/provider.dart';
import '../dio_exception.dart';

class ErrorInterceptor extends Interceptor {
  var provider = Provider.of<AuthController>(
      AppRouter.navigationKey.currentContext!,
      listen: false);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    provider.cnacelResendLoading ? null : provider.startLoading();
    provider.addErrorMessage("");
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    provider.endLoading();

    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    provider.endLoading();
    provider.addErrorMessage(DioExceptions.fromDioError(err));
    DioExceptions.showMessage(err);
    // super.onError(err, handler);
  }
}
