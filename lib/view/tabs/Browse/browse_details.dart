import 'package:flutter/material.dart';
import 'package:movies_app/shared/app_theme.dart';
import 'package:provider/provider.dart';

import '../../../viewmodel/discover.vm.dart';
import 'browse_items.dart';


class DetailsMovie extends StatefulWidget {
  final String id;
  final String title;
  const DetailsMovie(this.id, this.title);

  @override
  State<DetailsMovie> createState() => _DetailsMovieState();
}

class _DetailsMovieState extends State<DetailsMovie> {
  final viewModel=DiscoverModelView();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getdiscoverd(widget.id);
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:(_) => viewModel,
      child: Consumer<DiscoverModelView>(
        builder:(context, value, child) {
          if(viewModel.isloading){

            return Center(child: CircularProgressIndicator(
              color: AppTheme.gold,
            ));
          }else if(viewModel.errorMessage!=null){
            return Center(child: Text(viewModel.errorMessage??''));
          }
          return SafeArea(child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: viewModel.results.isEmpty?
              Column(
                children: <Widget>[
                  Center(child: Icon(Icons.movie_rounded,size:100,color: Colors.white,)),
                  Text('No Movies found',style: TextStyle(
                      fontSize: 30,
                      color: Colors.white
                  ),)
                ],
              ):
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:<Widget>[
                  Text('${widget.title} Movies',style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 20),),
                  SizedBox(height: 10,),
                  Expanded(
                    child: ListView.separated(
                      itemBuilder:(context, index) {
                        print(viewModel.results[index].title);
                        print(viewModel.results[index].id);

                        return item(
                            viewModel.results[index].backdropPath,
                            viewModel.results[index].title,
                            viewModel.results[index].releaseDate,
                            viewModel.results[index].overview

                        );

                      },
                      itemCount: viewModel.results.length, separatorBuilder: (BuildContext context, int index) { return Divider(
                      height: 5,
                      color: Colors.grey,

                    ); },

                    ),
                  )
                ],
              ),
            ),

          ),
          );
        },
      ),
    );
  }
}
