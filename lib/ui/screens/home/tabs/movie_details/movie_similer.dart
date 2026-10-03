import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/bloc/suggection/suggection_block.dart';
import 'package:movie_app/bloc/suggection/suggection_event.dart';
import 'package:movie_app/bloc/suggection/suggection_state.dart';
import 'package:movie_app/ui/screens/home/widgets/movie_card.dart';
import 'package:movie_app/ui/screens/home/size_config.dart';

class MovieSimiler extends StatelessWidget {
  final int movieId;
  MovieSimiler({
    super.key,
    required this.movieId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            SuggectionBlock()..add(GetSuggectionEvent(movieId: movieId)),
        child: BlocBuilder<SuggectionBlock, SuggectionState>(
            builder: (context, state) {
          if (state.status == SuggectionStatus.loading) {
            return Center(
                child: CircularProgressIndicator(
              color: Colors.yellow,
            ));
          }
          if (state.status == SuggectionStatus.error) {
            return Center(
              child: Text(
                "Something went wrong",
                style: TextStyle(color: Colors.white),
              ),
            );
          }
          final movieList = state.movieSuggection?.data?.movies ?? [];
          if (movieList.isEmpty) {
            return Center(
              child: Text(
                "No similar movies found",
                style: TextStyle(color: Colors.white),
              ),
            );
          }
          return Container(
              width: SizeConfig.w(context, 170),
              child: MovieCard(
                movie: movieList[0],
              ));
        }));
  }
}
