import "package:flutter_dotenv/flutter_dotenv.dart";
import "package:http/http.dart" as http;
import "dart:convert";

class APIServices {
  Future<String> get(String path) async {
    String url = "${dotenv.env["API_URL"]}/$path";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception(
        "Error getting data. Status code ${response.statusCode}",
      );
    }
  }

  Future<void> post(String path, Map<String, dynamic> body) async {
    String url = "${dotenv.env["API_URL"]}/$path";

    final response = await http.post(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(body),
    );

    handleResponseError(
      response,
      "Error creating a new resource. Status code ${response.statusCode}",
    );
  }

  Future<void> patch(String path, Map<String, dynamic> body) async {
    String url = "${dotenv.env["API_URL"]}/$path";
    final response = await http.patch(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(body),
    );

    handleResponseError(
      response,
      "Error partially updating the data. Status code ${response.statusCode}",
    );
  }

  Future<void> put(String path, Map<String, dynamic> body) async {
    String url = "${dotenv.env["API_URL"]}/$path";

    final response = await http.put(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(body),
    );

    handleResponseError(
      response,
      "Error when completely updating the data. Status code ${response.statusCode}",
    );
  }

  Future<void> delete(String path) async {
    String url = "${dotenv.env["API_URL"]}/$path";
    final response = await http.delete(Uri.parse(url));

    handleResponseError(
      response,
      "Error deleting data. Status code ${response.statusCode}",
    );
  }

  void handleResponseError(
    http.Response response,
    String errorMessage,
  ) {
    if (response.statusCode != 200) {
      throw Exception(errorMessage);
    }
  }
}
