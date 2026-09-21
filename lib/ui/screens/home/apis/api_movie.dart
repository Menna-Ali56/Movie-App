import 'package:dio/dio.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/utils/app_constants.dart';

class ApiMovie {
  static Dio dio = Dio(BaseOptions(baseUrl: AppConstants.BASE_URL));

  static Future<MovieModel> getMovie() async {
    try {
      Response response = await dio.get('/api/v2/list_movies.json',
          queryParameters: {'Accept-Encoding': 'Accept-Encoding: '});

      MovieModel movies = MovieModel.fromJson(response.data);
      return movies;
    } catch (e) {
      print(e.toString());
      throw Exception();
    }
  }
}
