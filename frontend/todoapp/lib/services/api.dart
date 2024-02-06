// api_service.dart

import 'dart:async';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

/// A class that provides methods for making HTTP requests to a TODO API.
class ApiService {
  final http.Client httpClient = http.Client();

  /// Custom headers for HTTP requests.
  Map<String, String> customHeaders = {
    "Accept": "application/json",
    "Content-Type": "application/json;charset=UTF-8"
  };

  /// Endpoint for fetching TODO_Data.
  final String fetchDataEndpoint = dotenv.env['FETCHDATA_ENDPOINT']!;

  /// Endpoint for adding new TODO_Data.
  final String addDataEndpoint = dotenv.env['ADDDATA_ENDPOINT']!;

  /// Endpoint for deleting TODO_Data.
  final String deleteDataEndpoint = dotenv.env['DELETEDATA_ENDPOINT']!;

  /// Endpoint for updating existing TODO_Data.
  final String updateDataEndpoint = dotenv.env['UPDATEDATA_ENDPOINT']!;

  /// Fetches TODO_Data from the API.
  Future<http.Response> fetchData() async {
    final Uri restAPIURL = Uri.parse(fetchDataEndpoint);
    return httpClient.get(restAPIURL);
  }

  /// Adds new TODO_Data through a POST request.
  Future<http.Response> addData(Map body) async {
    final Uri restAPIURL = Uri.parse(addDataEndpoint);
    return httpClient.post(
      restAPIURL,
      headers: customHeaders,
      body: jsonEncode(body),
    );
  }

  /// Deletes TODO_Data using a DELETE request.
  Future<http.Response> deleteData(String id) async {
    final Uri restAPIURL = Uri.parse(deleteDataEndpoint);
    return httpClient.delete(
      restAPIURL,
      headers: customHeaders,
      body: jsonEncode({"_id": id}),
    );
  }

  /// Updates existing TODO_Data with a PUT request.
  Future<http.Response> updateData(Map<String, String> data) async {
    final Uri restAPIURL = Uri.parse(updateDataEndpoint);
    return httpClient.put(
      restAPIURL,
      headers: customHeaders,
      body: jsonEncode(data),
    );
  }
}
