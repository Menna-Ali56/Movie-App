import 'package:dio/dio.dart';
import 'package:movie_app/models/movie_details_model.dart';
import 'package:movie_app/utils/app_constants.dart';

class ApiMovieDetails {
  static Dio dio = Dio(BaseOptions(baseUrl: AppConstants.BASE_URL));

  static Future<MovieDetailsModel> getDetails(int movieId) async {
    try {
      Response response = await dio.get('api/v2/movie_details.json',
          queryParameters: {'movie_id': movieId});

      MovieDetailsModel details = MovieDetailsModel.fromJson(response.data);
      return details;
    } catch (e, stackTrace) {
      print("API ERROR: $e");
      print("STACK TRACE: $stackTrace");
      throw Exception(e);
    }
  }
}
