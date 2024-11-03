import 'dart:developer';
import 'dart:typed_data';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:remercee/components/common/action_text.dart';
import 'package:remercee/utils/api_controller.dart';
import 'package:universal_html/html.dart';

import '../components/work_place_popup.dart';
import '../models/user_model.dart';

class EditPage extends StatefulWidget {
  final User user;

  const EditPage({Key? key, required this.user}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  var controller = TextEditingController(text: "test");
  String? imageUrl;
  Uint8List? newImage; // Variable pour stocker temporairement l'image
  late final List<String> workPlaces;
  late User tempUser;

  @override
  void initState() {
    super.initState();
    tempUser = widget.user.copyWith();
    imageUrl = tempUser.imageUrl;
    workPlaces = tempUser.workPlaces.map((e) => e.toString()).toList();
  }

  void addWorkPlace(String newWorkPlace) {
    setState(() {
      workPlaces.add(newWorkPlace);
    });
    log(widget.user.workPlaces.toString());
  }

  Future<void> uploadImage() async {
    if (newImage != null) {
      var uri = Uri.parse("${ApiController.url}user/image");
      var request = http.MultipartRequest("POST", uri);
      request.fields['username'] = widget.user.username;

      request.files.add(http.MultipartFile.fromBytes(
        'image',
        newImage!,
        filename: 'profile_image.jpg', // Nom du fichier
      ));

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Image et username envoyés avec succès')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Échec de l\'envoi : ${response.statusCode}')),
        );
        log(responseBody);
      }
    }
  }

  void saveChanges() async {
    tempUser.workPlaces = workPlaces;
    await uploadImage();
    log(tempUser.workPlaces.toString());
    ApiController.setInfo(tempUser);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Modifications enregistrées avec succès')),
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05 / 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: height / 15,
                width: width * 0.95,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ActionText(
                      text: "Annuler",
                      onTap: () => Navigator.pop(context),
                    ),
                    const Text("Edition", style: TextStyle(fontSize: 25)),
                    ActionText(
                      text: "Enregistrer",
                      primary: true,
                      onTap: saveChanges,
                    ),
                  ],
                ),
              ),
              SizedBox(height: height / 20),
              SizedBox(
                width: width / 2,
                height: width / 2,
                child: Stack(
                  children: [
                    Hero(
                      tag: "profile_pic",
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(500),
                        child: newImage != null
                            ? Image.memory(
                          newImage!,
                          fit: BoxFit.cover,
                        )
                            : Image.network(
                          "${ApiController.url}user/image/${widget.user.imageUrl}",
                          errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                            return const Center(child: CircularProgressIndicator());
                          },
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      left: width / 2 - width / 6,
                      top: 0,
                      child: Container(
                        width: width / 6,
                        height: width / 6,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(
                          child: Container(
                            width: width / 7.5,
                            height: width / 7.5,
                            decoration: BoxDecoration(
                              color: const Color(0xFFBFCAD3),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: IconButton(
                              onPressed: () async {
                                final input = FileUploadInputElement()..accept = 'image/*';
                                input.click();
                                input.onChange.listen((e) {
                                  final file = input.files?.first;
                                  if (file != null) {
                                    final reader = FileReader();
                                    reader.readAsArrayBuffer(file);
                                    reader.onLoadEnd.listen((e) {
                                      setState(() {
                                        newImage = reader.result as Uint8List?;
                                      });
                                    });
                                  }
                                });
                              },
                              icon: const Icon(Icons.image_outlined, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height / 40),
              Text(
                widget.user.username,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: height / 80),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 150),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: workPlaces.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(workPlaces[index], textAlign: TextAlign.center),
                          trailing: IconButton(
                            icon: Icon(Icons.close, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                workPlaces.removeAt(index);
                                tempUser.workPlaces = workPlaces;
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AddWorkPlacePopup(onAddWorkPlace: addWorkPlace);
                        },
                      );
                    },
                    child: DottedBorder(
                      color: Color(0xFF808080),
                      strokeWidth: 2,
                      dashPattern: [15, 10],
                      borderType: BorderType.RRect,
                      radius: Radius.circular(100),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.add, color: Color(0xFF808080)),
                            SizedBox(width: 8),
                            Text(
                              'Ajouter un endroit de travail',
                              style: TextStyle(color: Color(0xFF808080), fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
              SizedBox(height: height / 40),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.5,
                height: height / 10,
                child: TextField(
                  textAlign: TextAlign.start,
                  textAlignVertical: TextAlignVertical.top,
                  maxLines: null,
                  expands: true,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    label: const Text("Description"),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFF808080)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  controller: controller,
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
