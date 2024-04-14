import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/models/moviedetails.dart';
import 'package:movies_app/models/popular.dart';
import 'package:movies_app/models/search.dart';
import 'package:movies_app/models/similarMovies.dart';
import 'package:movies_app/models/toprated.dart';
import 'package:movies_app/models/upcoming.dart';
import 'package:movies_app/models/discover.dart';


import 'movieList.dart';
class API{


  Future<popular> getPopular()async{
    try{
      final uri=Uri.https('api.themoviedb.org','/3/movie/popular',
      {
        'language':'en-US',
        'page':'3',
        'api_key':'ecec060bf76486727aa721097351b3a6',
          }
      );

      final response=await http.get(uri);
      final json=jsonDecode(response.body);
      return popular.fromJson(json);
    }catch(e){
      print(e);
      rethrow;
    }
  }

  Future<upcoming> getUpcoming()async{
    try{
      final uri=Uri.https('api.themoviedb.org','/3/movie/upcoming',
          {
            'language':'en-US',
            'page':'2',
            'api_key':'ecec060bf76486727aa721097351b3a6',
          }
      );

      final response=await http.get(uri);
      final json=jsonDecode(response.body);
      return upcoming.fromJson(json);
    }catch(e){
      print(e);
      rethrow;
    }
  }


  Future<toprated> getToprated()async{
    try{
      final uri=Uri.https('api.themoviedb.org','/3/movie/top_rated',
          {
            'language':'en-US',
            'page':'2',
            'api_key':'ecec060bf76486727aa721097351b3a6',
          }
      );

      final response=await http.get(uri);
      final json=jsonDecode(response.body);
      return toprated.fromJson(json);
    }catch(e){
      print(e);
      rethrow;
    }
  }

  Future<MovieDetails> getmoviedetails(int movieId)async{
    try{
      final uri=Uri.https('api.themoviedb.org','/3/movie/$movieId',
          {
            'language':'en-US',
            'api_key':'ecec060bf76486727aa721097351b3a6',
          }
      );

      final response=await http.get(uri);
      final json=jsonDecode(response.body);
      return MovieDetails.fromJson(json);
    }catch(e){
      print(e);
      rethrow;
    }
  }


  Future<search> getsearchmovie(String query)async{
    try{
      final uri=Uri.https('api.themoviedb.org','/3/search/movie',
          {
            'query':query,
            'language':'en-US',
            'page':'1',
            'api_key':'ecec060bf76486727aa721097351b3a6',
          }
      );

      final response=await http.get(uri);
      final json=jsonDecode(response.body);
      return search.fromJson(json);
    }catch(e){
      print(e);
      rethrow;
    }
  }

  Future<MovieList> getMovieList()async{
    try{
      final uri=Uri.https('api.themoviedb.org','/3/genre/movie/list',
          {
            'language':'en-US',
            'api_key':'ecec060bf76486727aa721097351b3a6',
          }
      );

      final response=await http.get(uri);
      final json=jsonDecode(response.body);
      return MovieList.fromJson(json);
    }catch(e){
      print(e);
      rethrow;
    }
  }

  Future<Discover> getdiscoveredmovie(String genere)async
  {
    try{
      final uri=Uri.https('api.themoviedb.org','/3/discover/movie',
          {
            'include_adult':'false',
            'include_video':'false',
            'language':'en-US',
            'page':'1',
            'sort_by':'popularity.desc',
            'with_genres':genere,
            'api_key':'ecec060bf76486727aa721097351b3a6',
          }
      );

      final response=await http.get(uri);
      final json=jsonDecode(response.body);
      return Discover.fromJson(json);
    }catch(e){
      print(e);
      rethrow;
    }
  }
  Future<Similar> getsimilardmovie(int movieId)async
  {
    try{
      final uri=Uri.https('api.themoviedb.org','/3/movie/$movieId/similar',
          {

            'language':'en-US',
            'page':'1',
            'api_key':'ecec060bf76486727aa721097351b3a6',
          }
      );

      final response=await http.get(uri);
      final json=jsonDecode(response.body);
      return Similar.fromJson(json);
    }catch(e){
      print(e);
      rethrow;
    }
  }



}