import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:remercee/components/common/action_text.dart';
import 'package:remercee/utils/api_controller.dart';
import 'package:universal_html/html.dart';

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

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    imageUrl = imageUrl ?? widget.user.imageUrl;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05 / 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 15,
                width: width * 0.95,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ActionText(text: "Annuler"),
                    Text("Edition"),
                    ActionText(text: "Enregistrer"),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
              ),
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
                            child: Image.network(widget.user.imageUrl),
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
                                            log("Body : $responseBody");
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
              SizedBox(
                height: MediaQuery.of(context).size.height / 40,
              ),
              Text(
                widget.user.username,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.5,
                height: MediaQuery.of(context).size.height / 10,
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
