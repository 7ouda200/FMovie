import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movies_app/models/apiManger.dart';
import 'package:movies_app/models/popular.dart';
import 'package:movies_app/shared/app_theme.dart';
import 'package:movies_app/view/movieheader.dart';
import 'package:movies_app/view/TopratedAndUpcoming.dart';
import 'package:provider/provider.dart';

import '../../viewmodel/popular_vm.dart';

class HomeScreen extends StatefulWidget {
  //static const String routeName = 'home_screen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final viewModel=PopularModelView();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     viewModel.getpopular();
  }
  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create:(_) => viewModel,
      child: Consumer<PopularModelView>(
        builder:(context, value, child) {
          if(viewModel.isloading){

            return Center(child: CircularProgressIndicator(
              color: AppTheme.gold,
            ));
          }else if(viewModel.errorMessage!=null){
            return Text(viewModel.errorMessage??'');
          }
          return Column(
            children: <Widget>[
              MovieHeaderScreen(viewModel.results),
              SizedBox(height: 10,),
              Expanded(child: NewRelease()),
              SizedBox(height: 10,),
              Expanded(child: Recomanded()),
            ],
          );
        },
      ),
    );
  }
}
