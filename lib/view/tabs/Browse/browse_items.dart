import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../shared/app_theme.dart';



class item extends StatefulWidget {
  final imageUrl;
  final title;
  final year;
  final overview;
  const item(this.imageUrl, this.title, this.year, this.overview);

  @override
  State<item> createState() => _itemState();
}

class _itemState extends State<item> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        CachedNetworkImage(
          width: 140,
          height: 89,
          imageUrl: "https://image.tmdb.org/t/p/w500/${widget.imageUrl}",
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              CircularProgressIndicator(value: downloadProgress.progress,color: AppTheme.gold,
              ),
          errorWidget: (context, url, error) =>  Image(image: AssetImage('images/movies.png'),height: 89,width: 140,),
        ),
        SizedBox(width: 10,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:<Widget> [
            Container(
                width: MediaQuery.of(context).size.width*0.5,
                child: Text(widget.title,overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.headlineSmall,)),
            Text(widget.year.toString().substring(0,4),style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 13,color: Colors.grey),),
            Container(
                width: MediaQuery.of(context).size.width*0.5,
                child: Text(overflow: TextOverflow.ellipsis,widget.overview.toString(),style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 13,color: Colors.grey),)),

          ],
        )

      ],
    );
  }
}
