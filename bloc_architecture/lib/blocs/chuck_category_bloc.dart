import 'dart:async';

import 'package:bloc_architecture/models/chuck_categories.dart';
import 'package:bloc_architecture/networking/Repsonse.dart';
import 'package:bloc_architecture/repository/chuck_category_repository.dart';


class ChuckCategoryBloc {
  ChuckCategoryRepository _chuckRepository;
  StreamController _chuckListController;

  StreamSink<Response<chuckCategories>> get chuckListSink =>
      _chuckListController.sink;

  Stream<Response<chuckCategories>> get chuckListStream =>
      _chuckListController.stream;

  ChuckCategoryBloc() {
    _chuckListController = StreamController<Response<chuckCategories>>();
    _chuckRepository = ChuckCategoryRepository();
    fetchCategories();
  }

  fetchCategories() async {
    chuckListSink.add(Response.loading('Getting Chuck Categories.'));
    try {
      chuckCategories chuckCats =
          await _chuckRepository.fetchChuckCategoryData();
      chuckListSink.add(Response.completed(chuckCats));
    } catch (e) {
      chuckListSink.add(Response.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _chuckListController?.close();
  }
}
