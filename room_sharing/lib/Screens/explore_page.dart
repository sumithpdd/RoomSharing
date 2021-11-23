// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:room_sharing/Models/dummy_data.dart';
import 'package:room_sharing/Models/posting_model.dart';
import 'package:room_sharing/Screens/view_posting_page.dart';
import 'package:room_sharing/Views/grid_widgets.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  late List<Posting> _posting;

  @override
  void initState() {
    _posting = DummyData.postings;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 50.0,
              ),
              child: TextField(
                decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 2.0,
                      ),
                    ),
                    contentPadding: EdgeInsets.all(5.0)),
                style: TextStyle(fontSize: 20.0, color: Colors.black),
              ),
            ),
            GridView.builder(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemCount: _posting.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 3 / 4,
              ),
              itemBuilder: (context, index) {
                Posting currentPosting = _posting[index];
                return InkResponse(
                  enableFeedback: true,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewPostingPage(
                          posting: currentPosting,
                        ),
                      ),
                    );
                  },
                  child: PostingGridTile(
                    posting: currentPosting,
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
