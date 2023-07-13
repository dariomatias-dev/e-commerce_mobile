import "package:flutter_dotenv/flutter_dotenv.dart";
import "package:http/http.dart" as http;
import "dart:convert";

class APIServices {
  Future<String> fetchData(String path) async {
    String url = "${dotenv.env["API_URL"]}/$path";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception(
        "Failed fetch data. Status code ${response.statusCode}",
      );
    }
  }

  Future<void> createData(String path, Map<String, dynamic> body) async {
    String url = "${dotenv.env["API_URL"]}/$path";

    final response = await http.post(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json"
      },
      body: jsonEncode(body),
    );

    handleResponseError(
      response,
      "Failed create data. Status code ${response.statusCode}",
    );
  }

  Future<void> updateData(String path, Map<String, dynamic> body) async {
    String url = "${dotenv.env["API_URL"]}/$path";
    final response = await http.patch(
      Uri.parse(url),
      body: body,
    );

    handleResponseError(
      response,
      "Failed update data. Status code ${response.statusCode}",
    );
  }

  Future<void> deleteData(String path) async {
    String url = "${dotenv.env["API_URL"]}/$path";
    final response = await http.delete(Uri.parse(url));

    handleResponseError(
      response,
      "Failed delete data. Status code ${response.statusCode}",
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
