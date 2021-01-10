import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;

import 'Routes/router.dart';
import 'Utils/server_utils.dart';

void main() async {
  // Initiate server
  const port = 8081;
  const host = 'localhost';

  // Routes config
  final app = RouteControl().router;

  // CORS and Json Settings
  var corsHeaders = ServerUtilities.getCorsConfig();

  // Set CORS headers with every request and a logger
  final handler = Pipeline().addMiddleware((innerHandler) {
    return (request) async {
      final response = await innerHandler(request);

      // Logger for routes
      ServerUtilities.logger(request, response);

      // Set CORS when responding to OPTIONS request
      if (request.method == 'OPTIONS') {
        return Response.ok('', headers: corsHeaders);
      }

      // Move onto handler
      return response;
    };
  }).addHandler(app);

  await io.serve(handler, host, port);

  print('Server running on http://$host:$port');
}
