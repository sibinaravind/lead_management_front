import 'package:flutter/material.dart';
import 'package:overseas_front_end/model/product/product_model.dart';
import '../../../../utils/style/colors/colors.dart';
import '../../../widgets/responsive_grid.dart';
import '../../../widgets/section_title.dart';
import '../../cutsomer_profile/widgets/info_item.dart';

class ProductProviderTab extends StatelessWidget {
  final ProductModel provider;
  const ProductProviderTab({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: SingleChildScrollView(
        child: LayoutBuilder(builder: (context, constraints) {
          final columns = constraints.maxWidth > 1000 ? 2 : 1;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitle(
                title: "Provider Details",
                icon: Icons.store,
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.grey.shade300, width: 0.8),
                ),
                child: ResponsiveGrid(
                  columns: columns,
                  children: [
                    InfoItem(
                      label: 'Provider Name',
                      value: provider.providerDetails?.name ?? 'N/A',
                      icon: Icons.person,
                      iconColor: AppColors.orangeSecondaryColor,
                    ),
                    InfoItem(
                      label: 'Contact',
                      value: provider.providerDetails?.contact ?? 'N/A',
                      icon: Icons.phone,
                      iconColor: AppColors.greenSecondaryColor,
                    ),
                    InfoItem(
                      label: 'Email',
                      value: provider.providerDetails?.email ?? 'N/A',
                      icon: Icons.email,
                      iconColor: AppColors.blueSecondaryColor,
                    ),
                    InfoItem(
                      label: 'Address',
                      value: provider.providerDetails?.address ?? 'N/A',
                      icon: Icons.location_on,
                      iconColor: AppColors.viloletSecondaryColor,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const SectionTitle(
                title: "Support & Warranty",
                icon: Icons.store,
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.grey.shade300, width: 0.8),
                ),
                child: ResponsiveGrid(
                  columns: columns,
                  children: [
                    InfoItem(
                      label: 'Support Available',
                      value: provider.supportAvailable?.toString() ?? 'N/A',
                      icon: Icons.person,
                      iconColor: AppColors.orangeSecondaryColor,
                    ),
                    InfoItem(
                      label: 'Support Duration',
                      value: provider.supportDuration?.toString() ?? 'N/A',
                      icon: Icons.phone,
                      iconColor: AppColors.greenSecondaryColor,
                    ),
                    InfoItem(
                      label: 'Warranty Information',
                      value: provider.warrantyInfo?.toString() ?? 'N/A',
                      icon: Icons.email,
                      iconColor: AppColors.blueSecondaryColor,
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
