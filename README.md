# Backend - To-do's app

- Backend made completely in dart, still under construction

# Routes

- [GET] "/" : Welcome message

- [GET] "/todos" : Get all to-dos from 'todos.json' file
- [GET] "/todos/id" : Find one to-do from 'todos.json' list
- [POST] "/todos" : Create a new to-do in 'todos.json' file
- [PUT] "/todos/id" : Update a to-do in 'todos.json' file
- [DELETE] "/todos" : Delete a to-do in 'todos.json' file

- [GET] "/\*" : 404 route not found message

# Utilities

- Logger for each request
- 'pre-configured' CORS

# Note

- You can run this backend everytime in one click if you use "dart complile exe bin\main.dart" (put your file in the same directory of exe file)
  - - Still need dart installed
