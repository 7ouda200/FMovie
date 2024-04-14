import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movies_app/view/reusable/poster.dart';
import 'package:movies_app/shared/app_theme.dart';
import 'package:movies_app/viewmodel/upcoming_vm.dart';
import 'package:provider/provider.dart';

import 'package:movies_app/view/MovieDetails.dart';
import '../models/popular.dart';
import '../models/watch_provider.dart';
import '../models/watchlist.dart';
import '../viewmodel/similarMovie_vm.dart';
import '../viewmodel/toprated_vm.dart';

class NewRelease extends StatefulWidget {
  const NewRelease();

  @override
  State<NewRelease> createState() => _NewReleaseState();
}

class _NewReleaseState extends State<NewRelease> {
  final viewModel=UpcomingModelView();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getupcoming();
  }
  @override
  Widget build(BuildContext context) {
   final watchProvider = Provider.of<WatchProvider>(context);
    return ChangeNotifierProvider(
      create:(_) => viewModel,
      child: Consumer<UpcomingModelView>(
        builder:(context, value, child) {
          if(viewModel.isloading){

            return Center(child: CircularProgressIndicator());
          }else if(viewModel.errorMessage!=null){
            return Text(viewModel.errorMessage??'');
          }
          return  Container(
            padding: EdgeInsets.all(5.0),
           // margin: EdgeInsets.only(top: 5.0,bottom:5.0),
            color: AppTheme.grey,
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('New Release',style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 15),),
                SizedBox(height: 5,),
                Expanded(
                  child: ListView.separated(
                   // padding: EdgeInsets.all(0.9),
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 6,),
                    itemBuilder:(context, index) {

                      return InkWell(
                        onTap: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context) => MovieDetails(viewModel.results[index].id),));

                        },

                        child: Poster(
                            viewModel.results[index].posterPath.toString(),
                          viewModel.results[index].title.toString(),
                          viewModel.results[index].releaseDate.toString(),
                          viewModel.results[index].overview.toString(),
                        ),
                      );

                    },
                    itemCount:viewModel.results.length,

                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}



///////////////////////////////////////////////////////////////

class Recomanded extends StatefulWidget {
  const Recomanded({super.key});

  @override
  State<Recomanded> createState() => _RecomandedState();
}

class _RecomandedState extends State<Recomanded> {
  final viewModel=TopratedModelView();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.gettoprated();
  }
  @override
  Widget build(BuildContext context) {
    final watchProvider = Provider.of<WatchProvider>(context);
    return ChangeNotifierProvider(
      create:(_) => viewModel,
      child: Consumer<TopratedModelView>(
        builder:(context, value, child) {
          if(viewModel.isloading){

            return Center(child: CircularProgressIndicator());
          }else if(viewModel.errorMessage!=null){
            return Text(viewModel.errorMessage??'');
          }

         var result=viewModel.results.length;
          return  Container(
            padding: EdgeInsets.all(5.0),
            //margin: EdgeInsets.only(top: 5.0,bottom:5.0),
            color: AppTheme.grey,
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Recomanded',style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 15),),
                SizedBox(height: 5,),
                Expanded(
                  child: ListView.separated(
                   // padding: EdgeInsets.all(0.9),
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (BuildContext context, int index) => const SizedBox(width:6,),
                    itemBuilder:(context, index) {

                      return InkWell(
                        onTap: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context) => MovieDetails(viewModel.results[index].id),));

                        },
                        child: PosterDetails(viewModel.results[index].posterPath.toString(),
                        viewModel.results[index].voteAverage!.toDouble(),
                        viewModel.results[index].title.toString(),
                        viewModel.results[index].releaseDate.toString(),
                          viewModel.results[index].overview.toString(),

                        ),
                      );
                    },
                    itemCount:result,

                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}



class SimilarMovies extends StatefulWidget {
  final int MovieId;
  const SimilarMovies(this.MovieId);

  @override
  State<SimilarMovies> createState() => _SimilarMoviesState();
}

class _SimilarMoviesState extends State<SimilarMovies> {
  final viewModel=SimilarMoviesModelView();
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getSimilarMovies(widget.MovieId);
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:(_) => viewModel,
      child: Consumer<SimilarMoviesModelView>(
        builder:(context, value, child) {
          if(viewModel.isloading){

            return Center(child: CircularProgressIndicator());
          }else if(viewModel.errorMessage!=null){
            return Text(viewModel.errorMessage??'');
          }

          var result=viewModel.results.length;
          return  Container(
            padding: EdgeInsets.all(5.0),
            //margin: EdgeInsets.only(top: 5.0,bottom:5.0),
            color: AppTheme.grey,
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('More Like This',style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 15),),
                SizedBox(height: 5,),
                Expanded(
                  child: ListView.separated(
                    // padding: EdgeInsets.all(0.9),

                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (BuildContext context, int index) => const SizedBox(width:6,),
                    itemBuilder:(context, index) {
                      return InkWell(
                        onTap: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context) => MovieDetails(viewModel.results[index].id),));

                        },
                        child: PosterDetails(viewModel.results[index].posterPath.toString(),
                          viewModel.results[index].voteAverage!.toDouble(),
                          viewModel.results[index].title.toString(),
                          viewModel.results[index].releaseDate.toString(),
                          viewModel.results[index].overview.toString(),

                        ),
                      );
                    },
                    itemCount:result,

                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
