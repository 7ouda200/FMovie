import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movies_app/view/tabs/search/search_items.dart';
import 'package:movies_app/viewmodel/search_vm.dart';
import 'package:provider/provider.dart';

import '../../reusable/searchItems.dart';
import '../../reusable/textField.dart';

class Search extends StatefulWidget {
  const Search({super.key});
  //static const String routeName = 'search_screen';

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  //final viewModel=SearchModelView();
  String query='';
  @override

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(

    body: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          SearchFiled(
                (value) {
              query=value;
              setState(() {
              });
            },
          ),
          SizedBox(height: 10,),
          query.isNotEmpty?
          Expanded(child: SearchItems(query)):Center(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
             // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 150,),
                Icon(Icons.movie,color: Colors.white,size: 100,),
                Text('No Movies Found'),
              ],
            ),
          ),

        ],
      ),
    ),
    ),
    );
  }
}



