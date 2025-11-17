import 'dart:typed_data';

import 'package:association_appli/domain/entities/member_entity.dart';

abstract class PdfGeneratorServices {
  Future<Uint8List> generateMembersPdf({required List<MemberEntity> members});
  Future<Uint8List> generateMembersPdfByCategory({required String category});
}
