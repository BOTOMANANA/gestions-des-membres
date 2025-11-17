import 'dart:typed_data';

import 'package:association_appli/core/errors/failure.dart';
import 'package:association_appli/domain/repositories/member_repository.dart';
import 'package:association_appli/domain/services/pdf_generator_services.dart';
import 'package:dartz/dartz.dart';

class GenerateMembersPdfByCategoryUsecase {
  final MemberRepository repository;
  final PdfGeneratorServices pdfGenerator;

  GenerateMembersPdfByCategoryUsecase({
    required this.repository,
    required this.pdfGenerator,
  });

  Future<Either<Failure, Uint8List>> call({required String category}) async {
    final result = await repository.getMembersByStatusRepository(
      memberCategory: category,
    );

    return result.fold((failure) => Left(failure), (members) async {
      try {
        final pdfBytes = await pdfGenerator.generateMembersPdfByCategory(
          category: category,
        );
        return Right(pdfBytes);
      } catch (e) {
        return Left(
          PdfFailure(errorMessage: "Erreur lors de la génération du PDF : $e"),
        );
      }
    });
  }
}
