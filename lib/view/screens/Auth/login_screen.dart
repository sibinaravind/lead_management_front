import 'package:flutter/material.dart';
import 'package:overseas_front_end/view/widgets/CustomPasswordTextField.dart';
import 'package:overseas_front_end/view/widgets/custom_button.dart';
import 'package:overseas_front_end/view/widgets/custom_snackbar.dart';
import 'package:overseas_front_end/view/widgets/custom_text_form_field.dart';
import 'package:provider/provider.dart';

import '../../../controller/auth/login_controller.dart';
import '../../../res/style/colors/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _officerIdController = TextEditingController();
  final _passwordController = TextEditingController();

  late AnimationController _animationController;
  late AnimationController _heroAnimationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  late Animation<double> _heroAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 1200),
      vsync: this,
    );
    _heroAnimationController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _slideAnimation = Tween<double>(begin: 50.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );
    _heroAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
          parent: _heroAnimationController, curve: Curves.easeInOut),
    );

    _animationController.forward();
    _heroAnimationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _heroAnimationController.dispose();
    _officerIdController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 768;
          bool isTablet =
              constraints.maxWidth >= 768 && constraints.maxWidth < 1024;
          bool isDesktop = constraints.maxWidth >= 1024;

          if (isDesktop) {
            return _buildDesktopLayout(constraints);
          } else if (isTablet) {
            return _buildTabletLayout(constraints);
          } else {
            return _buildMobileLayout(constraints);
          }
        },
      ),
    );
  }

  Widget _buildDesktopLayout(BoxConstraints constraints) {
    return Row(
      children: [
        // Left side - Hero Section
        Expanded(
          flex: 5,
          child: Container(
            decoration: BoxDecoration(gradient: AppColors.heroGradient),
            child: _buildHeroSection(true),
          ),
        ),
        // Right side - Login Form
        Expanded(
          flex: 4,
          child: Container(
            decoration: BoxDecoration(
              gradient: AppColors.backgroundGraident,
            ),
            child: Center(
              child: SingleChildScrollView(
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, _slideAnimation.value),
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: Container(
                          width: 400,
                          margin: EdgeInsets.symmetric(horizontal: 48),
                          child: _buildLoginCard(false),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabletLayout(BoxConstraints constraints) {
    return Container(
      decoration: BoxDecoration(gradient: AppColors.backgroundGraident),
      child: Center(
        child: SingleChildScrollView(
          child: Row(
            children: [
              // Compact hero section for tablet
              Container(
                width: 300,
                height: 400,
                margin: EdgeInsets.only(left: 32, right: 16),
                decoration: BoxDecoration(
                  gradient: AppColors.heroGradient,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: _buildHeroSection(false),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: 32),
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: _buildLoginCard(false),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMobileLayout(BoxConstraints constraints) {
    return Container(
      decoration: BoxDecoration(gradient: AppColors.backgroundGraident),
      child: Center(
        child: SingleChildScrollView(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Container(
              width: constraints.maxWidth * 0.9,
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: _buildLoginCard(true),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeroSection(bool isDesktop) {
    return AnimatedBuilder(
      animation: _heroAnimationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _heroAnimation.value,
          child: Container(
            padding: EdgeInsets.all(isDesktop ? 64 : 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Animated logo/icon
                Container(
                  width: isDesktop ? 120 : 80,
                  height: isDesktop ? 120 : 80,
                  decoration: BoxDecoration(
                    color: AppColors.whiteMainColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: AppColors.whiteMainColor.withOpacity(0.3),
                        width: 2),
                  ),
                  child: Icon(
                    Icons.security,
                    size: isDesktop ? 60 : 40,
                    color: AppColors.whiteMainColor,
                  ),
                ),
                SizedBox(height: isDesktop ? 48 : 32),

                // Welcome text
                Text(
                  'Welcome to',
                  style: TextStyle(
                    fontSize: isDesktop ? 20 : 16,
                    color: AppColors.whiteMainColor.withOpacity(0.8),
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Affinix',
                  style: TextStyle(
                    fontSize: isDesktop ? 48 : 32,
                    color: AppColors.whiteMainColor,
                    fontWeight: FontWeight.bold,
                    height: 1.1,
                  ),
                ),
                SizedBox(height: 16),

                // Description

                Text(
                  "Empowering Global Careers",
                  style: TextStyle(
                    fontSize: isDesktop ? 16 : 14,
                    color: AppColors.whiteMainColor.withOpacity(0.7),
                    height: 1.6,
                  ),
                ),
                if (isDesktop) ...[
                  SizedBox(height: 48),
                  // Features list
                  // ..._buildFeaturesList(),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  // List<Widget> _buildFeaturesList() {
  //   final features = [
  //     {'icon': Icons.support_agent, 'text': 'Expert Migration Support'},
  //     {'icon': Icons.work, 'text': 'Job Placement Across Borders '},
  //     {'icon': Icons.flight, 'text': 'Visa & Documentation Assistance'},
  //     {'icon': Icons.work_outlined, 'text': 'End-to-End Career Consultancy '},
  //   ];
  //
  //   return features
  //       .map((feature) => Container(
  //             margin: EdgeInsets.only(bottom: 16),
  //             child: Row(
  //               children: [
  //                 Icon(
  //                   feature['icon'] as IconData,
  //                   size: 20,
  //                   color: AppColors.whiteMainColor.withOpacity(0.8),
  //                 ),
  //                 SizedBox(width: 12),
  //                 Text(
  //                   feature['text'] as String,
  //                   style: TextStyle(
  //                     fontSize: 14,
  //                     color: AppColors.whiteMainColor.withOpacity(0.8),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ))
  //       .toList();
  // }

  Widget _buildLoginCard(bool isMobile) {
    return Card(
      elevation: 24,
      shadowColor: AppColors.primaryColor.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Container(
        padding: EdgeInsets.all(isMobile ? 24 : 48),
        decoration: BoxDecoration(
          color: AppColors.whiteMainColor,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryColor.withOpacity(0.08),
              blurRadius: 30,
              offset: Offset(0, 15),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(isMobile),
            SizedBox(height: isMobile ? 24 : 32),
            _buildLoginForm(isMobile),
            SizedBox(height: 24),
            CustomButton(
              text: "Login In",
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  Provider.of<LoginProvider>(context, listen: false)
                      .loginOfficer(
                    officerId: _officerIdController.text.trim(),
                    password: _passwordController.text.trim(),
                    context: context,
                  );
                } else {
                  return CustomSnackBar.show(
                      context, "All Fields are required");
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(bool isMobile) {
    return Column(
      children: [
        Container(
          width: isMobile ? 64 : 80,
          height: isMobile ? 64 : 80,
          decoration: BoxDecoration(
            gradient: AppColors.buttonGraidentColour,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.violetPrimaryColor.withOpacity(0.3),
                blurRadius: 24,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Icon(
            Icons.lock_rounded,
            color: AppColors.whiteMainColor,
            size: isMobile ? 32 : 40,
          ),
        ),
        SizedBox(height: 24),
        Text(
          'Welcome Back',
          style: TextStyle(
            fontSize: isMobile ? 24 : 32,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Sign in to your account',
          style: TextStyle(
            fontSize: isMobile ? 14 : 16,
            color: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginForm(bool isMobile) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
            label: "Officers Id",
            controller: _officerIdController,
            isRequired: true,
          ),
          SizedBox(height: 20),
          CustomPasswordTextFormField(
            obscureText: true,
            label: "Password",
            controller: _passwordController,
            isRequired: true,
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'This field is required';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
