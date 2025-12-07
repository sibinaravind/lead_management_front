import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overseas_front_end/utils/style/colors/dimension.dart';
import '../../../config/flavour_config.dart';
import '../../../controller/auth/login_controller.dart';
import '../../../utils/style/colors/colors.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/loading_dialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _ResponsiveLoginScreenState();
}

class _ResponsiveLoginScreenState extends State<LoginScreen> {
  LoginController controller = Get.find<LoginController>();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _officerIdController =
      TextEditingController(text: "4");
  final TextEditingController _passwordController =
      TextEditingController(text: "Sibin@123");
  bool _obscurePassword = true;

  @override
  void dispose() {
    _officerIdController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.heroGradient,
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              bool isDesktop = constraints.maxWidth > 800;
              bool isTablet =
                  constraints.maxWidth > 600 && constraints.maxWidth <= 800;

              if (isDesktop) {
                return _buildDesktopLayout();
              } else if (isTablet) {
                return _buildTabletLayout();
              } else {
                return _buildMobileLayout(isTablet);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      children: [
        // Left side - Welcome section
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.all(80),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLogo(),
                const SizedBox(height: 60),
                _buildWelcomeText(),
                const SizedBox(height: 40),
                // _buildLearnMoreButton(),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            margin: const EdgeInsets.all(40),
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 600),
                child: _buildLoginForm(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabletLayout() {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            const SizedBox(height: 40),
            _buildLogo(),
            const SizedBox(height: 40),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildWelcomeText(),
                      const SizedBox(height: 30),
                      // _buildLearnMoreButton(),
                    ],
                  ),
                ),
                const SizedBox(width: 40),
                Expanded(
                  child: _buildLoginForm(),
                ),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileLayout(bool isMobile) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 50),
            _buildLoginForm(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 200,
      height: 150,
      decoration: BoxDecoration(
        color: AppColors.whiteMainColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
        child: Image(image: AssetImage(FlavourConfig.appLogo())),
      ),
    );
  }

  Widget _buildWelcomeText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome!',
          style: TextStyle(
            color: AppColors.textWhiteColour,
            fontSize: MediaQuery.of(context).size.width > 600 ? 48 : 36,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 60,
          height: 4,
          decoration: BoxDecoration(
            gradient: AppColors.orangeGradient,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Start your journey to success today. Login and take the first step forward.',
          style: TextStyle(
            color: AppColors.textGrayColour,
            fontSize: 16,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildLearnMoreButton() {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.orangeGradient,
        borderRadius: BorderRadius.circular(25),
      ),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: const Text(
          'Achieve More',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 32),
      decoration: BoxDecoration(
        color: AppColors.whiteMainColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.whiteMainColor.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: Dimension().isMobile(context),
            child: SizedBox(
              width: 200,
              height: 150,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                child: Image(
                    image: AssetImage(
                  FlavourConfig.appLogo(),
                )),
              ),
            ),
          ),

          const Text(
            'Sign in',
            style: TextStyle(
              color: AppColors.textWhiteColour,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 32),
          _buildTextField(
            controller: _officerIdController,
            label: 'User Id',
            hintText: 'User Id',
          ),
          const SizedBox(height: 20),
          _buildTextField(
            controller: _passwordController,
            label: 'Password',
            hintText: '••••••••••',
            isPassword: true,
          ),
          const SizedBox(height: 32),
          _buildSubmitButton(),
          const SizedBox(height: 24),
          // _buildSocialIcons(),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    bool isPassword = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textWhiteColour,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return "Required";
            }
            return null;
          },
          controller: controller,
          obscureText: isPassword ? _obscurePassword : false,
          style: const TextStyle(
            color: AppColors.textWhiteColour,
            fontSize: 16,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: AppColors.textGrayColour.withOpacity(0.7),
              fontSize: 16,
            ),
            filled: true,
            fillColor: AppColors.whiteMainColor.withOpacity(0.1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppColors.whiteMainColor.withOpacity(0.2),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppColors.whiteMainColor.withOpacity(0.2),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFF6366F1),
                width: 2,
              ),
            ),
            suffixIcon: isPassword
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: AppColors.textGrayColour,
                    ),
                  )
                : null,
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        gradient: AppColors.orangeGradient,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState?.validate() ?? false) {
            showLoaderDialog(context);
            controller.loginOfficer(
              officerId: _officerIdController.text.trim(),
              password: _passwordController.text.trim(),
            );
          } else {
            return CustomSnackBar.show(context, "All Fields are required");
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Submit',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialIcon(Icons.facebook),
        const SizedBox(width: 16),
        _buildSocialIcon(Icons.camera_alt), // Instagram icon approximation
        const SizedBox(width: 16),
        _buildSocialIcon(Icons.push_pin), // Pinterest icon approximation
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.whiteMainColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.whiteMainColor.withOpacity(0.2),
        ),
      ),
      child: IconButton(
        onPressed: () {},
        icon: Icon(
          icon,
          color: AppColors.iconWhiteColour,
          size: 20,
        ),
      ),
    );
  }
}
