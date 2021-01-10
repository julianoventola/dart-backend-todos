import 'package:shelf_router/shelf_router.dart';

import '../Controller/generic.dart';
import '../Controller/todos.dart';

class RouteControl {
  Router get router {
    final router = Router();

    router.get('/', GenericRouterHandler().start());

    router.get('/todos', TodoApi().index());
    router.get('/todos/<id>', TodoApi().show());
    router.post('/todos', TodoApi().create());
    router.put('/todos/<id>', TodoApi().update());
    router.delete('/todos/<id>', TodoApi().delete());

    // Not found route
    router.get('/<.*>', GenericRouterHandler().index());

    return router;
  }
}
