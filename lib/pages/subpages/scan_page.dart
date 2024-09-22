import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as html;

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  List<CameraDescription>? _cameras;
  CameraController? controller;
  var _subscription;
  Future<void>? _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    _initializeControllerFuture = loadCamera(); // Initialisation du Future
  }

  Future<void> loadCamera() async {
    try {
      _cameras = await availableCameras();
      controller = CameraController(_cameras![0], ResolutionPreset.max, enableAudio: false);
      await controller!.initialize(); // Utilisation de await pour attendre l'initialisation
    } catch (e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            log(e.description.toString());
            // Gérer les erreurs d'accès à la caméra
            break;
          default:
            log(e.description.toString());
            // Gérer d'autres erreurs
            break;
        }
      }
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 1.5,
          height: MediaQuery.of(context).size.width / 1.5,
          child: FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (controller != null && controller!.value.isInitialized) {
                  return Stack(children: [
                    CameraPreview(controller!),
                  ]);
                } else {
                  return Center(
                    child: Column(
                      children: [
                        const Text(
                          'Caméra non disponible',
                          style: TextStyle(fontSize: 18),
                        ),
                        ElevatedButton(
                          child: const Text("Request permission"),
                          onPressed: () async {
                            final perm = await html.window.navigator.permissions?.query({"name": "camera"});
                            if (perm?.state == "denied") {
                              return;
                            }
                            final stream = await html.window.navigator.getUserMedia(video: true, audio: false);
                          },
                        ),
                      ],
                    ),
                  );
                }
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Erreur: ${snapshot.error}',
                    style: const TextStyle(fontSize: 18),
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
