class SignUpView extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(AppConstants.primaryColor),
      body: Stack(
        children: [
          _buildHeaderImage(),
          _buildSignUpForm(),
        ],
      ),
    );
  }

  Widget _buildHeaderImage() {
    return Positioned(
      top: 50,
      left: Get.width * 0.25,
      child:
          Image.asset('assets/images/signup_img.png', width: 200, height: 200),
    );
  }

  Widget _buildSignUpForm() {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 500),
      bottom: controller.bottomPosition.value,
      left: 0,
      right: 0,
      child: Container(
        height: Get.height * 0.7,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildHeader(),
              _buildInputFields(),
              _buildOtpSection(),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
