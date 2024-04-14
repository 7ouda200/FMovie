import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movies_app/shared/app_theme.dart';
import 'package:provider/provider.dart';

import '../../models/firebaseutil.dart';
import '../../models/watch_provider.dart';
import '../../models/watchlist.dart';

class Poster extends StatefulWidget {
  final String ImgUrl;
  final String title;
  final String releaseAt;
  final String description;
  const Poster(this.ImgUrl,  this.title, this.releaseAt, this.description,);

  @override
  State<Poster> createState() => _PosterState();
}

class _PosterState extends State<Poster> {
  var image = 'bookmark.png';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CachedNetworkImage(
            height: 180,
            imageUrl: "https://image.tmdb.org/t/p/w500/${widget.ImgUrl}",
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                CircularProgressIndicator(value: downloadProgress.progress,color: AppTheme.gold),
            errorWidget: (context, url, error) =>  Image(image: AssetImage('images/movies.png'),height: 199,width:129,)
        ),

        // Image(
        //     height: 180.0,
        //     image: NetworkImage(
        //         'https://image.tmdb.org/t/p/w500/${widget.ImgUrl}')),
        InkWell(
          onTap: () {
            if ( image == 'bookmark.png') {
              addtask();
              image = 'added.png';
            } else  {
              image = 'bookmark.png';
              //addtask();

            }
            setState(() {});
          },
          child: Image(image: AssetImage('images/$image')),
        ),
      ],
    );
  }
  void addtask(){
    FirebaseUtils.addWatchToFirestore(WatchListModel(
      title:widget.title,
      description:widget.description,
      dateTime:widget.releaseAt,
      imgUrl: widget.ImgUrl,
      isDone:true,
    )).timeout(
        const Duration(milliseconds: 500),
        onTimeout: (){
          print('Done');
          // Fluttertoast.showToast(
          //     msg: "Task added successfully",
          //     toastLength: Toast.LENGTH_SHORT,
          //     gravity: ToastGravity.SNACKBAR,
          //     timeInSecForIosWeb: 1,
          //     backgroundColor: Colors.red,
          //     textColor: Colors.white,
          //     fontSize: 16.0
          // );
        }
    ).catchError((_){
      print('Error$_');
      // Fluttertoast.showToast(
      //     msg: "Something went wrong!",
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.SNACKBAR,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: Colors.red,
      //     textColor: Colors.white,
      //     fontSize: 16.0
      // );
    });
    Provider.of<WatchProvider>(context,listen:false).getWatches();
    // Navigator.of(context).pop();
  }
  // void delete(String id){
  //   FirebaseUtils.deleteTaskToFirestore(id).timeout(
  //       const Duration(milliseconds: 500),
  //       onTimeout: (){
  //         Fluttertoast.showToast(
  //             msg: "Task deleted successfully",
  //             toastLength: Toast.LENGTH_SHORT,
  //             gravity: ToastGravity.SNACKBAR,
  //             timeInSecForIosWeb: 1,
  //             backgroundColor: Colors.red,
  //             textColor: Colors.white,
  //             fontSize: 16.0
  //         );
  //       }
  //
  //   ).catchError((_){
  //     Fluttertoast.showToast(
  //         msg: "Something went wrong!",
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.SNACKBAR,
  //         timeInSecForIosWeb: 1,
  //         backgroundColor: Colors.red,
  //         textColor: Colors.white,
  //         fontSize: 16.0
  //     );
  //   });
  //   Provider.of<TaskProvider>(context, listen: false).getTasks();
  // }

}

////////////////////////////////////////////////////////////////////

class PosterDetails extends StatefulWidget {
  final String ImgUrl;
  final double rate;
  final String title;
  final String releaseAt;
  final String description;
  const PosterDetails(this.ImgUrl, this.rate, this.title, this.releaseAt, this.description);

  @override
  State<PosterDetails> createState() => _PosterDetailsState();
}

class _PosterDetailsState extends State<PosterDetails> {
  var image = 'bookmark.png';
  @override
  Widget build(BuildContext context) {
    return Container(
     // width:MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(color: Colors.grey),
        color:AppTheme.grey,

      ),
      width:60,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(

            child: Stack(
              children: <Widget>[
                CachedNetworkImage(
                    height: 180,
                    imageUrl: "https://image.tmdb.org/t/p/w500/${widget.ImgUrl}",
                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                        CircularProgressIndicator(value: downloadProgress.progress,color: AppTheme.gold),
                    errorWidget: (context, url, error) =>  Image(image: AssetImage('images/movies.png'),height: 199,width:129,)
                ),

                InkWell(
                  onTap: () {
                    if (image == 'added.png') {
                      image = 'bookmark.png';

                    } else if (image == 'bookmark.png') {

                      print('ok');
                      addtask();
                      image = 'added.png';
                    }
                    setState(() {});
                  },
                  child: Image(image: AssetImage('images/$image')),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Icon(
                Icons.star,
                color: Colors.orange,
                size: 11,
              ),
              Text(
                '${widget.rate}',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
          Text(
            widget.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Text(
           widget.releaseAt,
            style: Theme.of(context).textTheme.titleSmall,
          )

        ],
      ),
    );
  }

  void addtask(){
    FirebaseUtils.addWatchToFirestore(WatchListModel(
      title:widget.title,
      description:widget.description,
      dateTime:widget.releaseAt,
      imgUrl: widget.ImgUrl,
        isDone:true,
    )).timeout(
        const Duration(milliseconds: 500),
        onTimeout: (){
          print('Done');
          // Fluttertoast.showToast(
          //     msg: "Task added successfully",
          //     toastLength: Toast.LENGTH_SHORT,
          //     gravity: ToastGravity.SNACKBAR,
          //     timeInSecForIosWeb: 1,
          //     backgroundColor: Colors.red,
          //     textColor: Colors.white,
          //     fontSize: 16.0
          // );
        }
    ).catchError((_){
      print('Error$_');
      // Fluttertoast.showToast(
      //     msg: "Something went wrong!",
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.SNACKBAR,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: Colors.red,
      //     textColor: Colors.white,
      //     fontSize: 16.0
      // );
    });
    Provider.of<WatchProvider>(context,listen:false).getWatches();
    // Navigator.of(context).pop();
  }

}


class headerPosterdetail extends StatefulWidget {
  final String ImgUrl;
  final String title;
  final String releaseAt;
  final String description;
  const headerPosterdetail(this.ImgUrl, this.title, this.releaseAt, this.description);

  @override
  State<headerPosterdetail> createState() => _headerPosterdetailState();
}

class _headerPosterdetailState extends State<headerPosterdetail> {
  var image = 'bookmark.png';
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CachedNetworkImage(
          height: 180,
            imageUrl: "https://image.tmdb.org/t/p/w500/${widget.ImgUrl}",
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                CircularProgressIndicator(value: downloadProgress.progress,color: AppTheme.gold),
            errorWidget: (context, url, error) =>  Image(image: AssetImage('images/movies.png'),height: 199,width:129,)
        ),

        // Image(
        //     height: 180.0,
        //     image: NetworkImage(
        //         'https://image.tmdb.org/t/p/w500/${widget.ImgUrl}')),
        InkWell(
          onTap: () {
            if (image == 'added.png') {
              image = 'bookmark.png';
            } else if (image == 'bookmark.png') {
              image = 'added.png';
            }
            setState(() {});
          },
          child: Image(image: AssetImage('images/$image')),
        ),
      ],
    );
  }
}
