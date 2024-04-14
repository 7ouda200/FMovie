import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/search.dart';
import '../../../shared/app_theme.dart';
import '../../../viewmodel/search_vm.dart';
import '../../reusable/searchItems.dart';


class SearchItems extends StatefulWidget {
  final String query;
  const SearchItems(this.query);

  @override
  State<SearchItems> createState() => _SearchItemsState();
}

class _SearchItemsState extends State<SearchItems> {
  final viewModel=SearchModelView();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('query:${widget.query}');
    viewModel.getsearch(widget.query);
  }
  @override
  Widget build(BuildContext context) {
    viewModel.getsearch(widget.query);
    return  ChangeNotifierProvider(
      create:(_) => viewModel,
      child: Consumer<SearchModelView>(
        builder:(context, value, child) {
          if(viewModel.isloading){

            return Center(child: CircularProgressIndicator(color: AppTheme.gold,
            ));
          }else if(viewModel.errorMessage!=null){
            return Center(child: Text(viewModel.errorMessage??''));
          }
          return
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:<Widget>[
                  SizedBox(height: 10,),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (BuildContext context, int index) => const Divider(
                        height: 5,
                        color: Colors.grey,

                      ),
                      itemBuilder:(context, index) {
                        print(viewModel.results.length);
                        //print(viewModel.results[index].id);

                        return items(
                            viewModel.results[index].backdropPath,
                            viewModel.results[index].title,
                            viewModel.results[index].releaseDate,
                            viewModel.results[index].overview

                        );

                      },
                      itemCount: viewModel.results.length,

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
