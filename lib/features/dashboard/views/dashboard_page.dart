import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_doc/controllers/doctor_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../doctors/views/doctor_details_page.dart';
import '../../shared/views/web_view.dart';
import '../../shared/widgets/doctor_card.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DoctorController doctorController = Get.find();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView(
        children: [
          Text(
            'How Are You\nFeeling Today?',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text('Services',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildEmergencyButton('Book\nAmbulance', Icons.local_hospital),
            ],
          ),
          SizedBox(height: 16),
          Text(
            'Our Doctors',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8),
          Center(
            child: Obx(() {
              return (doctorController.isLoading.value)
                  ? CircularProgressIndicator()
                  : Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: doctorController.doctors.map((doctor) {
                        return DoctorCard(
                          doctor: doctor,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DoctorDetailsPage(doctor: doctor),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    );
            }),
          ),
        ],
      ),
    );
  }

  Future<void> launchurl({required String url}) async {
    try {
      Uri url_parsed = Uri.parse(url);
      if (await canLaunchUrl(url_parsed)) {
        await launchUrl(url_parsed);
      } else {}
    } catch (e) {
      print(e);
    }
  }

  Widget _buildEmergencyButton(String title, IconData icon) {
    return Expanded(
      child: InkWell(
        onTap: () async {
          if (title == "Book\nAmbulance") {
            Get.to(
              WebView(
                  url:
                      "https://0dc2-2401-4900-889d-b700-c1a5-f8ce-2e1a-376f.ngrok-free.app"),
            );
          }
        },
        splashColor: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: 100,
          margin: EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 36, color: Colors.blue),
              SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
