import 'dart:io';
import 'package:closet_control/providers/clothes_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditClothingPage extends StatefulWidget {
  final String id;
  final File image;
  final String type;
  final String brand;
  final String size;
  final Color color;
  final int price;
  final String note;

  const EditClothingPage(
      {super.key,
      required this.id,
      required this.image,
      required this.type,
      required this.brand,
      required this.size,
      required this.color,
      required this.price,
      required this.note});

  @override
  State<EditClothingPage> createState() => _EditClothingPageState();
}

class _EditClothingPageState extends State<EditClothingPage> {
  String? _idValue;
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _idValue = widget.id;
    _selectedImage = widget.image;
    _typeValue = widget.type;
    _brandController.text = widget.brand;
    _sizeValue = widget.size;
    _colorValue = widget.color;
    _priceController.text = widget.price.toString();
    _noteController.text = widget.note;
  }

  final _formKey = GlobalKey<FormState>();
  File? _selectedImage;

  /// Returns an image selected from the devices gallery.
  Future _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage != null) {
      setState(() {
        _selectedImage = File(returnedImage.path);
      });
    }
  }

  /// Returns an image taken with the camera.
  Future _pickImageFromCamera() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnedImage != null) {
      setState(() {
        _selectedImage = File(returnedImage.path);
      });
    }
  }

  String? _typeValue;
  final List<Map<String, dynamic>> typeOptions = [
    {'value': 'Oberteil', 'label': 'Oberteil'},
    {'value': 'Hose', 'label': 'Hose'},
    {'value': 'Schuhe', 'label': 'Schuhe'},
    {'value': 'Accessoire', 'label': 'Accessoire'},
  ];

  Color? _colorValue;
  final List<Map<String, dynamic>> colorOptions = [
    {'value': Colors.white, 'label': 'Weiß', 'textColor': Colors.black},
    {'value': Colors.black, 'label': 'Schwarz', 'textColor': Colors.black},
    {'value': Colors.red, 'label': 'Rot', 'textColor': Colors.red},
    {'value': Colors.purple, 'label': 'Lila', 'textColor': Colors.purple},
    {'value': Colors.pink, 'label': 'Pink', 'textColor': Colors.pink},
    {'value': Colors.blue, 'label': 'Blau', 'textColor': Colors.blue},
    {'value': Colors.teal, 'label': 'Türkis', 'textColor': Colors.teal},
    {'value': Colors.green, 'label': 'Grün', 'textColor': Colors.green},
    {'value': Colors.yellow, 'label': 'Gelb', 'textColor': Colors.yellow},
    {'value': Colors.orange, 'label': 'Orange', 'textColor': Colors.orange},
  ];

  String? _sizeValue;
  final List<Map<String, dynamic>> sizeOptions = [
    {'value': 'XS', 'label': 'XS'},
    {'value': 'S', 'label': 'S'},
    {'value': 'M', 'label': 'M'},
    {'value': 'L', 'label': 'L'},
    {'value': 'XL', 'label': 'XL'},
    {'value': 'XXL', 'label': 'XXL'},
  ];

  /// Shows a dialog to confirm the deletion of a clothing item.
  Future<void> _showDeleteDialog() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Willst Du das Kleidungsstück wirklich löschen?'),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Nein')),
              TextButton(
                  onPressed: () {
                    context
                        .read<ClothesProvider>()
                        .deleteClothing(id: _idValue!);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: const Text('Ja'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Neues Kleidungsstück',
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.bold),
                    ),
                    PopupMenuButton(
                        itemBuilder: (context) => [
                              PopupMenuItem(
                                child: const Text('Verkaufen'),
                                onTap: () {},
                              ),
                              PopupMenuItem(
                                child: const Text('Löschen'),
                                onTap: () {
                                  _showDeleteDialog();
                                },
                              ),
                            ])
                  ],
                ),
                TextButton(
                    onPressed: _pickImageFromGallery,
                    child: const Text('Gallery')),
                TextButton(
                    onPressed: _pickImageFromCamera,
                    child: const Text('Camera')),
                _selectedImage != null
                    ? Image.file(
                        height: 150.h,
                        width: 200.w,
                        _selectedImage!,
                        fit: BoxFit.contain,
                      )
                    : const Text('Please select an image'),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 8.h, 0, 8.h),
                    child: Column(
                      children: [
                        DropdownButtonFormField<String>(
                          value: _typeValue,
                          items: typeOptions.map((typeOption) {
                            return DropdownMenuItem<String>(
                              value: typeOption['value'],
                              child: Text(
                                typeOption['label'],
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newType) {
                            setState(() {
                              _typeValue = newType;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Bitte Typ auswählen!';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Typ',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.checkroom),
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        TextFormField(
                          controller: _brandController,
                          decoration: const InputDecoration(
                              labelText: 'Marke',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.business)),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Bitte Marke eingeben!';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        DropdownButtonFormField<String>(
                          value: _sizeValue,
                          items: sizeOptions.map((sizeOption) {
                            return DropdownMenuItem<String>(
                                value: sizeOption['value'],
                                child: Text(sizeOption['label']));
                          }).toList(),
                          onChanged: (String? newSize) {
                            setState(() {
                              _sizeValue = newSize;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Bitte Größe auswählen!';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Größe',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.straighten),
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        DropdownButtonFormField<Color>(
                          value: _colorValue,
                          items: colorOptions.map((colorOption) {
                            return DropdownMenuItem<Color>(
                              value: colorOption['value'],
                              child: Text(
                                colorOption['label'],
                                style: TextStyle(
                                    color: colorOption['textColor'] ??
                                        Colors.black),
                              ),
                            );
                          }).toList(),
                          onChanged: (Color? newColor) {
                            setState(() {
                              _colorValue = newColor;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Bitte Farbe auswaählen!';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Farbe',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.color_lens),
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        TextFormField(
                          controller: _priceController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              labelText: 'Preis',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.euro)),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Bitte Preis eingeben!';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        TextFormField(
                          controller: _noteController,
                          decoration: const InputDecoration(
                              labelText: 'Notiz',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.note)),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        TextButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate() &&
                                  _selectedImage != null) {
                                context.read<ClothesProvider>().editClothing(
                                    id: _idValue!,
                                    image: _selectedImage!,
                                    type: _typeValue!,
                                    brand: _brandController.text,
                                    size: _sizeValue!,
                                    color: _colorValue!,
                                    price: int.parse(_priceController.text),
                                    note: _noteController.text);
                                Navigator.pop(context);
                              }
                            },
                            child: const Text('Abschicken'))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    ));
  }
}
