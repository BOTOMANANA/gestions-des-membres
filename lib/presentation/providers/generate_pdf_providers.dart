import 'dart:io';
import 'dart:typed_data';

import 'package:association_appli/domain/usecases/service_usecase/generate_member_pdf_usecase.dart';
import 'package:association_appli/domain/usecases/service_usecase/generate_members_pdf_by_category_usecase.dart';
import 'package:flutter/material.dart';

class GeneratePdfProviders extends ChangeNotifier {
  final GenerateMembersPdfUseCase generateMembersPdfUsecase;
  final GenerateMembersPdfByCategoryUsecase generateMembersPdfByCategoryUsecase;

  GeneratePdfProviders({
    required this.generateMembersPdfUsecase,
    required this.generateMembersPdfByCategoryUsecase,
  });

  void generateAllMembersPdf() async {
    final result = await generateMembersPdfUsecase();
    result.fold(
      (failure) {
        notifyListeners();
      },
      (pdfBytes) async {
        writePdfInFile(pdfBytes: pdfBytes, pdfName: 'members');
        // print('==========>>>>>>>>> pdf is generate <<<<<<<<<<============');
      },
    );
  }

  void generatePdfMembersByCategory({required String category}) async {
    final result = await generateMembersPdfByCategoryUsecase(
      category: category,
    );
    result.fold(
      (failure) {
        notifyListeners();
      },
      (pdfBytes) async {
        writePdfInFile(pdfBytes: pdfBytes, pdfName: category);
      },
    );
  }

  void writePdfInFile({
    required Uint8List pdfBytes,
    required String pdfName,
  }) async {
    final pdfPath = '/storage/emulated/0/Download/$pdfName.pdf';
    final file = File(pdfPath);
    await file.writeAsBytes(pdfBytes);
    notifyListeners();
  }
}
