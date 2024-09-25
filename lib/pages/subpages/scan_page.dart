import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanPage extends StatefulWidget {
  final void Function(String) event;

  const ScanPage({super.key, required this.event});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> with WidgetsBindingObserver {
  Barcode? _barcode;
  var controller = MobileScannerController();

  // Ajout d'un drapeau pour éviter les détections multiples
  bool isProcessing = false;

  Widget _buildBarcode(Barcode? value) {
    if (value == null) {
      return const Text(
        'Scan something!',
        overflow: TextOverflow.fade,
        style: TextStyle(color: Colors.white),
      );
    }

    return Text(
      value.displayValue ?? 'No display value.',
      overflow: TextOverflow.fade,
      style: const TextStyle(color: Colors.white),
    );
  }

  void _handleBarcode(BarcodeCapture barcodes) {
    if (!isProcessing && mounted) { // Vérifiez si une détection est déjà en cours
      setState(() {
        isProcessing = true; // Empêche d'autres détections
        _barcode = barcodes.barcodes.firstOrNull;
      });

      if (_barcode != null) {
        openRatingPage();
      } else {
        isProcessing = false; // Réinitialise si le code est nul
      }
    }
  }

  void openRatingPage() {
    if (_barcode?.rawValue != null && _barcode!.rawValue!.isNotEmpty) {
      log("Scan_page[54]: Open Rating page for : ${_barcode!.rawValue!}");
      widget.event(_barcode!.rawValue!);
      controller.stop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Aucun code valide scanné.")),
      );
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 1.5,
          height: MediaQuery.of(context).size.width / 1.5,
          child: MobileScanner(
            controller: controller,
            onDetect: _handleBarcode,
          ),
        ),
        if (_barcode != null) _buildBarcode(_barcode),
      ],
    );
  }
}
