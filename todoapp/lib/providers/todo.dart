import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todoapp/services/api.dart';

// todo_provider.dart

class TodoProvider extends ChangeNotifier {
  final ApiService apiService = ApiService();

  List<dynamic> todoData = [];

  Future<void> fetchData() async {
    final http.Response response = await apiService.fetchData();
    final Map parsedData = jsonDecode(response.body.toString());
    todoData = parsedData['data'];
    notifyListeners();
  }

  Future addData(Map body) async {
    final http.Response response = await apiService.addData(body);
    notifyListeners();
    return response.body;
  }

  Future deleteData(String id) async {
    final http.Response response = await apiService.deleteData(id);
    notifyListeners();
    return response.body;
  }

  Future updateData(Map<String, String> data) async {
    final http.Response response = await apiService.updateData(data);
    notifyListeners();
    return response.body;
  }
}

  // /// Provider class for managing TODO data.
  // class TodoProvider extends ChangeNotifier {
  //   final httpClient = http.Client();

  //   /// List to store TODO data.
  //   List<dynamic> todoData = [];

  //   /// Custom headers for HTTP requests.
  //   Map<String, String> customHeaders = {
  //     "Accept": "application/json",
  //     "Content-Type": "application/json;charset=UTF-8"
  //   };

  //   /// Endpoints for different CRUD operations.
  //   final String _fetchDataEndPoint = dotenv.env['FETCHDATA_ENDPOINT']!;
  //   final String _addDataEndPoint = dotenv.env['ADDDATA_ENDPOINT']!;
  //   final String _deleteDataEndPoint = dotenv.env['DELETEDATA_ENDPOINT']!;
  //   final String _updateDataEndPoint = dotenv.env['UPDATEDATA_ENDPOINT']!;

  //   /// Performs a GET request to fetch TODO data from a REST API.
  //   Future<void> fetchData() async {
  //     // Define the REST API URL
  //     final Uri restAPIURL = Uri.parse(_fetchDataEndPoint);

  //     // Send the GET request to the REST API
  //     http.Response response = await httpClient.get(restAPIURL);

  //     // Decode the response body from JSON to a map
  //     final Map parsedData = await jsonDecode(response.body.toString());

  //     // Assign the 'data' list from the parsed data to TODO data
  //     todoData = parsedData['data'];

  //     // Notify listeners about the updated data
  //     notifyListeners();

  //     // Print the fetched TODO data to the console
  //     // print(todoData);
  //   }

  //   /// Performs a POST request to add TODO data.
  //   Future addData(Map body) async {
  //     // Define the REST API URL
  //     final Uri restAPIURL = Uri.parse(_addDataEndPoint);

  //     // Send the POST request to the REST API
  //     http.Response response = await httpClient.post(
  //       restAPIURL,
  //       headers: customHeaders,
  //       body: jsonEncode(body),
  //     );

  //     // Notify listeners about the updated data
  //     notifyListeners();

  //     // Return the response body
  //     return response.body;
  //   }

  //   /// Performs a DELETE request to remove TODO data.
  //   Future deleteData(String id) async {
  //     // Define the REST API URL
  //     final Uri restAPIURL = Uri.parse(_deleteDataEndPoint);

  //     // Send the DELETE request to the REST API
  //     http.Response response = await httpClient.delete(
  //       restAPIURL,
  //       headers: customHeaders,
  //       body: jsonEncode({"_id": id}),
  //     );

  //     // Notify listeners about the updated data
  //     notifyListeners();

  //     // Return the response body
  //     return response.body;
  //   }

  //   /// Performs a PUT request to update TODO data.
  //   Future updateData(Map<String, String> data) async {
  //     // Define the REST API URL
  //     final Uri restAPIURL = Uri.parse(_updateDataEndPoint);

  //     // Send the PUT request to the REST API
  //     http.Response response = await httpClient.put(
  //       restAPIURL,
  //       headers: customHeaders,
  //       body: jsonEncode(data),
  //     );

  //     // Notify listeners about the updated data
  //     notifyListeners();

  //     // Return the response body
  //     return response.body;
  //   }
  // }
