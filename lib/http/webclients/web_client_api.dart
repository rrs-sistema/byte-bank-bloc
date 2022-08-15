import 'package:http_interceptor/http_interceptor.dart';
import 'package:http/http.dart';

import '../interceptors/interceptors.dart';

final Client client = HttpClientWithInterceptor.build(
  interceptors: [LoggingInterceptor()],
  requestTimeout: Duration(seconds: 5),
);

const String baseUrl = 'http://192.168.5.111:8080/transactions';


