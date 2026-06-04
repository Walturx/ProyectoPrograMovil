// lib/pages/payment_details/payment_qr_controller.dart

import 'package:get/get.dart';
import '../../services/profile_service.dart';
import '../../services/reservation_pdf_service.dart';

class PaymentQRController extends GetxController {
  final ProfileService        _profileService = ProfileService();
  final ReservationPdfService _pdfService     = ReservationPdfService();

  final RxInt  starsAwarded = 0.obs;
  final RxInt  totalStars   = 0.obs;
  final RxBool isLoading    = true.obs;
  final RxBool isSavingPdf  = false.obs;

  /// Garantiza que el snackbar solo se muestre una vez
  bool snackbarShown = false;

  void callAddStars(int stars) {
    if (starsAwarded.value != 0 || !isLoading.value) return;
    _addStars(stars);
  }

  Future<void> _addStars(int stars) async {
    try {
      isLoading.value = true;

      final response = await _profileService.addStars(stars);

      if (response.success && response.hasData) {
        starsAwarded.value = stars;
        totalStars.value   = response.data!.starsAvailable;
      } else {
        Get.snackbar('Error', 'No se pudieron sumar las estrellas');
      }
    } catch (e) {
      Get.snackbar('Error', 'Ocurrió un error inesperado');
    } finally {
      isLoading.value = false;
    }
  }

  /// Genera y comparte el PDF de la reserva
  Future<void> savePdf({
    required String hotelName,
    required int roomNumber,
    required int adults,
    required int children,
    required DateTime checkIn,
    required DateTime checkOut,
    required double pricePerNight,
    required List<Map<String, dynamic>> guests,
  }) async {
    try {
      isSavingPdf.value = true;

      await _pdfService.saveAndShare(
        hotelName:     hotelName,
        roomNumber:    roomNumber,
        adults:        adults,
        children:      children,
        checkIn:       checkIn,
        checkOut:      checkOut,
        pricePerNight: pricePerNight,
        guests:        guests,
        starsAwarded:  starsAwarded.value,
        totalStars:    totalStars.value,
      );
    } catch (e) {
      Get.snackbar('Error', 'No se pudo guardar el PDF');
    } finally {
      isSavingPdf.value = false;
    }
  }
}