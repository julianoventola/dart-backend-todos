import 'package:shelf/shelf.dart';
import 'dart:convert';

class GenericRouterHandler {
  // GET - /
  Function start() {
    return (Request request) async {
      return Response.ok(
        jsonEncode({'message': 'Welcome!'}),
        headers: {'Content-Type': 'application/json'},
      );
    };
  }

  // GET - /anything
  Function index() {
    return (Request request) async {
      return Response.notFound(
        jsonEncode({'error': true, 'message': 'route not found'}),
        headers: {'Content-Type': 'application/json'},
      );
    };
  }
}
