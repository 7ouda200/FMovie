import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/view/tabs/Browse/browse_grid.dart';
import 'package:provider/provider.dart';

import '../../../shared/app_theme.dart';
import '../../../viewmodel/movieList_vm.dart';

class Browse extends StatefulWidget {
  const Browse({super.key});

  @override
  State<Browse> createState() => _BrowseState();
}

class _BrowseState extends State<Browse> {
  final viewModel = MovieListModelView();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getMovieList();
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => viewModel,
      child: Consumer<MovieListModelView>(
        builder: (context, value, child) {
          if (viewModel.isloading) {
            return Center(child: CircularProgressIndicator(color: AppTheme.gold,
            ));
          } else if (viewModel.errorMessage != null) {
            return Center(child: Text(viewModel.errorMessage ?? ''));
          }
          return SafeArea(
            child: Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:<Widget> [
                    Text('Browse Category',style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white,fontSize: 22),),
                    Expanded(
                      child: BrowseGrid(
                        viewModel.genres
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
