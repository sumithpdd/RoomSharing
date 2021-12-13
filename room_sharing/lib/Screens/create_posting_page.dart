// ignore_for_file: prefer_const_constructors, prefer_const_declarations

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:room_sharing/Models/posting_model.dart';
import 'package:room_sharing/Views/text_widgets.dart';

class CreatePostingPage extends StatefulWidget {
  static final String routeName = '/CreatePostingPageRoute';
  final Posting? posting;

  const CreatePostingPage({Key? key, required this.posting}) : super(key: key);

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
  late Map<String, int> _beds;
  late Map<String, int> _baths;
  late List<MemoryImage> _images;

  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _descriptionController;
  late TextEditingController _addressController;
  late TextEditingController _cityController;
  late TextEditingController _countryController;
  late TextEditingController _amenitiesController;

  @override
  void initState() {
    _setupInitialValues();
    _houseType = _houseTypes[0];

    super.initState();
  }

  void _setupInitialValues() {
    if (widget.posting == null) {
      _nameController = TextEditingController();
      _priceController = TextEditingController();
      _descriptionController = TextEditingController();
      _addressController = TextEditingController();
      _cityController = TextEditingController();
      _countryController = TextEditingController();
      _amenitiesController = TextEditingController();
      _beds = {
        'small': 0,
        'medium': 0,
        'large': 0,
      };
      _baths = {
        'full': 0,
        'half': 0,
      };
      _images = [];
    } else {
      _nameController = TextEditingController(text: widget.posting!.name);
      _priceController =
          TextEditingController(text: widget.posting!.price.toString());
      _descriptionController =
          TextEditingController(text: widget.posting!.description);
      _addressController = TextEditingController(text: widget.posting!.address);
      _cityController = TextEditingController(text: widget.posting!.city);
      _countryController = TextEditingController(text: widget.posting!.country);
      _amenitiesController =
          TextEditingController(text: widget.posting!.getAmenitiesString());
      _beds = widget.posting!.beds;
      _baths = widget.posting!.baths;
      _images = widget.posting!.displayImages;
    }
    setState(() {});
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
                            controller: _nameController,
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
                                  controller: _priceController,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, bottom: 15.0),
                                child: Text(
                                  '\$ / night',
                                  style: TextStyle(fontSize: 20.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 25.0),
                          child: TextFormField(
                            decoration: InputDecoration(labelText: 'Address'),
                            style: TextStyle(fontSize: 25.0),
                            controller: _addressController,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 25.0),
                          child: TextFormField(
                            decoration: InputDecoration(labelText: 'City'),
                            style: TextStyle(fontSize: 25.0),
                            controller: _cityController,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 25.0),
                          child: TextFormField(
                            decoration: InputDecoration(labelText: 'Country'),
                            style: TextStyle(fontSize: 25.0),
                            controller: _countryController,
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
                          padding: const EdgeInsets.fromLTRB(15, 25, 15, 0),
                          child: Column(
                            children: [
                              FacilitiesWidget(
                                  type: 'Twins/Single',
                                  startValue: _beds['small']!),
                              FacilitiesWidget(
                                  type: 'Double', startValue: _beds['medium']!),
                              FacilitiesWidget(
                                  type: 'Queen/King',
                                  startValue: _beds['large']!),
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
                            children: [
                              FacilitiesWidget(
                                  type: 'Half', startValue: _baths['half']!),
                              FacilitiesWidget(
                                  type: 'Full', startValue: _baths['full']!),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 25.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Amenities (Comma separated)'),
                            style: TextStyle(fontSize: 15.0),
                            controller: _amenitiesController,
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
                            padding:
                                const EdgeInsets.only(top: 25.0, bottom: 25.0),
                            child: GridView.builder(
                                shrinkWrap: true,
                                itemCount: _images.length + 1,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 25,
                                  crossAxisSpacing: 25,
                                  childAspectRatio: 3 / 2,
                                ),
                                itemBuilder: (context, index) {
                                  if (index == _images.length) {
                                    return IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.add),
                                    );
                                  }
                                  return MaterialButton(
                                    onPressed: () {},
                                    child: Image(
                                      image: _images[index],
                                      fit: BoxFit.fitHeight,
                                    ),
                                  );
                                })),
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),
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
