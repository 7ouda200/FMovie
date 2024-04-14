import 'package:flutter/material.dart';

import '../../../models/movieList.dart';
import 'browse_details.dart';


class BrowseGrid extends StatefulWidget {
 final List<Genres> generes;
  const BrowseGrid(this.generes);

  @override
  State<BrowseGrid> createState() => _BrowseGridState();
}

class _BrowseGridState extends State<BrowseGrid> {
  List<String>image=[
    'action',
    'adventure',
    'animi',
    'comedy',
    'crime',
    'documentry',
    'drama',
    'family',
    'fantasy',
    'history',
    'horror',
    'music',
    'mystery',
    'romance',
    'sci-fi',
    'tv',
    'thriller',
    'war',
    'western'
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount:widget.generes.length,
      gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2,mainAxisSpacing:10,crossAxisSpacing:10),
      itemBuilder:(context, index) {
        return Center(
          child: InkWell(
            onTap: (){

              Navigator.push(context, MaterialPageRoute(builder: (context) =>DetailsMovie(widget.generes[index].id.toString(),
              widget.generes[index].name.toString()
              )
                ,));

            },
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(image:  AssetImage('images/${image[index]}.png'),
                fit: BoxFit.cover
                ),
              ),
              child: Center(child: Text('${widget.generes[index].name},',style: Theme.of(context).textTheme.headlineSmall?.copyWith(

                fontWeight:FontWeight.bold
              ),)),
            ),
          ),
        );
      },



    );
  }
}
