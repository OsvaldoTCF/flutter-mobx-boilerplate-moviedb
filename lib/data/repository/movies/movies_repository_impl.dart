import 'package:flutter/foundation.dart';
// ignore: depend_on_referenced_packages
import 'package:injectable/injectable.dart';
import 'package:mobx_example/core/dio/exception/exception_types.dart';
import 'package:mobx_example/core/dio/exception/exception_utils.dart';
import 'package:mobx_example/data/data_sources/remote/apis/movies/movie_api.dart';

import 'package:mobx_example/domain/entities/movie/upcoming_movies.dart';
import 'package:mobx_example/domain/repository_interfaces/movies/movies_repository.dart';
import 'package:mobx_example/domain/usecases/movies/get_upcoming_movies.dart';

@Singleton(as: MoviesRepository)
class MoviesRepositoryImpl implements MoviesRepository {
  final MovieApi _movieApi;
  // final PostLocalDatasource _postLocalDatasource;

  String TAG = 'MoviesRepositoryImpl';

  // constructor
  MoviesRepositoryImpl(
    this._movieApi,
    // this._postLocalDatasource,
  );

  @override
  Future<UpComingMovies?> getUpcomingMovies(UpComingMoviesParams params) async {
    try {
      final response = await _movieApi.getUpComingMovies(params);
      // await _postLocalDatasource.savePosts(postsList);  // TODO for local caching
      return response;
    } on ExceptionUtils catch (e) {
      // If No network then get data from Database
      if (e.type == ExceptionType.NETWORK) {
        debugPrint('$TAG No internet Fetching response from Database');
        // return await _postLocalDatasource.fetchPosts(); // TODO for local caching
        rethrow;
      } else {
        rethrow;
      }
    } catch (e) {
      debugPrint('$e');
      rethrow;
    }
  }
}
