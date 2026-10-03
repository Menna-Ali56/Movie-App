import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/bloc/suggection/suggection_event.dart';
import 'package:movie_app/bloc/suggection/suggection_state.dart';
import 'package:movie_app/ui/screens/home/apis/api_movie_suggestion.dart';

class SuggectionBlock extends Bloc<SuggectionEvent, SuggectionState> {
  SuggectionBlock() : super(SuggectionInitial()) {
    on<GetSuggectionEvent>((event, emit) async {
      emit(state.copyWith(status: SuggectionStatus.loading));
      try {
        final response = await ApiMovieSuggestion.getApi(event.movieId);
        emit(state.copyWith(
            status: SuggectionStatus.success, movieSuggectionModel: response));
      } catch (e) {
        emit(state.copyWith(
            status: SuggectionStatus.error, errorMessage: e.toString()));
      }
    });
  }
}
