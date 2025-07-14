// import 'package:flutter/material.dart';
// import 'package:overseas_front_end/view/widgets/CustomPasswordTextField.dart';
// import 'package:overseas_front_end/view/widgets/custom_button.dart';
// import 'package:overseas_front_end/view/widgets/custom_snackbar.dart';
// import 'package:overseas_front_end/view/widgets/custom_text_form_field.dart';
// import 'package:provider/provider.dart';
//
// import '../../../controller/auth/login_controller.dart';
// import '../../../res/style/colors/colors.dart';
//
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});
//
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen>
//     with TickerProviderStateMixin {
//   final _formKey = GlobalKey<FormState>();
//   final _officerIdController = TextEditingController();
//   final _passwordController = TextEditingController();
//
//   late AnimationController _animationController;
//   late AnimationController _heroAnimationController;
//   late Animation<double> _fadeAnimation;
//   late Animation<double> _slideAnimation;
//   late Animation<double> _heroAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       duration: Duration(milliseconds: 1200),
//       vsync: this,
//     );
//     _heroAnimationController = AnimationController(
//       duration: Duration(milliseconds: 1500),
//       vsync: this,
//     );
//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
//     );
//     _slideAnimation = Tween<double>(begin: 50.0, end: 0.0).animate(
//       CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
//     );
//     _heroAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
//       CurvedAnimation(
//           parent: _heroAnimationController, curve: Curves.easeInOut),
//     );
//
//     _animationController.forward();
//     _heroAnimationController.forward();
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     _heroAnimationController.dispose();
//     _officerIdController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           bool isMobile = constraints.maxWidth < 768;
//           bool isTablet =
//               constraints.maxWidth >= 768 && constraints.maxWidth < 1024;
//           bool isDesktop = constraints.maxWidth >= 1024;
//
//           if (isDesktop) {
//             return _buildDesktopLayout(constraints);
//           } else if (isTablet) {
//             return _buildTabletLayout(constraints);
//           } else {
//             return _buildMobileLayout(constraints);
//           }
//         },
//       ),
//     );
//   }
//
//   Widget _buildDesktopLayout(BoxConstraints constraints) {
//     return Row(
//       children: [
//         // Left side - Hero Section
//         Expanded(
//           flex: 5,
//           child: Container(
//             decoration: BoxDecoration(gradient: AppColors.heroGradient),
//             child: _buildHeroSection(true),
//           ),
//         ),
//         // Right side - Login Form
//         Expanded(
//           flex: 4,
//           child: Container(
//             decoration: BoxDecoration(
//               gradient: AppColors.backgroundGraident,
//             ),
//             child: Center(
//               child: SingleChildScrollView(
//                 child: AnimatedBuilder(
//                   animation: _animationController,
//                   builder: (context, child) {
//                     return Transform.translate(
//                       offset: Offset(0, _slideAnimation.value),
//                       child: FadeTransition(
//                         opacity: _fadeAnimation,
//                         child: Container(
//                           width: 400,
//                           margin: EdgeInsets.symmetric(horizontal: 48),
//                           child: _buildLoginCard(false),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildTabletLayout(BoxConstraints constraints) {
//     return Container(
//       decoration: BoxDecoration(gradient: AppColors.backgroundGraident),
//       child: Center(
//         child: SingleChildScrollView(
//           child: Row(
//             children: [
//               // Compact hero section for tablet
//               Container(
//                 width: 300,
//                 height: 400,
//                 margin: EdgeInsets.only(left: 32, right: 16),
//                 decoration: BoxDecoration(
//                   gradient: AppColors.heroGradient,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: _buildHeroSection(false),
//               ),
//               Expanded(
//                 child: Container(
//                   margin: EdgeInsets.only(right: 32),
//                   child: FadeTransition(
//                     opacity: _fadeAnimation,
//                     child: _buildLoginCard(false),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildMobileLayout(BoxConstraints constraints) {
//     return Container(
//       decoration: BoxDecoration(gradient: AppColors.backgroundGraident),
//       child: Center(
//         child: SingleChildScrollView(
//           child: FadeTransition(
//             opacity: _fadeAnimation,
//             child: Container(
//               width: constraints.maxWidth * 0.9,
//               margin: EdgeInsets.symmetric(horizontal: 16),
//               child: _buildLoginCard(true),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildHeroSection(bool isDesktop) {
//     return AnimatedBuilder(
//       animation: _heroAnimationController,
//       builder: (context, child) {
//         return Transform.scale(
//           scale: _heroAnimation.value,
//           child: Container(
//             padding: EdgeInsets.all(isDesktop ? 64 : 32),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Animated logo/icon
//                 Container(
//                   width: isDesktop ? 120 : 80,
//                   height: isDesktop ? 120 : 80,
//                   decoration: BoxDecoration(
//                     color: AppColors.whiteMainColor.withOpacity(0.1),
//                     shape: BoxShape.circle,
//                     border: Border.all(
//                         color: AppColors.whiteMainColor.withOpacity(0.3),
//                         width: 2),
//                   ),
//                   child: Icon(
//                     Icons.security,
//                     size: isDesktop ? 60 : 40,
//                     color: AppColors.whiteMainColor,
//                   ),
//                 ),
//                 SizedBox(height: isDesktop ? 48 : 32),
//
//                 // Welcome text
//                 Text(
//                   'Welcome to',
//                   style: TextStyle(
//                     fontSize: isDesktop ? 20 : 16,
//                     color: AppColors.whiteMainColor.withOpacity(0.8),
//                     fontWeight: FontWeight.w300,
//                   ),
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   'Affinix',
//                   style: TextStyle(
//                     fontSize: isDesktop ? 48 : 32,
//                     color: AppColors.whiteMainColor,
//                     fontWeight: FontWeight.bold,
//                     height: 1.1,
//                   ),
//                 ),
//                 SizedBox(height: 16),
//
//                 // Description
//
//                 Text(
//                   "Empowering Global Careers",
//                   style: TextStyle(
//                     fontSize: isDesktop ? 16 : 14,
//                     color: AppColors.whiteMainColor.withOpacity(0.7),
//                     height: 1.6,
//                   ),
//                 ),
//                 if (isDesktop) ...[
//                   SizedBox(height: 48),
//                   // Features list
//                   // ..._buildFeaturesList(),
//                 ],
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   // List<Widget> _buildFeaturesList() {
//   //   final features = [
//   //     {'icon': Icons.support_agent, 'text': 'Expert Migration Support'},
//   //     {'icon': Icons.work, 'text': 'Job Placement Across Borders '},
//   //     {'icon': Icons.flight, 'text': 'Visa & Documentation Assistance'},
//   //     {'icon': Icons.work_outlined, 'text': 'End-to-End Career Consultancy '},
//   //   ];
//   //
//   //   return features
//   //       .map((feature) => Container(
//   //             margin: EdgeInsets.only(bottom: 16),
//   //             child: Row(
//   //               children: [
//   //                 Icon(
//   //                   feature['icon'] as IconData,
//   //                   size: 20,
//   //                   color: AppColors.whiteMainColor.withOpacity(0.8),
//   //                 ),
//   //                 SizedBox(width: 12),
//   //                 Text(
//   //                   feature['text'] as String,
//   //                   style: TextStyle(
//   //                     fontSize: 14,
//   //                     color: AppColors.whiteMainColor.withOpacity(0.8),
//   //                   ),
//   //                 ),
//   //               ],
//   //             ),
//   //           ))
//   //       .toList();
//   // }
//
//   Widget _buildLoginCard(bool isMobile) {
//     return Card(
//       elevation: 24,
//       shadowColor: AppColors.primaryColor.withOpacity(0.1),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(24),
//       ),
//       child: Container(
//         padding: EdgeInsets.all(isMobile ? 24 : 48),
//         decoration: BoxDecoration(
//           color: AppColors.whiteMainColor,
//           borderRadius: BorderRadius.circular(24),
//           boxShadow: [
//             BoxShadow(
//               color: AppColors.primaryColor.withOpacity(0.08),
//               blurRadius: 30,
//               offset: Offset(0, 15),
//             ),
//           ],
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             _buildHeader(isMobile),
//             SizedBox(height: isMobile ? 24 : 32),
//             _buildLoginForm(isMobile),
//             SizedBox(height: 24),
//             CustomButton(
//               text: "Login In",
//               onTap: () {
//                 if (_formKey.currentState!.validate()) {
//                   Provider.of<LoginProvider>(context, listen: false)
//                       .loginOfficer(
//                     officerId: _officerIdController.text.trim(),
//                     password: _passwordController.text.trim(),
//                     context: context,
//                   );
//                 } else {
//                   return CustomSnackBar.show(
//                       context, "All Fields are required");
//                 }
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildHeader(bool isMobile) {
//     return Column(
//       children: [
//         Container(
//           width: isMobile ? 64 : 80,
//           height: isMobile ? 64 : 80,
//           decoration: BoxDecoration(
//             gradient: AppColors.buttonGraidentColour,
//             shape: BoxShape.circle,
//             boxShadow: [
//               BoxShadow(
//                 color: AppColors.violetPrimaryColor.withOpacity(0.3),
//                 blurRadius: 24,
//                 offset: Offset(0, 8),
//               ),
//             ],
//           ),
//           child: Icon(
//             Icons.lock_rounded,
//             color: AppColors.whiteMainColor,
//             size: isMobile ? 32 : 40,
//           ),
//         ),
//         SizedBox(height: 24),
//         Text(
//           'Welcome Back',
//           style: TextStyle(
//             fontSize: isMobile ? 24 : 32,
//             fontWeight: FontWeight.bold,
//             color: AppColors.primaryColor,
//           ),
//         ),
//         SizedBox(height: 8),
//         Text(
//           'Sign in to your account',
//           style: TextStyle(
//             fontSize: isMobile ? 14 : 16,
//             color: AppColors.primaryColor,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildLoginForm(bool isMobile) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         children: [
//           CustomTextFormField(
//             label: "Officers Id",
//             controller: _officerIdController,
//             isRequired: true,
//           ),
//           SizedBox(height: 20),
//           CustomPasswordTextFormField(
//             obscureText: true,
//             label: "Password",
//             controller: _passwordController,
//             isRequired: true,
//             validator: (String? value) {
//               if (value == null || value.isEmpty) {
//                 return 'This field is required';
//               }
//               return null;
//             },
//           ),
//           SizedBox(height: 16),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:overseas_front_end/res/style/colors/dimension.dart';
import 'package:provider/provider.dart';

import '../../../controller/auth/login_controller.dart';
import '../../../res/style/colors/colors.dart';
import '../../widgets/custom_snackbar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _ResponsiveLoginScreenState();
}

class _ResponsiveLoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _officerIdController =
      TextEditingController(text: "64");
  final TextEditingController _passwordController =
      TextEditingController(text: "12345");
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
                _buildLearnMoreButton(),
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
                      _buildLearnMoreButton(),
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
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
        child: Image(image: AssetImage("assets/images/affiniks_logo.webp")),
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
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                child: Image(
                    image: AssetImage("assets/images/affiniks_logo.webp")),
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
          print(_officerIdController.text ?? '.......');
          print(_passwordController.text ?? '.......');
          if (_formKey.currentState?.validate() ?? false) {
            Provider.of<LoginProvider>(context, listen: false).loginOfficer(
              officerId: _officerIdController.text.trim(),
              password: _passwordController.text.trim(),
              context: context,
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
