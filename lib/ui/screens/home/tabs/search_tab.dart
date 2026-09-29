import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/utils/app_assets.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'package:movie_app/utils/size_utils.dart';

import '../../../../bloc/search/search_bloc.dart';
import '../../../../bloc/search/search_event.dart';
import '../../../../bloc/search/search_state.dart';
import '../../../../l10n/app_localizations.dart';
import '../widgets/movie_card.dart';

class SearchTab extends StatelessWidget {
  const SearchTab({super.key});

  @override
  Widget build(BuildContext context) {

    final localizations = AppLocalizations.of(context)!;
    return SafeArea(
      child: BlocProvider(
        create: (context) => SearchBloc()..add(GetMoviesEvent()),
        child: Builder(
          builder: (context) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: AppColors.black2,
              body: SizedBox(
                height: SizeConfig.height(context),
                width: SizeConfig.width(context),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        onChanged: (value) {
                          context.read<SearchBloc>().add(
                            SearchMovieEvent(value),
                          );
                        },
                        style: TextStyle(
                          color: AppColors.yellow,
                        ),
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(
                              top: 10,
                              left: 10,
                              bottom: 10,
                            ),
                            child: Image.asset(
                              AppAssets.searchTab,
                            ),
                          ),
                          fillColor: AppColors.darkGray,
                          filled: true,
                          hintText: localizations.search,
                          hintStyle: TextStyle(
                            color: AppColors.white,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 10,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ),

                    Expanded(
                      child: BlocBuilder<SearchBloc, SearchState>(
                        builder: (context, state) {
                          if (state is SearchLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (state is SearchError) {
                            return Center(
                              child: Text(
                                state.message,
                                style: TextStyle(
                                  color: AppColors.white,
                                ),
                              ),
                            );
                          }

                          if (state is SearchSuccess) {
                            if (state.movies.isEmpty) {
                              return Center(
                                child: Text(
                                  'No movies found',
                                  style: TextStyle(
                                    color: AppColors.white,
                                  ),
                                ),
                              );
                            }

                            return GridView.builder(
                              padding: const EdgeInsets.all(10),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 15,
                                childAspectRatio: 0.65,
                              ),
                              itemCount: state.movies.length,
                              itemBuilder: (context, index) {
                                final movie = state.movies[index];


                                return MovieCard(
                                  movie: movie,
                                );
                              },
                            );
                          }

                          return Center(
                            child: Image.asset(
                              AppAssets.emtySearch,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}