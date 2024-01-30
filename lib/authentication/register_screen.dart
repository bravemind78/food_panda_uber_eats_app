// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, unused_field, sized_box_for_whitespace, unused_local_variable, avoid_print

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;
import 'package:flutter/material.dart';
import 'package:food_panda_uber_eats_app/widgets/customized_text_form_field.dart';
import 'package:food_panda_uber_eats_app/widgets/error_dialog.dart';
import 'package:food_panda_uber_eats_app/widgets/loading_dialog.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  /* -------------------------------------------------------------------------- */
  /*                            variables Definitions                           */
  /* -------------------------------------------------------------------------- */
  XFile? imageXFile;
  final ImagePicker _picker = ImagePicker();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Position? position;
  List<Placemark>? placeMarks;
/* ------------------ Define the Text Editing Controller Variables ------------------ */
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  /* -------------------------------------------------------------------------- */
  /* -------------------------------------------------------------------------- */
  /*                            function Definitions                            */
  /* -------------------------------------------------------------------------- */

  /* -------------------- Get Picture From Gallery Function ------------------- */
  Future<void> getPicFromGallery() async {
    imageXFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageXFile;
    });
  }
/* -------------------------------------------------------------------------- */

/* ---------------------- Get Current Location Function --------------------- */

  Future<void> getCurrentLocation() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      Position newPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      position = newPosition;
      placeMarks = await placemarkFromCoordinates(
          position!.latitude, position!.longitude);

      Placemark pMark = placeMarks![0];

      String completeAdress =
          '${pMark.subThoroughfare}  ${pMark.thoroughfare}, ${pMark.subLocality} ${pMark.locality}, ${pMark.administrativeArea} ${pMark.postalCode}';
      locationController.text = completeAdress;
    } else if (status.isDenied) {
      print('access denied');
    }
  }

  /* ------------------------ Form Validation  Function ----------------------- */

  Future<void> formValidation() async {
    if (imageXFile == null) {
      showDialog(
          context: context,
          builder: (context) => ErrorDialog(
                message: 'please upload your photo',
              ));
    } else {
      if (passwordController.text == confirmPasswordController.text) {
        if (passwordController.text.isNotEmpty &&
            nameController.text.isNotEmpty &&
            emailController.text.isNotEmpty &&
            phoneController.text.isNotEmpty &&
            locationController.text.isNotEmpty) {
          //upload your photo
          showDialog(
              context: context,
              builder: (context) => LoadingDialog(
                    message: 'Registering in Process',
                  )); //step1
          String fileName =
              DateTime.now().microsecondsSinceEpoch.toString(); // step2
          fStorage.Reference reference = fStorage.FirebaseStorage.instance
              .ref()
              .child("sellers")
              .child(fileName);  // step3
              
        } else {
          showDialog(
              context: context,
              builder: (context) => ErrorDialog(
                    message:
                        'Please write the complete required info for Registration.',
                  ));
        }
      } else {
        showDialog(
            context: context,
            builder: (context) => ErrorDialog(
                  message: 'passowrds did not match',
                ));
      }
    }
  }

  /* -------------------------------------------------------------------------- */
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          padding: EdgeInsets.all(8),
          width: double.infinity,
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  getPicFromGallery();
                },
                child: CircleAvatar(
                    radius: MediaQuery.of(context).size.width * 0.2,
                    backgroundColor: Colors.white,
                    backgroundImage: imageXFile == null
                        ? null
                        : FileImage(File(imageXFile!.path)),
                    child: imageXFile == null
                        ? Icon(
                            Icons.add_photo_alternate,
                            size: MediaQuery.of(context).size.width * 0.2,
                            color: Colors.grey,
                          )
                        : null),
              ),
              SizedBox(
                height: 20,
              ),
              Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      customizedFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          prefix: Icons.person,
                          label: 'Enter Your Name',
                          hintText: 'Name'),
                      customizedFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        prefix: Icons.email,
                        label: 'Enter Your Email',
                        hintText: 'Email',
                      ),
                      customizedFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          prefix: Icons.lock,
                          label: 'Enter password',
                          hintText: 'Password',
                          isPassword: true),
                      customizedFormField(
                          controller: confirmPasswordController,
                          type: TextInputType.visiblePassword,
                          prefix: Icons.lock,
                          label: 'Confirm password',
                          hintText: 'Confirm Password',
                          isPassword: true),
                      customizedFormField(
                          controller: phoneController,
                          type: TextInputType.number,
                          prefix: Icons.phone,
                          label: 'phone number',
                          hintText: 'Phone Number',
                          isPassword: true),
                      customizedFormField(
                          controller: locationController,
                          type: TextInputType.name,
                          prefix: Icons.my_location,
                          label: 'Cafe/Restaurant Address',
                          hintText: 'Cafe/Restaurant Address',
                          enable: false),
                      Container(
                        margin: EdgeInsets.all(10),
                        height: 50,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            getCurrentLocation();
                          },
                          icon: Icon(
                            Icons.location_on,
                            color: Color.fromARGB(255, 255, 129, 129),
                            size: 24,
                          ),
                          label: Text(
                            "Get My Current location",
                            style: TextStyle(fontSize: 16),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(146, 90, 104, 223)),
                            padding:
                                MaterialStateProperty.all(EdgeInsets.all(4)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12))),
                          ),
                        ),
                      ),
                    ],
                  )),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    formValidation();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.purple),
                    padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                  ),
                  child: Text(
                    "SignUp",
                    style: TextStyle(fontSize: 19),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          )),
    );
  }
}
