// lib/services/reservation_pdf_service.dart

import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class ReservationPdfService {
  /// Genera el PDF con los datos de la reserva y lo guarda / comparte.
  Future<void> saveAndShare({
    required String hotelName,
    required int roomNumber,
    required int adults,
    required int children,
    required DateTime checkIn,
    required DateTime checkOut,
    required double pricePerNight,
    required List<Map<String, dynamic>> guests,
    required int starsAwarded,
    required int totalStars,
  }) async {
    final Uint8List pdfBytes = await _buildPdf(
      hotelName: hotelName,
      roomNumber: roomNumber,
      adults: adults,
      children: children,
      checkIn: checkIn,
      checkOut: checkOut,
      pricePerNight: pricePerNight,
      guests: guests,
      starsAwarded: starsAwarded,
      totalStars: totalStars,
    );

    /// Abre el diálogo nativo de impresión / guardar / compartir
    await Printing.sharePdf(
      bytes: pdfBytes,
      filename: 'reserva_${hotelName.replaceAll(' ', '_')}.pdf',
    );
  }

  Future<Uint8List> _buildPdf({
    required String hotelName,
    required int roomNumber,
    required int adults,
    required int children,
    required DateTime checkIn,
    required DateTime checkOut,
    required double pricePerNight,
    required List<Map<String, dynamic>> guests,
    required int starsAwarded,
    required int totalStars,
  }) async {
    final pdf  = pw.Document();
    final font = await PdfGoogleFonts.nunitoRegular();
    final bold = await PdfGoogleFonts.nunitoBold();

    final nights = checkOut.difference(checkIn).inDays;
    final total  = nights * pricePerNight;

    final headerColor  = PdfColor.fromHex('DDBE5C');
    final accentColor  = PdfColor.fromHex('6CB4EE');
    final bgColor      = PdfColor.fromHex('F7F2EC');
    final starColor    = PdfColor.fromHex('F9A825');

    String fmtDate(DateTime d) => '${d.day.toString().padLeft(2,'0')}/${d.month.toString().padLeft(2,'0')}/${d.year}';

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [

            // ── Cabecera ──────────────────────────────────────────────
            pw.Container(
              width: double.infinity,
              padding: const pw.EdgeInsets.symmetric(vertical: 14, horizontal: 20),
              decoration: pw.BoxDecoration(
                color: headerColor,
                borderRadius: pw.BorderRadius.circular(12),
              ),
              child: pw.Center(
                child: pw.Text(
                  'COMPROBANTE DE RESERVA',
                  style: pw.TextStyle(font: bold, fontSize: 20, color: PdfColors.white),
                ),
              ),
            ),

            pw.SizedBox(height: 24),

            // ── Resumen de reserva ────────────────────────────────────
            _section(
              title: 'RESUMEN RESERVA',
              accentColor: accentColor,
              bgColor: bgColor,
              bold: bold,
              font: font,
              rows: [
                _row('Hotel',              hotelName,                            bold, font),
                _row('Número habitación',  '$roomNumber',                        bold, font),
                _row('Adultos',            '$adults',                            bold, font),
                _row('Infantes',           '$children',                          bold, font),
                _row('Check-in',           fmtDate(checkIn),                     bold, font),
                _row('Check-out',          fmtDate(checkOut),                    bold, font),
                _row('Precio por noche',   '\$${pricePerNight.toStringAsFixed(2)}', bold, font),
                _row('Noches',             '$nights',                            bold, font),
                _row('Total',              '\$${total.toStringAsFixed(2)}',      bold, font),
              ],
            ),

            pw.SizedBox(height: 16),

            // ── Invitados ─────────────────────────────────────────────
            _section(
              title: 'INFORMACIÓN INVITADOS',
              accentColor: accentColor,
              bgColor: bgColor,
              bold: bold,
              font: font,
              rows: guests.asMap().entries.map((e) {
                final g = e.value;
                return _row(
                  'Inv. ${e.key + 1}',
                  '${g['name']} ${g['lastName'] ?? ''} (${g['age']} años)',
                  bold,
                  font,
                );
              }).toList(),
            ),

            pw.SizedBox(height: 16),

            // ── Estrellas ─────────────────────────────────────────────
            pw.Container(
              width: double.infinity,
              padding: const pw.EdgeInsets.all(14),
              decoration: pw.BoxDecoration(
                color: PdfColor.fromHex('FFF8E1'),
                borderRadius: pw.BorderRadius.circular(10),
                border: pw.Border.all(color: starColor, width: 1.5),
              ),
              child: pw.Row(
                children: [
                  pw.Text('★ ', style: pw.TextStyle(font: bold, fontSize: 16, color: starColor)),
                  pw.Text(
                    'Estrellas ganadas: +$starsAwarded   |   Total: $totalStars estrellas',
                    style: pw.TextStyle(font: bold, fontSize: 13, color: starColor),
                  ),
                ],
              ),
            ),

            pw.Spacer(),

            // ── Pie de página ─────────────────────────────────────────
            pw.Divider(color: PdfColors.grey300),
            pw.SizedBox(height: 6),
            pw.Center(
              child: pw.Text(
                'Hotel YA  •  Gracias por su reserva',
                style: pw.TextStyle(font: font, fontSize: 11, color: PdfColors.grey500),
              ),
            ),
          ],
        ),
      ),
    );

    return pdf.save();
  }

  // ── Helpers ────────────────────────────────────────────────────────────────

  pw.Widget _section({
    required String title,
    required PdfColor accentColor,
    required PdfColor bgColor,
    required pw.Font bold,
    required pw.Font font,
    required List<pw.Widget> rows,
  }) {
    return pw.Container(
      decoration: pw.BoxDecoration(
        color: bgColor,
        borderRadius: pw.BorderRadius.circular(10),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Container(
            width: double.infinity,
            padding: const pw.EdgeInsets.symmetric(vertical: 8, horizontal: 14),
            decoration: pw.BoxDecoration(
              color: accentColor,
              borderRadius: const pw.BorderRadius.only(
                topLeft: pw.Radius.circular(10),
                topRight: pw.Radius.circular(10),
              ),
            ),
            child: pw.Text(
              title,
              style: pw.TextStyle(font: bold, fontSize: 13, color: PdfColors.white),
            ),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(12),
            child: pw.Column(children: rows),
          ),
        ],
      ),
    );
  }

  pw.Widget _row(String label, String value, pw.Font bold, pw.Font font) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 3),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.SizedBox(
            width: 160,
            child: pw.Text('$label:', style: pw.TextStyle(font: bold, fontSize: 12)),
          ),
          pw.Expanded(
            child: pw.Text(value, style: pw.TextStyle(font: font, fontSize: 12)),
          ),
        ],
      ),
    );
  }
}
