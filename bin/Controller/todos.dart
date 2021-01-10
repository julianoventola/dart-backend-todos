import 'dart:io';
import 'dart:convert';

import 'package:shelf/shelf.dart';

final List data = json.decode(File('./todos.json').readAsStringSync());

class TodoApi {
  final _headers = {'Content-Type': 'application/json'};

  // GET - /todos
  Function index() {
    return (Request request) async {
      return Response.ok(
        jsonEncode(data),
        headers: _headers,
      );
    };
  }

  // GET - /todos/id
  Function show() {
    return (Request request, String id) async {
      final idTodo = int.tryParse(id);
      final todo =
          data.firstWhere((todo) => todo['id'] == idTodo, orElse: () => null);
      if (todo != null) {
        return Response.ok(json.encode(todo));
      }
      return Response.ok(
          json.encode({'error': true, 'msg': 'To-do $id not found'}));
    };
  }

  // POST - /todos
  Function create() {
    return (Request request) async {
      var body = await request.readAsString();
      Map newTodo = jsonDecode(body);
      data.add({'id': data.length + 1, ...newTodo});
      await File('./todos.json').writeAsString(json.encode(data));
      return Response(201, body: jsonEncode(data));
    };
  }

  // PUT - /todos/id
  Function update() {
    return (Request request, String id) async {
      final idTodo = int.tryParse(id);
      final todo =
          data.firstWhere((todo) => todo['id'] == idTodo, orElse: () => null);
      if (todo != null) {
        var body = await request.readAsString();
        Map updatedTodo = jsonDecode(body);
        todo['name'] = updatedTodo['name'];
        todo['done'] = updatedTodo['done'];
        await File('./todos.json').writeAsString(json.encode(data));
        return Response.ok(json.encode(data));
      }
      return Response.ok(
          json.encode({'error': true, 'msg': 'To-do $id not found'}));
    };
  }

  // DELETE - /todos/id
  Function delete() {
    return (Request request, String id) async {
      final idTodo = int.tryParse(id);
      final todo =
          data.firstWhere((todo) => todo['id'] == idTodo, orElse: () => null);
      if (todo != null) {
        data.remove(todo);
        await File('./todos.json').writeAsString(json.encode(data));
        return Response(204);
      }
      return Response.ok(
          json.encode({'error': true, 'msg': 'To-do $id not found'}));
    };
  }
}
