import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movies_app/view/reusable/poster.dart';
import 'package:provider/provider.dart';

import '../models/watch_provider.dart';
import '../shared/app_theme.dart';
import '../viewmodel/moviedetails_vm.dart';
import 'package:movies_app/view/TopratedAndUpcoming.dart';


class MovieDetails extends StatefulWidget {
  final id;
  const MovieDetails(this.id);

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  var viewModel=MovieDetailsModelView();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getMovieDetails(widget.id);
    print(widget.id);
  }
  @override
  Widget build(BuildContext context) {
    final watchProvider = Provider.of<WatchProvider>(context);
    return ChangeNotifierProvider(
      create:(_) => viewModel,
      child: Consumer<MovieDetailsModelView>(
        builder:(context, value, child) {
          if(viewModel.isloading){

            return Center(child: CircularProgressIndicator());
          }else if(viewModel.errorMessage!=null){
            return Text(viewModel.errorMessage??'');
          }
          return SafeArea(child: Scaffold(
            appBar: AppBar(
              title: Text(viewModel.title),
            ),
          body: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: <Widget>[
               CachedNetworkImage(
                 imageUrl: "https://image.tmdb.org/t/p/w500/${viewModel.backdrop_path}",
                 progressIndicatorBuilder: (context, url, downloadProgress) =>
                     CircularProgressIndicator(value: downloadProgress.progress,color: AppTheme.gold),
                 errorWidget: (context, url, error) =>  Image(image: AssetImage('images/movies.png'),height: 217,width:412,)
               ),
               SizedBox(height: 15,),
               Padding(
                 padding: const EdgeInsets.only(left: 20),
                 child: Text(viewModel.title,style: Theme.of(context).textTheme.bodyMedium,),
               ),
               Padding(
                 padding: const EdgeInsets.only(left: 20),
                 child: Text(viewModel.date,style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.grey),),
               ),
               SizedBox(height: 20,),
               Padding(
                 padding: const EdgeInsets.only(left: 20),
                 child: Row(
                   children: <Widget>[
                     headerPosterdetail("https://image.tmdb.org/t/p/w500/${viewModel.posterpath}",
                     viewModel.title,
                     viewModel.date,
                       viewModel.overview,
                       
                     ),
                     SizedBox(width: 10,),
                     Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: <Widget>[
                         SizedBox(
                           width: 100,
                           child: ListView.builder(itemBuilder: (context, index) {
                             return Container(
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(5.0),
                                 border: Border.all(color: Colors.white),

                               ),
                               margin: EdgeInsets.all(2.0),
                               child: Center(child: Text(viewModel.genres[index].name??'',style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 13,color: Colors.grey),)),
                             );


                           },
                             shrinkWrap: true,
                             //scrollDirection: Axis.horizontal,
                             itemCount: viewModel.genres.length,),
                         ),
                         SizedBox(height: 10,),
                         Container(
                             width: MediaQuery.of(context).size.width*0.5,
                             child: Text(maxLines: 4,overflow: TextOverflow.ellipsis,'${viewModel.overview}',style:Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 13,color: Colors.grey),)),
                         Row(
                           children: <Widget>[
                             Icon(Icons.star,color: Colors.orange,),
                             Text(viewModel.voteAvg.toString().substring(0,3),style: Theme.of(context).textTheme.bodyMedium,),
                           ],
                         ),

                       ],
                     ),



                   ],
                 ),
               ),
               SizedBox(height: 10,),
               Expanded(child: SimilarMovies(widget.id)),
               SizedBox(height: 5,),

             ],
          ),
          ),
          );
        },
      ),
    );
  }
}
