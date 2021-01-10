import 'package:shelf/shelf.dart';
import 'package:colorize/colorize.dart';

class ServerUtilities {
  Request request;
  Response response;

  ServerUtilities({this.request, this.response});

  static Map<String, String> getCorsConfig() {
    return {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
      'Access-Control-Allow-Headers': 'Origin, Content-Type',
    };
  }

  Colorize getRequestTime() {
    var dateTime = DateTime.now();
    var startTime = Colorize(dateTime.toString());
    startTime.yellow();
    return startTime;
  }

  Colorize getMethod() {
    var methodRequested = Colorize(request.method);
    switch (request.method) {
      case 'POST':
        methodRequested.blue();
        break;
      case 'PUT':
        methodRequested.yellow();
        break;
      case 'DELETE':
        methodRequested.red();
        break;
      default:
        methodRequested.green();
        break;
    }
    return methodRequested;
  }

  Colorize getStatusCode() {
    var responseCode = response.statusCode ?? 500;
    var responseCodeColored = Colorize(responseCode.toString());
    responseCodeColored.bold();
    if (responseCode >= 100 && responseCode < 200) {
      responseCodeColored.blue();
    } else if (responseCode >= 200 && responseCode < 300) {
      responseCodeColored.green();
    } else if (responseCode >= 300 && responseCode < 400) {
      responseCodeColored.lightBlue();
    } else if (responseCode >= 400 && responseCode < 500) {
      responseCodeColored.yellow();
    } else {
      responseCodeColored.red();
    }
    return responseCodeColored;
  }

  Colorize getUriRequested() {
    var uriRequested = Colorize(request.requestedUri.toString());
    uriRequested.italic();
    uriRequested.bold();
    return uriRequested;
  }

  // Loggin requests
  static void logger(Request request, Response response) {
    var serverUtils = ServerUtilities(request: request, response: response);
    var statusCode = serverUtils.getStatusCode();
    var methodRequested = serverUtils.getMethod();
    var startTime = serverUtils.getRequestTime();
    var uriRequested = serverUtils.getUriRequested();
    print(
        '''\nRequested: '$startTime' - [$methodRequested] $uriRequested\nResponse status code: $statusCode''');
  }
}
