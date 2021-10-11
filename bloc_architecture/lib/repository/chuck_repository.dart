import 'dart:async';

import 'package:bloc_architecture/models/chuck_response.dart';
import 'package:bloc_architecture/networking/ApiProvider.dart';

class ChuckRepository {
  ApiProvider _provider = ApiProvider();

  Future<chuckResponse> fetchChuckJoke(String category) async {
    final response = await _provider.get("jokes/random?category=" + category);
    return chuckResponse.fromJson(response);
  }
}
