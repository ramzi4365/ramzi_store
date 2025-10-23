import 'dart:async';
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:ramzi_store/core/class/statusRequest.dart';

import '../functions/checkInternet.dart';


class Crud {
  Future<Either<StatusRequest, Map>> postData(String linkurl, Map data) async {
    try {
      if (await checkInternet()) {
        var response = await http.post(
          Uri.parse(linkurl),
          body: data,
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        ).timeout(const Duration(seconds: 30));

        print("HTTP Status Code: ${response.statusCode}");
        print("HTTP Response Body: ${response.body}");

        // Handle all successful responses (200-299)
        if (response.statusCode >= 200 && response.statusCode < 300) {
          try {
            Map responseBody = jsonDecode(response.body);
            return Right(responseBody);
          } catch (e) {
            print("JSON Decode Error: $e");
            return const Left(StatusRequest.serverException);
          }
        }
        // Handle client errors (400-499) - these should still return the JSON response
        else if (response.statusCode >= 400 && response.statusCode < 500) {
          try {
            Map responseBody = jsonDecode(response.body);
            return Right(responseBody); // Return as Right to access the error message
          } catch (e) {
            return const Left(StatusRequest.serverfailure);
          }
        }
        // Handle server errors (500-599)
        else {
          return const Left(StatusRequest.serverfailure);
        }
      } else {
        return const Left(StatusRequest.offlinefailure);
      }
    } catch (e) {
      print("Request Error: $e");
      return const Left(StatusRequest.serverException);
    }
  }
}
