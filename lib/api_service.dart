import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String apiKey = 'abaab63f95db96063d0cb378cfea8f87'; // Reemplaza con tu clave real
  static const String baseUrl = 'https://api.themoviedb.org/3';

  static Future<dynamic> getTrendingMovies() async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhYmFhYjYzZjk1ZGI5NjA2M2QwY2IzNzhjZmVhOGY4NyIsInN1YiI6IjY1ZDRjMTcyNDE0MjkxMDE3Y2EyZjZhNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.V7JNwRDnJ65EqeZX00V5rGsSsOX3IWie4ig6BkoGiuM',
    };

    final url = Uri.parse('$baseUrl/trending/movie/day');
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al obtener datos: ${response.reasonPhrase}');
    }
  }
}