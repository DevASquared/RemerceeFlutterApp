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
    if (mounted) {
      setState(() {
        _barcode = barcodes.barcodes.firstOrNull;
      });
      if (_barcode != null) openRatingPage();
    }
  }

  void openRatingPage() {
    if (_barcode?.rawValue != null && _barcode!.rawValue!.isNotEmpty) {
      widget.event(_barcode!.rawValue!);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Aucun code valide scanné.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 1.5,
          height: MediaQuery.of(context).size.width / 1.5,
          child: MobileScanner(
            onDetect: _handleBarcode,
          ),
        ),
      ],
    );
  }
}
