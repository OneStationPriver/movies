import 'package:flutter/material.dart';
import 'api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
      theme: ThemeData(useMaterial3: false),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic>? movies;
  static const String BASE_URL_IMAGE = 'https://image.tmdb.org/t/p/w300';

  @override
  void initState() {
    super.initState();
    //_getTrendingMovies();
  }

  void _getTrendingMovies() async {
    try {
      final results = await ApiService.getTrendingMovies();
      final moviesList = results['results'] as List<dynamic>;
      setState(() {
        movies = moviesList;
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: movies != null ? _buildMovieList() : _buildLoading(),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          _getTrendingMovies();
        },
        child: Text("Mostrar Peliculas"),
      ),
    );
  }

  Widget _buildMovieList() {
    return ListView.builder(
      itemCount: movies!.length,
      itemBuilder: (context, index) {
        final movie = movies![index];
        final String pathImage = "${BASE_URL_IMAGE}${movie['poster_path']}";
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(movie['title']),
                Text('Lenguaje: ${movie['original_language']}'),
                // Text(movie['id']),
                Text('Descripcion: ${movie['overview']}'),
                Text('Fecha: ${movie['release_date']}'),
                Image.network(pathImage),
              ],
            ),
          ),
        );
      },
    );
  }
}
