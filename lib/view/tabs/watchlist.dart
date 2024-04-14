import 'package:flutter/material.dart';
import 'package:movies_app/view/tabs/Browse/browse_items.dart';
import 'package:provider/provider.dart';

import '../../models/watch_provider.dart';

class WatchList extends StatefulWidget {
  const WatchList({super.key});

  @override
  State<WatchList> createState() => _WatchListState();
}

class _WatchListState extends State<WatchList> {
  @override
  Widget build(BuildContext context) {
    final watchProvider = Provider.of<WatchProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: watchProvider.watches.isEmpty
              ? Column(
                  children: <Widget>[
                    Center(
                        child: Icon(
                      Icons.movie_rounded,
                      size: 100,
                      color: Colors.white,
                    )),
                    Text(
                      'No Movies added',
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    )
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Favourite Movies',style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 20),),
                    SizedBox(
                      height: 15,
                    ),
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          return item(
                              watchProvider.watches[index].imgUrl,
                              watchProvider.watches[index].title,
                              watchProvider.watches[index].dateTime,
                              watchProvider.watches[index].description);
                        },
                        itemCount: watchProvider.watches.length, separatorBuilder: (BuildContext context, int index) {
                          return Divider(
                            height: 5,
                            color: Colors.grey,
                          );

                      },
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
