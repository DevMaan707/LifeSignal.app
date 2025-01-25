import 'package:cc_essentials/helpers/logging/logger.dart';
import 'package:get/get.dart';
import '../core/services/doctor_service.dart';
import '../models/doctor.dart';

class DoctorController extends GetxController {
  final _doctorService = DoctorService();

  RxList<Doctor> doctors = <Doctor>[].obs;
  RxBool isLoading = false.obs;

  Future<void> fetchDoctors() async {
    try {
      isLoading.value = true;
      final List<Doctor> fetchedDoctors = await _doctorService.getDoctors();
      doctors.assignAll(fetchedDoctors);
    } catch (e) {
      logger.e(e);
      Get.snackbar('Error', 'Failed to fetch doctors: \$e');
    } finally {
      isLoading.value = false;
    }
  }
}
