import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/ui/screens/home/apis/api_movie.dart';
import 'package:movie_app/ui/screens/home/widgets/movie_card.dart';
import 'package:movie_app/utils/app_colors.dart';

class BrowseTab extends StatefulWidget {
  const BrowseTab({super.key});

  @override
  State<BrowseTab> createState() => _BrowseTabState();
}

class _BrowseTabState extends State<BrowseTab> {
  late Future<dynamic> genre;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    genre = ApiMovie.getMovie();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColors.black2,
          body: FutureBuilder(
              future: genre,
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.amber,
                    ),
                  );
                }
                if (snap.hasError) {
                  return const Center(
                    child: Text(
                      "Something went wrong",
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }
                if (snap.data?.status != 'ok') {
                  return Center(
                    child: Text(
                      snap.data?.statusMessage ?? "",
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }
                List<Movies> movieList = snap.data!.data!.movies!;
                List<String> allGenre = movieList
                    .where((movie) => movie.genres != null)
                    .expand((movie) => (movie.genres ?? []).cast<String>())
                    .toSet()
                    .toList();

                return SizedBox(
                    child: DefaultTabController(
                  length: allGenre.length,
                  child: Column(
                    children: [
                      TabBar(
                        isScrollable: true,
                        indicatorSize: TabBarIndicatorSize.tab,
                        tabAlignment: TabAlignment.start,
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: AppColors.yellow,
                        ),
                        unselectedLabelColor: AppColors.yellow,
                        labelColor: AppColors.black,
                        dividerColor: AppColors.transparentColor,
                        tabs: allGenre.map((genre) {
                          return Tab(
                              child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 2, color: AppColors.yellow),
                                borderRadius: BorderRadius.circular(16)),
                            child: Text(
                              genre,
                            ),
                          ));
                        }).toList(),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: TabBarView(
                          children: allGenre
                              .map(
                                (genreName) {
                                  List<Movies> filtterMoviw = movieList
                                      .where((e) =>
                                          e.genres?.contains(genreName) ??
                                          false)
                                      .toList();

                                  return GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            childAspectRatio: 0.7,
                                            crossAxisSpacing: 12,
                                            mainAxisSpacing: 12),
                                    itemCount: filtterMoviw.length,
                                    itemBuilder: (context, index) {
                                      return SizedBox(
                                        width: 189,
                                        height: 279,
                                        child: MovieCard(
                                            movie: filtterMoviw[index]),
                                      );
                                    },
                                  );
                                },
                              )
                              .toSet()
                              .toList(),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ));
              })),
    );
  }
}
