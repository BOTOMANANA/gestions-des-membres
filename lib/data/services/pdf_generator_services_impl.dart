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
          build: (context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                _buildPdfTitle(title: 'Listes des membres'),
                pw.SizedBox(height: 20),
                _buildPdfContent(pageData: pageData),
              ],
            );
          },
        ),
      );
    }
    return pdf.save();
  }

  pw.Row _buildPdfTitle({required String title}) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(
          title,
          style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold),
        ),
        _displayDateTime(),
      ],
    );
  }

  pw.Table _buildPdfContent({required List<MemberEntity> pageData}) {
    int memberCounter = 0;
    return pw.Table(
      border: pw.TableBorder.all(),
      children: [
        _buildHeaderContent(),
        ...pageData.map(
          (members) => pw.TableRow(
            children: [
              _cell("${memberCounter++}"),
              _cell(members.fullName),
              _cell(members.quarter),
              _cell('${members.phoneNumber}'),
              _cell(members.category ?? ""),
              _cell(''),
            ],
          ),
        ),
      ],
    );
  }

  pw.TableRow _buildHeaderContent() {
    return pw.TableRow(
      decoration: const pw.BoxDecoration(color: PdfColors.grey300),
      children: [
        _headerCell('N°'),
        _headerCell("Nom et prenom"),
        _headerCell('Adresse'),
        _headerCell("Contact"),
        _headerCell("Catégorie"),
        _headerCell("Signature"),
      ],
    );
  }

  pw.Text _displayDateTime() {
    final day = DateTime.now().day;
    final month = DateTime.now().month;
    final year = DateTime.now().year;

    return pw.Text(
      "$day/$month/$year",
      style: pw.TextStyle(fontSize: 10, color: PdfColors.grey600),
    );
  }

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
