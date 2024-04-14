import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movies_app/models/apiManger.dart';
import 'package:movies_app/view/MovieDetails.dart';

import '../models/popular.dart';

class MovieHeaderScreen extends StatefulWidget {
  final List<Results> Source;
  const MovieHeaderScreen(this.Source);

  @override
  State<MovieHeaderScreen> createState() => _MovieHeaderScreenState();
}

class _MovieHeaderScreenState extends State<MovieHeaderScreen> {



  @override
  Widget build(BuildContext context) {
    return  CarouselSlider.builder(
      options: CarouselOptions(
          autoPlayAnimationDuration: const Duration(milliseconds: 2000),
          autoPlayInterval: const Duration(milliseconds: 3000),
          autoPlayCurve: Curves.linear,
          viewportFraction: 1.0,
          enlargeFactor: 0.4,
          enlargeCenterPage: true,
          onPageChanged: (index, reason) {
          },
          height: 300,
          autoPlay:true,
          scrollDirection: Axis.horizontal,
          aspectRatio: 2.0),
      itemCount:widget.Source.length,
      itemBuilder: (context, index, realIndex) {
        return InkWell(
          onTap: (){
            Navigator.push(context,MaterialPageRoute(builder: (context) => MovieDetails(widget.Source[index].id),));

          },
          child: Stack(
            children: [
              Image(image: NetworkImage('https://image.tmdb.org/t/p/w500/${widget.Source[index].backdropPath}')),
              Positioned(
                bottom: 0.0,
                left: 16.0,
                right: 16.0,
                child: Row(
                  children: <Widget>[
                    Image(
                        height: 180.0,
                        image: NetworkImage('https://image.tmdb.org/t/p/w500/${widget.Source[index].posterPath}')),
                    SizedBox(
                      width: 16.0,
                    ),
                Padding(
                  padding: EdgeInsets.only(top: 90),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width*0.5,
                        child: Text(overflow:TextOverflow.ellipsis,
                          '${widget.Source[index].title}',
                          style:Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text('${widget.Source[index].releaseDate}',style:Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 10),)

                    ],
                  ),
                ),

                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
