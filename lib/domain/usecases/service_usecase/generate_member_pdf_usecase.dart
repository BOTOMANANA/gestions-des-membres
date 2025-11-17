import 'dart:typed_data';
import 'package:association_appli/domain/services/pdf_generator_services.dart';
import 'package:dartz/dartz.dart';

import 'package:association_appli/core/errors/failure.dart';
import 'package:association_appli/domain/repositories/member_repository.dart';

class GenerateMembersPdfUseCase {
  final MemberRepository repository;
  final PdfGeneratorServices pdfGenerator;

  GenerateMembersPdfUseCase({
    required this.repository,
    required this.pdfGenerator,
  });

  Future<Either<Failure, Uint8List>> call() async {
    final result = await repository.getMembersRepository();
    print('===========>>>>>>>>> generateMembersPdfUsecas');

    return result.fold((failure) => Left(failure), (members) async {
      try {
        final pdfBytes = await pdfGenerator.generateMembersPdf(
          members: members,
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
