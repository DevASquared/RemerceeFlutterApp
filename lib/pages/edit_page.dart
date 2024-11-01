import 'dart:developer';

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
  late final List<String> workPlaces;

  @override
  void initState() {
    super.initState();
    workPlaces = widget.user.workPlaces.map((e) => e.toString()).toList();
  }

  void addWorkPlace(String newWorkPlace) {
    setState(() {
      workPlaces.add(newWorkPlace);
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    imageUrl = imageUrl ?? widget.user.imageUrl;
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
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ActionText(text: "Annuler"),
                    Text("Edition", style: TextStyle(fontSize: 25),),
                    ActionText(text: "Enregistrer", primary: true),
                  ],
                ),
              ),
              SizedBox(height: height / 20),
              Hero(
                tag: "profile_pic",
                child: SizedBox(
                  width: width / 2,
                  height: width / 2,
                  child: Stack(
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(500),
                          onTap: () async {},
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(500),
                            child: Image.network(
                              widget.user.imageUrl,
                              width: width / 2,
                              height: width / 2,
                              fit: BoxFit.cover,
                            ),
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
                              child: LayoutBuilder(builder: (context, constraints) {
                                return IconButton(
                                  onPressed: () async {
                                    final input = FileUploadInputElement()..accept = 'image/*';
                                    input.click();
                                    input.onChange.listen((e) {
                                      final file = input.files?.first;
                                      if (file != null) {
                                        final reader = FileReader();
                                        reader.readAsArrayBuffer(file);
                                        reader.onLoadEnd.listen((e) async {
                                          final data = reader.result;
                                          // Envoyer les données au serveur
                                          var uri = Uri.parse("${ApiController.url}user/image");
                                          var request = http.MultipartRequest("POST", uri);
                                          request.fields['username'] = widget.user.username;

                                          request.files.add(http.MultipartFile.fromBytes(
                                            'image',
                                            data as List<int>,
                                            filename: file.name,
                                          ));

                                          var response = await request.send();
                                          if (response.statusCode == 200) {
                                            var responseBody = await response.stream.bytesToString();
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(content: Text('Image et username envoyés avec succès')),
                                            );
                                          } else {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(content: Text('Échec de l\'envoi : ${response.statusCode}')),
                                            );
                                          }
                                        });
                                      }
                                    });
                                  },
                                  icon: Icon(Icons.image_outlined, color: Colors.white, size: constraints.biggest.width / 2),
                                );
                              }),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: height / 40),
              Text(
                widget.user.username,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: height / 80),
              Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: 150, // Hauteur maximale pour afficher environ 3 éléments
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: workPlaces.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(workPlaces[index], textAlign: TextAlign.center,),
                              trailing: IconButton(
                                icon: Icon(Icons.close, color: Colors.red),
                                onPressed: () {
                                  setState(() {
                                    workPlaces.removeAt(index); // Supprime l'élément
                                  });
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AddWorkPlacePopup(
                              onAddWorkPlace: addWorkPlace,
                            );
                          },
                        );
                      },
                      child: DottedBorder(
                        color: Color(0xFF808080), // Couleur des pointillés
                        strokeWidth: 2,
                        dashPattern: [15, 10], // Longueur des pointillés et de l'espace
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
