import 'dart:io';
import 'package:closet_control/providers/clothes_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddClothingPage extends StatefulWidget {
  const AddClothingPage({super.key});

  @override
  State<AddClothingPage> createState() => _AddClothingPageState();
}

class _AddClothingPageState extends State<AddClothingPage> {
  var uuid = const Uuid();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  File? _selectedImage;

  Future _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage != null) {
      setState(() {
        _selectedImage = File(returnedImage.path);
      });
    }
  }

  Future _pickImageFromCamera() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnedImage != null) {
      setState(() {
        _selectedImage = File(returnedImage.path);
      });
    }
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Neues Kleidungsstück',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              TextButton(
                  onPressed: _pickImageFromGallery,
                  child: const Text('Gallery')),
              TextButton(
                  onPressed: _pickImageFromCamera, child: const Text('Camera')),
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
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                            labelText: 'Name',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.checkroom)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Bitte Name eingegben!';
                          }
                          return null;
                        },
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
                      TextFormField(
                        controller: _sizeController,
                        decoration: const InputDecoration(
                            labelText: 'Größe',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.straighten)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Bitte Größe eingeben!';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      // const DropdownMenu(
                      //   label: Text('Farbe'),
                      //   dropdownMenuEntries: <DropdownMenuEntry<Color>>[
                      //     DropdownMenuEntry(value: Colors.white, label: 'Weiß'),
                      //     DropdownMenuEntry(
                      //         value: Colors.black, label: 'Schwarz'),
                      //   ],
                      // ),
                      // TODO fertig machen
                      TextFormField(
                        controller: _colorController,
                        decoration: InputDecoration(
                            labelText: 'Color',
                            border: const OutlineInputBorder(),
                            prefixIcon: const Icon(Icons.color_lens),
                            suffixIcon: DropdownButton<String>(
                              icon: const Icon(Icons.arrow_drop_down),
                              onChanged: (String? newValue) {},
                              items: [DropdownMenuItem(child: Text('Test'))],
                            )),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      TextFormField(
                        controller: _colorController,
                        decoration: const InputDecoration(
                            labelText: 'Farbe',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.color_lens)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Bitte Farbe eingeben!';
                          }
                          return null;
                        },
                      ),
                      TextButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate() &&
                                _selectedImage != null) {
                              context.read<ClothesProvider>().addClothing(
                                  id: uuid.v4(),
                                  image: _selectedImage!,
                                  name: _nameController.text,
                                  brand: _brandController.text,
                                  size: _sizeController.text,
                                  color: _colorController.text);
                              Navigator.pop(context);
                            }
                          },
                          child: const Text('Abschicken'))
                    ],
                  ),
                ),
              ),
            ],
          )),
    ));
  }
}
