// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:room_sharing/Models/posting_model.dart';
import 'package:room_sharing/Screens/view_posting_page.dart';
import 'package:room_sharing/Views/grid_widgets.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  Stream<QuerySnapshot> _stream =
      FirebaseFirestore.instance.collection('postings').snapshots();
  TextEditingController _controller = TextEditingController();
  String _searchType = "";
  bool _isNameButtonSelected = false;
  bool _isCityButtonSelected = false;
  bool _isTypeButtonSelected = false;

  void _pressSearchByButton(String searchType, bool isNameButtonSelected,
      bool isCityButtonSelected, bool isTypeButtonSelected) {
    setState(() {
      _searchType = searchType;
      _isNameButtonSelected = isNameButtonSelected;
      _isCityButtonSelected = isCityButtonSelected;
      _isTypeButtonSelected = isTypeButtonSelected;
    });
  }

  void _searchByField() {
    setState(() {
      if (_searchType.isEmpty) {
        _stream = FirebaseFirestore.instance.collection('postings').snapshots();
      } else {
        String searchText = _controller.text.trim();
        _stream = FirebaseFirestore.instance
            .collection('postings')
            .where(_searchType, isEqualTo: searchText)
            .snapshots();
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 10.0,
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
                controller: _controller,
                style: TextStyle(fontSize: 20.0, color: Colors.black),
                onEditingComplete: _searchByField,
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  MaterialButton(
                    onPressed: () {
                      _pressSearchByButton('name', true, false, false);
                    },
                    child: Text("Name"),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: _isNameButtonSelected
                        ? Colors.blueAccent
                        : Colors.white,
                  ),
                  MaterialButton(
                    onPressed: () {
                      _pressSearchByButton('city', false, true, false);
                    },
                    child: Text("City"),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: _isCityButtonSelected
                        ? Colors.blueAccent
                        : Colors.white,
                  ),
                  MaterialButton(
                    onPressed: () {
                      _pressSearchByButton('type', false, false, true);
                    },
                    child: Text("Type"),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: _isTypeButtonSelected
                        ? Colors.blueAccent
                        : Colors.white,
                  ),
                  MaterialButton(
                    onPressed: () {
                      _pressSearchByButton('', false, false, false);
                    },
                    child: Text("Clear"),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ],
              ),
            ),
            StreamBuilder(
                stream: _stream,
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshots) {
                  switch (snapshots.connectionState) {
                    case ConnectionState.waiting:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    default:
                      return GridView.builder(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshots.data!.docs.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          childAspectRatio: 3 / 4,
                        ),
                        itemBuilder: (context, index) {
                          DocumentSnapshot snapshot =
                              snapshots.data!.docs[index];
                          Posting currentPosting = Posting(id: snapshot.id);
                          currentPosting.getPostingInfoFromSnapshot(snapshot);
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
                      );
                  }
                })
          ],
        ),
      ),
    );
  }
}
