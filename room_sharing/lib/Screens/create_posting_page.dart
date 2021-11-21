// ignore_for_file: prefer_const_constructors, prefer_const_declarations

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:room_sharing/Views/text_widgets.dart';

class CreatePostingPage extends StatefulWidget {
  static final String routeName = '/CreatePostingPageRoute';

  const CreatePostingPage({Key? key}) : super(key: key);

  @override
  _CreatePostingPageState createState() => _CreatePostingPageState();
}

class _CreatePostingPageState extends State<CreatePostingPage> {
  late String _houseType;

  final List<String> _houseTypes = [
    'Detached House',
    'Apartment',
    'Condo',
    'Townhouse'
  ];

  @override
  void initState() {
    _houseType = _houseTypes[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarText(text: 'Create a Posting'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.clear)),
          IconButton(onPressed: () {}, icon: Icon(Icons.save))
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(25, 50, 25, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                Text(
                'Please enter the following information:',
                style: TextStyle(fontSize: 25.0),
                textAlign: TextAlign.center,
              ),
              Form(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: TextFormField(
                  decoration:
                  InputDecoration(labelText: 'Posting name'),
                  style: TextStyle(fontSize: 25.0),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 35.0),
                  child: DropdownButton(
                    isExpanded: true,
                    value: _houseType,
                    hint: Text(
                      'Select a house type',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    items: _houseTypes.map((houseType) {
                      return DropdownMenuItem(
                        value: houseType,
                        child: Text(
                          houseType,
                          style: TextStyle(fontSize: 20.0),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {},
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration:
                        InputDecoration(labelText: 'Price'),
                        style: TextStyle(fontSize: 25.0),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, bottom: 15.0),
                      child: Text('\$ / night',
                        style: TextStyle(fontSize: 20.0),),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Address'),
                  style: TextStyle(fontSize: 25.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'City'),
                  style: TextStyle(fontSize: 25.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Country'),
                  style: TextStyle(fontSize: 25.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 35.0),
                child: Text(
                  'Beds',
                  style: TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                  padding: const  EdgeInsets.fromLTRB(15, 25, 15, 0),
              child: Column(
                children: const [
                  FacilitiesWidget(
                      type: 'Twins/Single', startValue: 0),
                  FacilitiesWidget(type: 'Double', startValue: 0),
                  FacilitiesWidget(
                      type: 'Queen/King', startValue: 0),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 35.0),
              child: Text(
                'Baths',
                style: TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 25, 15, 0),
              child: Column(
                children: const [
                  FacilitiesWidget(type: 'Half', startValue: 0),
                  FacilitiesWidget(type: 'Full', startValue: 0),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: 'Amenities (Comma separated)'),
                style: TextStyle(fontSize: 15.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 35.0),
              child: Text(
                'Images',
                style: TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 25.0, bottom: 25.0),
                child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: 2,
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 25,
                      crossAxisSpacing: 25,
                      childAspectRatio: 3 / 2,
                    ),
                    itemBuilder: (context, index) {
                      if (index == 1) {
                        return IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.add),
                        );
                      }
                      return MaterialButton(
                        onPressed: () {},
                        child: Image(
                          image: AssetImage(
                              'assets/images/apartment.jpg'),
                          fit: BoxFit.fitHeight,
                        ),
                      );
                    })),
            ]),
      ),
      ],
    ),)
    ,
    )
    ,
    )
    ,
    );
  }
}

class FacilitiesWidget extends StatefulWidget {
  final String type;
  final int startValue;

  const FacilitiesWidget(
      {Key? key, required this.type, required this.startValue})
      : super(key: key);

  @override
  _FacilitiesWidgetState createState() => _FacilitiesWidgetState();
}

class _FacilitiesWidgetState extends State<FacilitiesWidget> {
  late int _value;

  @override
  void initState() {
    _value = widget.startValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.type,
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.remove),
            ),
            Text(
              _value.toString(),
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.add),
            ),
          ],
        ),
      ],
    );
  }
}
