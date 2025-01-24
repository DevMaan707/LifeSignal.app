import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_doc/features/common/widgets/custom_navbar.dart';

import '../../common/widgets/hospital_card.dart';
import '../../common/widgets/option_card.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: _buildAppBar(),
      body: Obx(() => IndexedStack(
            index: controller.selectedIndex.value,
            children: [
              _buildHomeContent(),
              _buildAppointmentsContent(),
              _buildNearbyContent(),
              _buildHistoryContent(),
            ],
          )),
      bottomNavigationBar: CustomBottomNav(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: _buildProfileAvatar(),
      title: _buildAppBarTitle(),
      actions: _buildAppBarActions(),
    );
  }

  Widget _buildHomeContent() {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 16),
      children: [
        _buildHeader(),
        _buildOptionsRow(),
        SearchBar(),
        EmergencyServices(),
        _buildHospitalsList(),
      ],
    );
  }

  Widget _buildOptionsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        OptionCard(
          icon: Icons.check_circle_outline,
          title: 'Check Up',
          onTap: () => controller.onCheckUpTap(),
        ),
        OptionCard(
          icon: Icons.medical_services_outlined,
          title: 'Consult',
          onTap: () => controller.onConsultTap(),
        ),
      ],
    );
  }

  Widget _buildHospitalsList() {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }
      if (controller.hospitals.isEmpty) {
        return Center(child: Text('No hospitals available'));
      }
      return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: controller.hospitals.length,
        itemBuilder: (context, index) => HospitalCard(
          hospital: controller.hospitals[index],
          onTap: () => controller.onHospitalTap(index),
        ),
      );
    });
  }
}
