import 'package:flutter/material.dart';
import 'package:overseas_front_end/model/client/client_model.dart';
import 'package:overseas_front_end/res/style/colors/colors.dart';
import 'package:overseas_front_end/view/widgets/widgets.dart';
import 'package:provider/provider.dart';
import '../../../../controller/project/project_provider_controller.dart';

class AddClientScreen extends StatefulWidget {
  final bool isEdit;
  final ClientModel? clientList;
  const AddClientScreen({super.key, required this.isEdit, this.clientList});

  @override
  State<AddClientScreen> createState() => _AddClientScreenState();
}

class _AddClientScreenState extends State<AddClientScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  // Form fields

  String? _selectedCountry = '91';
  String? _selectedAlternativeCountry = '91';
  String? _selectedBranch = 'AFFINIKIS';

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _mobileOptionalController =
      TextEditingController();

  @override
  void initState() {
    _nameController.text = widget.clientList?.name ?? '';
    _mobileController.text = widget.clientList?.phone ?? '';
    _emailController.text = widget.clientList?.email ?? '';
    _cityController.text = widget.clientList?.city ?? '';
    _stateController.text = widget.clientList?.state ?? '';
    _countryController.text = widget.clientList?.country ?? '';
    _addressController.text = widget.clientList?.address ?? '';
    _mobileOptionalController.text = widget.clientList?.alternatePhone ?? '';
    TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _mobileOptionalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(8),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth;
          final maxHeight = constraints.maxHeight;

          double dialogWidth = maxWidth;
          if (maxWidth > 1400) {
            dialogWidth = maxWidth * 0.72;
          } else if (maxWidth > 1000) {
            dialogWidth = maxWidth * 0.9;
          } else if (maxWidth > 600) {
            dialogWidth = maxWidth * 0.95;
          }

          return Center(
            child: Container(
              width: dialogWidth,
              height: maxHeight * 0.95,
              constraints: const BoxConstraints(
                minWidth: 320,
                maxWidth: 800,
                minHeight: 500,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryColor.withOpacity(0.15),
                    spreadRadius: 0,
                    blurRadius: 40,
                    offset: const Offset(0, 20),
                  )
                ],
              ),
              child: Column(
                children: [
                  Container(
                    height: 80,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.primaryColor,
                          AppColors.primaryColor.withOpacity(0.9),
                        ],
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.leaderboard_rounded,
                            size: 22,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                text: widget.isEdit
                                    ? 'Edit Client'
                                    : 'Add New client',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              CustomText(
                                text: widget.isEdit
                                    ? 'Edit all Client details'
                                    : 'Capture client details for follow up',
                                fontSize: 13,
                                color: Colors.white70,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        IconButton(
                          icon: const Icon(Icons.close_rounded,
                              color: Colors.white, size: 24),
                          onPressed: () => Navigator.of(context).pop(),
                          tooltip: 'Close',
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Form(
                        key: _formKey,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade50,
                                  borderRadius: BorderRadius.circular(16),
                                  border:
                                      Border.all(color: Colors.grey.shade200),
                                ),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Scrollbar(
                                        thumbVisibility: true,
                                        child: SingleChildScrollView(
                                          padding: const EdgeInsets.all(24),
                                          child: LayoutBuilder(
                                            builder: (context, constraints) {
                                              final availableWidth =
                                                  constraints.maxWidth;
                                              int columnsCount = 1;

                                              if (availableWidth > 1000) {
                                                columnsCount = 3;
                                              } else if (availableWidth > 600) {
                                                columnsCount = 2;
                                              }

                                              return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const SizedBox(height: 32),
                                                  const SectionTitle(
                                                      title: 'Client Details',
                                                      icon: Icons
                                                          .person_outline_rounded),
                                                  const SizedBox(height: 16),
                                                  ResponsiveGrid(
                                                      columns: columnsCount,
                                                      children: [
                                                        CustomTextFormField(
                                                          label: 'Client Name',
                                                          controller:
                                                              _nameController,
                                                          isRequired: true,
                                                        ),
                                                        CustomTextFormField(
                                                          label: 'Email ID',
                                                          controller:
                                                              _emailController,
                                                        ),
                                                        CustomTextFormField(
                                                          label: 'Address',
                                                          controller:
                                                              _addressController,
                                                        ),
                                                        CustomTextFormField(
                                                          label: 'City',
                                                          controller:
                                                              _cityController,
                                                        ),
                                                        CustomTextFormField(
                                                          label: 'State',
                                                          controller:
                                                              _stateController,
                                                        ),
                                                        CustomTextFormField(
                                                          label: 'Country',
                                                          controller:
                                                              _countryController,
                                                        ),
                                                      ]),
                                                  const SizedBox(height: 20),
                                                  ResponsiveGrid(
                                                      columns: columnsCount,
                                                      children: [
                                                        CustomPhoneField(
                                                          label:
                                                              'Contact Details',
                                                          controller:
                                                              _mobileController,
                                                          selectedCountry:
                                                              _selectedCountry,
                                                          onCountryChanged: (val) =>
                                                              setState(() =>
                                                                  _selectedCountry =
                                                                      val),
                                                          isRequired:
                                                              widget.isEdit
                                                                  ? false
                                                                  : true,
                                                        ),
                                                        CustomPhoneField(
                                                          label:
                                                              'Alternate Mobile (Optional)',
                                                          controller:
                                                              _mobileOptionalController,
                                                          selectedCountry:
                                                              _selectedAlternativeCountry,
                                                          onCountryChanged: (val) =>
                                                              setState(() =>
                                                                  _selectedAlternativeCountry =
                                                                      val),
                                                          isRequired: false,
                                                        ),
                                                      ]),
                                                  const SizedBox(height: 32),
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: CustomActionButton(
                                            text: 'Cancel',
                                            icon: Icons.close_rounded,
                                            textColor: Colors.grey,
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            borderColor: Colors.grey.shade300,
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          flex: 2,
                                          child: CustomActionButton(
                                            text: widget.isEdit
                                                ? 'Edit Client'
                                                : 'Save Client',
                                            icon: Icons.save_rounded,
                                            isFilled: true,
                                            gradient: const LinearGradient(
                                              colors: [
                                                Color(0xFF7F00FF),
                                                Color(0xFFE100FF)
                                              ],
                                            ),
                                            onPressed: () async {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                if (widget.isEdit) {
                                                  await Provider.of<
                                                              ProjectProvider>(
                                                          context,
                                                          listen: false)
                                                      .editClient(
                                                    clientId: widget
                                                            .clientList?.sId ??
                                                        '',
                                                    name:
                                                        _nameController.text ??
                                                            '',
                                                    email:
                                                        _emailController.text ??
                                                            '',
                                                    phone: _mobileController
                                                            .text ??
                                                        '',
                                                    alternatePhone:
                                                        _mobileOptionalController
                                                                .text ??
                                                            '',
                                                    address: _addressController
                                                            .text ??
                                                        '',
                                                    city:
                                                        _cityController.text ??
                                                            '',
                                                    state:
                                                        _stateController.text ??
                                                            '',
                                                    country: _countryController
                                                            .text ??
                                                        '',
                                                    context: context,
                                                  );
                                                  Navigator.pop(context);
                                                } else {
                                                  Provider.of<ProjectProvider>(
                                                          context,
                                                          listen: false)
                                                      .createClient(
                                                    name:
                                                        _nameController.text ??
                                                            '',
                                                    email:
                                                        _emailController.text ??
                                                            '',
                                                    phone:
                                                        "$_selectedCountry ${_mobileController.text}" ??
                                                            '',
                                                    alternatePhone:
                                                        (_mobileOptionalController
                                                                        .text ==
                                                                    '' ||
                                                                _mobileOptionalController
                                                                    .text
                                                                    .isEmpty)
                                                            ? ""
                                                            : "$_selectedAlternativeCountry ${_mobileOptionalController.text}" ??
                                                                '',
                                                    address: _addressController
                                                            .text ??
                                                        '',
                                                    city:
                                                        _cityController.text ??
                                                            '',
                                                    state:
                                                        _stateController.text ??
                                                            '',
                                                    country: _countryController
                                                            .text ??
                                                        '',
                                                    context: context,
                                                  );
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                        content: Text(
                                                            'Client saved successfully')),
                                                  );
                                                  Navigator.pop(context);
                                                }
                                              } else {
                                                return CustomSnackBar.show(
                                                    context,
                                                    "Enter required Fields");
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            // const SizedBox(width: 24),
                            // Visibility(
                            //   visible: maxWidth > 1000 ? _visibility : false,
                            //   child: Container(
                            //     // width: 280,
                            //     width: MediaQuery.of(context).size.width * .2,
                            //     decoration: BoxDecoration(
                            //       gradient: LinearGradient(
                            //         begin: Alignment.topCenter,
                            //         end: Alignment.bottomCenter,
                            //         colors: [
                            //           AppColors.violetPrimaryColor
                            //               .withOpacity(0.08),
                            //           AppColors.blueSecondaryColor
                            //               .withOpacity(0.04),
                            //         ],
                            //       ),
                            //       borderRadius: BorderRadius.circular(16),
                            //       border: Border.all(
                            //           color: AppColors.violetPrimaryColor
                            //               .withOpacity(0.15)),
                            //     ),
                            //     child: SingleChildScrollView(
                            //       child: Column(
                            //         children: [
                            //           Container(
                            //             padding: const EdgeInsets.all(24),
                            //             child: Column(
                            //               children: [
                            //                 Container(
                            //                   padding: const EdgeInsets.all(16),
                            //                   decoration: BoxDecoration(
                            //                     color: AppColors
                            //                         .violetPrimaryColor
                            //                         .withOpacity(0.1),
                            //                     borderRadius:
                            //                         BorderRadius.circular(12),
                            //                   ),
                            //                   child: const Icon(
                            //                     Icons.person_add_alt_1_rounded,
                            //                     size: 40,
                            //                     color: AppColors
                            //                         .violetPrimaryColor,
                            //                   ),
                            //                 ),
                            //                 const SizedBox(width: 12),
                            //                 const FittedBox(
                            //                   fit: BoxFit.scaleDown,
                            //                   child: CustomText(
                            //                     text:
                            //                         'Communication Preferences',
                            //                     fontWeight: FontWeight.bold,
                            //                     // fontSize: 17,
                            //                     color: AppColors.primaryColor,
                            //                   ),
                            //                 ),
                            //                 const SizedBox(height: 8),
                            //                 const CustomText(
                            //                   text:
                            //                       'Fill all required fields to add new client',
                            //                   fontSize: 13,
                            //                   color: Colors.grey,
                            //                   textAlign: TextAlign.center,
                            //                 ),
                            //               ],
                            //             ),
                            //           ),
                            //           Visibility(
                            //               visible:
                            //                   maxWidth > 1000 ? false : true,
                            //               child: const SizedBox(height: 24)),
                            //           Container(
                            //             padding: const EdgeInsets.all(24),
                            //             child: Column(
                            //               crossAxisAlignment:
                            //                   CrossAxisAlignment.start,
                            //               children: [
                            //                 Row(
                            //                   children: [
                            //                     Container(
                            //                       padding:
                            //                           const EdgeInsets.all(8),
                            //                       decoration: BoxDecoration(
                            //                         color: AppColors
                            //                             .violetPrimaryColor
                            //                             .withOpacity(0.1),
                            //                         borderRadius:
                            //                             BorderRadius.circular(
                            //                                 10),
                            //                       ),
                            //                       child: const Icon(
                            //                           Icons
                            //                               .notifications_active_rounded,
                            //                           size: 20,
                            //                           color: AppColors
                            //                               .violetPrimaryColor),
                            //                     ),
                            //                     const SizedBox(width: 12),
                            //                     const Expanded(
                            //                       child: CustomText(
                            //                         maxline: true,
                            //                         maxLines: 1,
                            //                         overflow:
                            //                             TextOverflow.ellipsis,
                            //                         text:
                            //                             'Communication Preferences',
                            //                         fontWeight: FontWeight.bold,
                            //                         fontSize: 16,
                            //                         color:
                            //                             AppColors.primaryColor,
                            //                       ),
                            //                     ),
                            //                   ],
                            //                 ),
                            //                 const SizedBox(height: 20),
                            //                 Column(
                            //                   children: [
                            //                     EnhancedSwitchTile(
                            //                       label: 'Send Greetings',
                            //                       icon:
                            //                           Icons.celebration_rounded,
                            //                       value: _sendGreetings,
                            //                       onChanged: (val) => setState(
                            //                           () =>
                            //                               _sendGreetings = val),
                            //                     ),
                            //                     const SizedBox(height: 12),
                            //                     EnhancedSwitchTile(
                            //                       label: 'Send Email Updates',
                            //                       icon: Icons.email_rounded,
                            //                       value: _sendEmail,
                            //                       onChanged: (val) => setState(
                            //                           () => _sendEmail = val),
                            //                     ),
                            //                     const SizedBox(height: 12),
                            //                     EnhancedSwitchTile(
                            //                       label:
                            //                           'WhatsApp Communication',
                            //                       icon: Icons.chat_rounded,
                            //                       value: _sendWhatsapp,
                            //                       onChanged: (val) => setState(
                            //                           () =>
                            //                               _sendWhatsapp = val),
                            //                     ),
                            //                   ],
                            //                 ),
                            //               ],
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
