import 'dart:typed_data';
import 'package:association_appli/domain/services/pdf_generator_services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:association_appli/domain/entities/member_entity.dart';

class PdfGeneratorServicesImpl implements PdfGeneratorServices {
  @override
  Future<Uint8List> generateMembersPdf({
    required List<MemberEntity> members,
  }) async {
    final pdf = pw.Document();
    const int itemsPerPage = 25;

    final pages = <List<MemberEntity>>[];
    for (var i = 0; i < members.length; i += itemsPerPage) {
      pages.add(
        members.sublist(
          i,
          i + itemsPerPage > members.length ? members.length : i + itemsPerPage,
        ),
      );
    }
    for (var pageData in pages) {
      pdf.addPage(
        pw.Page(
          margin: const pw.EdgeInsets.all(24),
          build:
              (context) => pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  // ==== HEADER RÉPÉTÉ ====
                  pw.Text(
                    "Liste des membres",
                    style: pw.TextStyle(
                      fontSize: 22,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 20),

                  // ==== TABLE ====
                  pw.Table(
                    border: pw.TableBorder.all(),
                    children: [
                      // En-têtes répétés sur chaque page
                      _buildHeaderContent(),
                      // Contenu de la page
                      ...pageData.map(
                        (members) => pw.TableRow(
                          children: [
                            _cell(members.fullName),
                            _cell('${members.phoneNumber}'),
                            _cell(members.category ?? ""),
                            _cell(''),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
        ),
      );
    }
    return pdf.save();
  }

  pw.TableRow _buildHeaderContent() {
    return pw.TableRow(
      decoration: const pw.BoxDecoration(color: PdfColors.grey300),
      children: [
        _headerCell("Nom complet"),
        _headerCell("Téléphone"),
        _headerCell("Catégorie"),
        _headerCell("Null"),
      ],
    );
  }

  pw.Widget _displayDateTime() {
    return pw.Align(
      alignment: pw.Alignment.centerRight,
      child: pw.Text(
        "Généré automatiquement - ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
        style: pw.TextStyle(fontSize: 10, color: PdfColors.grey600),
      ),
    );
  }

  // ------------------------------------------------------------
  // ---- STYLE DES CELLULES TABLE ----
  // ------------------------------------------------------------
  pw.Widget _headerCell(String text) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(10),
      child: pw.Text(
        text,
        style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 12),
      ),
    );
  }

  pw.Widget _cell(String text) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(10),
      child: pw.Text(text, style: pw.TextStyle(fontSize: 11)),
    );
  }

  @override
  Future<Uint8List> generateMembersPdfByCategory({required String category}) {
    throw UnimplementedError();
  }
}
