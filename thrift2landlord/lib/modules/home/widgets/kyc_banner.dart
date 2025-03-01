part of '../index.dart';

class KYCBanner extends StatefulWidget {
  const KYCBanner({super.key});

  @override
  State<KYCBanner> createState() => _KYCBannerState();
}

class _KYCBannerState extends State<KYCBanner> {
  bool _isVisible = true;

  @override
  Widget build(BuildContext context) {
    if (!_isVisible) return SizedBox.shrink();

    return Container(
      height: 700.h,
      margin: EdgeInsets.all(AppSizes.p16),
      padding: EdgeInsets.all(AppSizes.p16),
      decoration: BoxDecoration(
        color: AppColors.light,
        borderRadius: BorderRadius.circular(AppSizes.radiusL),
      ),
      child: Column(
        children: [
          // Close Button
          IconButton(
            icon: Icon(Icons.close, color: AppColors.dark),
            onPressed: () {
              setState(() {
                _isVisible = false;
              });
            },
          ),

          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // KYC Image
              Image.asset(
                'assets/images/kyc.png',
                width: 600.w,
                height: 400.h,
                fit: BoxFit.contain,
              ),

              SizedBox(height: AppSizes.secondaryGapHeight),

              // KYC Text
              Text(
                'For security and safety reasons, KYC verification is required before you can buy properties on Thrift to Landlord. It only takes 5 minutes to verify your identity and unlock full access to land purchases.',
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),

              SizedBox(height: AppSizes.primaryGapHeight),

              // Navigate to KYC Button
              CustomPrimaryButton(
                text: "Verify Now",
                onPressed: () => Get.toNamed(AppRoutes.kyc),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
