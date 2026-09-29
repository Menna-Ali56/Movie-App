import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/ui/screens/home/widgets/movie_card.dart';
import 'package:movie_app/utils/app_colors.dart';

import '../../../../bloc/browse/browse_bloc.dart';
import '../../../../bloc/browse/browse_event.dart';
import '../../../../bloc/browse/browse_state.dart';

class BrowseTab extends StatelessWidget {
  const BrowseTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => BrowseBloc()..add(GetBrowseMoviesEvent()),
        child: Builder(
          builder: (context) {
            return Scaffold(
              backgroundColor: AppColors.black2,
              body: BlocBuilder<BrowseBloc, BrowseState>(
                builder: (context, state) {
                  // Loading
                  if (state is BrowseLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.amber,
                      ),
                    );
                  }

                  // Error
                  if (state is BrowseError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );
                  }

                  // Success
                  if (state is BrowseSuccess) {
                    return Column(
                      children: [
                        // Genres
                        SizedBox(
                          height: 55,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            itemCount: state.genres.length,
                            itemBuilder: (context, index) {
                              final genre = state.genres[index];

                              final isSelected =
                                  genre == state.selectedGenre;

                              return GestureDetector(
                                onTap: () {
                                  context.read<BrowseBloc>().add(
                                    SelectGenreEvent(genre),
                                  );
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(
                                    right: 10,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? AppColors.yellow
                                        : Colors.transparent,
                                    border: Border.all(
                                      color: AppColors.yellow,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Center(
                                    child: Text(
                                      genre,
                                      style: TextStyle(
                                        color: isSelected
                                            ? AppColors.black
                                            : AppColors.yellow,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: 15),

                        // Movies
                        Expanded(
                          child: Builder(
                            builder: (context) {
                              final filteredMovies = state.movies.where(
                                    (movie) {
                                  return movie.genres?.contains(
                                    state.selectedGenre,
                                  ) ??
                                      false;
                                },
                              ).toList();

                              return GridView.builder(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.7,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 12,
                                ),
                                itemCount: filteredMovies.length,
                                itemBuilder: (context, index) {
                                  return MovieCard(
                                    movie: filteredMovies[index],
                                  );
                                },
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: 10),
                      ],
                    );
                  }

                  return const SizedBox();
                },
              ),
            );
          },
        ),
      ),
    );
  }
}