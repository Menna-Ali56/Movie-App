import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/bloc/detailes/details_event.dart';
import 'package:movie_app/bloc/detailes/details_state.dart';
import 'package:movie_app/ui/screens/home/apis/api_movie_details.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  DetailsBloc() : super(DetailsInitial()) {
    on<GetDetailsEvent>((event, emit) async {
      emit(state.copyWith(status: DetailsStatus.loading));
      try {
        final response = await ApiMovieDetails.getDetails(event.id, true);
        emit(state.copyWith(
            status: DetailsStatus.success, movieDetails: response));
      } catch (e) {
        emit(state.copyWith(
            status: DetailsStatus.error, errorMessage: e.toString()));
      }
    });
  }
}
