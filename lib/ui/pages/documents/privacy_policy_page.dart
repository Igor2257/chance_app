import 'package:chance_app/ux/repository/files_repository.dart';
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({super.key});

  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  final _repository = FilesRepository();
  late final PdfController _pdfController;

  @override
  void initState() {
    super.initState();
    _pdfController = PdfController(
      document: PdfDocument.openData(_repository.getPrivacyPolicy()),
    );
  }

  @override
  void dispose() {
    _pdfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Політика конфіденційності"),
      ),
      body: SafeArea(
        child: PdfView(
          controller: _pdfController,
          pageSnapping: false,
          scrollDirection: Axis.vertical,
          physics: const RangeMaintainingScrollPhysics(),
        ),
      ),
    );
  }
}
