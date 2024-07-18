import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:project/ServerData/model.dart';

class Repository {
  String uri = 'https://65b8258e46324d531d5600db.mockapi.io/Users';
  String errorMessage = ''; // Variable to hold the error message
  Future<List<User>> getData({String? searchQuery}) async {
    try {
      final response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        Iterable it = jsonDecode(response.body);
        List<User> user = it.map((e) => User.fromJson(e)).toList();
        return user;
      } else {
        throw Exception('Failed to Load Data');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }

  Future<bool> createData(
    int id,
    String name,
    Address address,
    String imageUrl,
    String date,
    String time,
    String similarity, // Added similarity parameter
  ) async {
    try {
      final response = await http.post(
        Uri.parse(uri),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'id': id.toString(),
          'name': name,
          'address': {
            'street': address.street,
            'city': address.city,
            'geo': {
              'lat': address.geo.lat,
              'lng': address.geo.lng,
            },
          },
          'imageurl': imageUrl,
          'date': date,
          'time': time,
          'similarity': similarity, // Include similarity in the request body
        }),
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        if (responseBody.containsKey('id') && responseBody['id'] != null) {
          int createdId = int.parse(responseBody['id']);
          print('Created User ID: $createdId');
          return true;
        } else {
          errorMessage = 'Failed to create data: ID not found in response';
          return false;
        }
      } else {
        errorMessage =
            'Failed to create data: Server returned status code ${response.statusCode}';
        return false;
      }
    } catch (e) {
      errorMessage = 'Failed to create data: $e';
      print('Error in createData: $e');
      return false;
    }
  }

  Future<bool> UpdatePage(
    String id,
    String name,
    Address address,
    String date,
    String time,
    String similarity, // Added similarity parameter
  ) async {
    try {
      final response = await http.put(
        Uri.parse('$uri/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'address': {
            'city': address.city,
            'street': address.street,
            'geo': {
              'lat': address.geo.lat,
              'lng': address.geo.lng,
            },
          },
          'date': date,
          'time': time,
          'similarity': similarity, // Include similarity in the request body
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print(
            'Failed to update data. Server returned status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error in UpdatePage: $e');
      return false;
    }
  }

  Future deleteData(dynamic id) async {
    try {
      final response = await http.delete(Uri.parse('$uri/$id'));
      if (response.statusCode == 200) {
        return true;
      } else {
        print(
            'Failed to delete data. Server returned status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error in deleteData: $e');
      return false;
    }
  }
}
