// ignore_for_file: prefer_const_constructors, prefer_const_declarations

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:room_sharing/Models/app_constants.dart';
import 'package:room_sharing/Models/posting_model.dart';
import 'package:room_sharing/Screens/host_home_page.dart';
import 'package:room_sharing/Screens/my_postings_page.dart';
import 'package:room_sharing/Views/text_widgets.dart';

class CreatePostingPage extends StatefulWidget {
  static final String routeName = '/CreatePostingPageRoute';
  final Posting? posting;

  const CreatePostingPage({Key? key, required this.posting}) : super(key: key);

  @override
  _CreatePostingPageState createState() => _CreatePostingPageState();
}

class _CreatePostingPageState extends State<CreatePostingPage> {
  final _formKey = GlobalKey<FormState>();
  late String _houseType;

  final List<String> _houseTypes = [
    'Detached House',
    'Apartment',
    'Condo',
    'Townhouse'
  ];
  Map<String, int> _beds = {};
  Map<String, int> _baths = {};
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
      _houseType = widget.posting!.type;
    }
    setState(() {});
  }

  void _selectImage(int index) async {
    ImagePicker imagePicker = ImagePicker();
    var imageFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      MemoryImage newImage = MemoryImage(await imageFile.readAsBytes());
      setState(() {
        if (index < 0) {
          _images.add(newImage);
        } else {
          _images[index] = newImage;
        }
      });
    }
  }

  void _savePosting() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    if (_houseType == null) {
      return;
    }
    if (_images.isEmpty) {
      return;
    }
    Posting posting = Posting();
    posting.name = _nameController.text;
    posting.price = double.parse(_priceController.text);
    posting.description = _descriptionController.text;
    posting.address = _addressController.text;
    posting.city = _cityController.text;
    posting.country = _countryController.text;
    posting.amenities = _amenitiesController.text.split(',');

    posting.type = _houseType;
    posting.beds = _beds;
    posting.baths = _baths;
    posting.displayImages = _images;
    posting.host = AppConstants.currentUser.createContactFromUser();
    posting.setImageNames();

    if (widget.posting == null) {
      posting.rating = 2.5;
      posting.bookings = [];
      posting.reviews = [];
      posting.addPostingInfoToFirestore().whenComplete(() {
        posting.addImagesToFirestore().whenComplete(() {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HostHomePage(
                        index: 1,
                      )));
        });
      });
    } else {
      posting.rating = widget.posting!.rating;
      posting.bookings = widget.posting!.bookings;
      posting.reviews = widget.posting!.reviews;
      posting.id = widget.posting!.id;
      for (int i = 0; i < AppConstants.currentUser.myPostings.length; i++) {
        if (AppConstants.currentUser.myPostings[i].id == posting.id) {
          AppConstants.currentUser.myPostings[i] = posting;
          break;
        }
      }
      posting.updatePostingInfoInFirestore().whenComplete(() {
        posting.addImagesToFirestore().whenComplete(() {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HostHomePage(
                        index: 1,
                      )));
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarText(text: 'Create a Posting'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.clear)),
          IconButton(onPressed: _savePosting, icon: Icon(Icons.save))
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
                  key: _formKey,
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
                            validator: (text) {
                              if (text!.isEmpty) {
                                return "Please enter a Posting name";
                              }
                              return null;
                            },
                            textCapitalization: TextCapitalization.words,
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
                              onChanged: (value) {
                                setState(() {
                                  _houseType = value.toString();
                                });
                              },
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
                                  validator: (text) {
                                    if (text!.isEmpty) {
                                      return "Please enter a price";
                                    }
                                    return null;
                                  },
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
                            decoration:
                                InputDecoration(labelText: 'Description'),
                            style: TextStyle(fontSize: 25.0),
                            maxLines: 3,
                            minLines: 1,
                            controller: _descriptionController,
                            validator: (text) {
                              if (text!.isEmpty) {
                                return "Please enter a Description";
                              }
                              return null;
                            },
                            textCapitalization: TextCapitalization.sentences,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 25.0),
                          child: TextFormField(
                            decoration: InputDecoration(labelText: 'Address'),
                            style: TextStyle(fontSize: 25.0),
                            controller: _addressController,
                            validator: (text) {
                              if (text!.isEmpty) {
                                return "Please enter a address";
                              }
                              return null;
                            },
                            textCapitalization: TextCapitalization.words,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 25.0),
                          child: TextFormField(
                            decoration: InputDecoration(labelText: 'City'),
                            style: TextStyle(fontSize: 25.0),
                            controller: _cityController,
                            validator: (text) {
                              if (text!.isEmpty) {
                                return "Please enter a city";
                              }
                              return null;
                            },
                            textCapitalization: TextCapitalization.words,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 25.0),
                          child: TextFormField(
                            decoration: InputDecoration(labelText: 'Country'),
                            style: TextStyle(fontSize: 25.0),
                            controller: _countryController,
                            validator: (text) {
                              if (text!.isEmpty) {
                                return "Please enter a Country";
                              }
                              return null;
                            },
                            textCapitalization: TextCapitalization.words,
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
                                startValue: _beds['small']!,
                                decreaseValue: () {
                                  _beds["small"] = _beds["small"]! - 1;
                                  if (_beds["small"] == 0) {
                                    _beds["small"] = 0;
                                  }
                                },
                                increaseValue: () {
                                  _beds["small"] = _beds["small"]! + 1;
                                },
                              ),
                              FacilitiesWidget(
                                type: 'Double',
                                startValue: _beds['medium']!,
                                decreaseValue: () {
                                  _beds["medium"] = _beds["medium"]! - 1;
                                  if (_beds["medium"] == 0) {
                                    _beds["medium"] = 0;
                                  }
                                },
                                increaseValue: () {
                                  _beds["medium"] = _beds["medium"]! + 1;
                                },
                              ),
                              FacilitiesWidget(
                                type: 'Queen/King',
                                startValue: _beds['large']!,
                                decreaseValue: () {
                                  _beds["large"] = _beds["large"]! - 1;
                                  if (_beds["large"] == 0) {
                                    _beds["large"] = 0;
                                  }
                                },
                                increaseValue: () {
                                  _beds["large"] = _beds["large"]! + 1;
                                },
                              ),
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
                                type: 'Half',
                                startValue: _baths['half']!,
                                decreaseValue: () {
                                  _baths['half'] = _baths['half']! - 1;
                                  if (_baths['half'] == 0) {
                                    _baths['half'] = 0;
                                  }
                                },
                                increaseValue: () {
                                  _baths['half'] = _baths['half']! + 1;
                                },
                              ),
                              FacilitiesWidget(
                                type: 'Full',
                                startValue: _baths['full']!,
                                decreaseValue: () {
                                  _baths['full'] = _baths['full']! - 1;
                                  if (_baths['full'] == 0) {
                                    _baths['full'] = 0;
                                  }
                                },
                                increaseValue: () {
                                  _baths['full'] = _baths['full']! + 1;
                                },
                              ),
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
                            validator: (text) {
                              if (text!.isEmpty) {
                                return "Please enter some amenities (comma separated)";
                              }
                              return null;
                            },
                            textCapitalization: TextCapitalization.words,
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
                                      onPressed: () {
                                        _selectImage(-1);
                                      },
                                      icon: Icon(Icons.add),
                                    );
                                  }
                                  return MaterialButton(
                                    onPressed: () {
                                      _selectImage(index);
                                    },
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
  final Function decreaseValue;
  final Function increaseValue;
  const FacilitiesWidget({
    Key? key,
    required this.type,
    required this.startValue,
    required this.decreaseValue,
    required this.increaseValue,
  }) : super(key: key);

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
              onPressed: () {
                widget.decreaseValue();
                setState(() {
                  _value--;
                  if (_value < 0) {
                    _value = 0;
                  }
                });
              },
              icon: Icon(Icons.remove),
            ),
            Text(
              _value.toString(),
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            IconButton(
              onPressed: () {
                widget.increaseValue();
                setState(() {
                  _value++;
                });
              },
              icon: Icon(Icons.add),
            ),
          ],
        ),
      ],
    );
  }
}
