part of '../index.dart';

class TermsAndConditionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Terms and Conditions",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSizes.primaryPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
                '1. Introduction',
                'Welcome to Thrifth2Landlord, a mobile application designed to facilitate thrift savings and property investment. These Terms and Conditions ("Terms") govern your use of the Thrifth2Landlord application and any related services.',
                context),
            _buildSection(
                '2. Acceptance',
                'By downloading, installing, or using the Thrifth2Landlord application, you ("User") agree to be bound by these Terms. If you do not agree to these Terms, please do not use the application.',
                context),
            _buildSection(
                '3. Age Restriction',
                'You must be at least 18 years old to use the Thrifth2Landlord application.',
                context),
            _buildSection(
                '4. User Account',
                'You are responsible for maintaining the confidentiality of your account and password. You agree to notify us immediately of any unauthorized use of your account or password.',
                context),
            _buildSection(
                '5. Payment Terms',
                'All payments made through the Thrifth2Landlord application are non-refundable. You agree to pay all fees and charges associated with your use of the application.',
                context),
            _buildSection(
                '6. Intellectual Property',
                'The Thrifth2Landlord application, including all text, graphics, logos, and icons, is the exclusive property of [TELL24ENTERPRISE] and is protected by copyright, trademark, and other intellectual property laws. You agree not to reproduce, modify, or distribute any content from the application without prior written permission.',
                context),
            _buildSection(
                '7. Disclaimer',
                'The Thrifth2Landlord application is provided on an "as-is" and "as-available" basis. We disclaim all warranties, express or implied, including but not limited to implied warranties of merchantability, fitness for a particular purpose, and non-infringement.',
                context),
            _buildSection(
                '8. Limitation of Liability',
                'We will not be liable for any damages arising from the use of the Thrifth2Landlord application, including but not limited to incidental, consequential, or punitive damages.',
                context),
            _buildSection(
                '9. Governing Law',
                'These Terms will be governed by and construed in accordance with the laws of [SEC OF THE FEDERAL REPUBLIC OF NIGERIA].',
                context),
            _buildSection(
                '10. Changes to Terms',
                'We reserve the right to modify these Terms at any time without prior notice. Your continued use of the Thrifth2Landlord application will be deemed acceptance of any changes to these Terms.',
                context),
            _buildSection(
                '11. Termination',
                'We may terminate or suspend your use of the Thrifth2Landlord application at any time, without notice, for reasons in breach of the mobile application.',
                context),
            _buildSection(
                '12. Indemnification',
                'You agree to indemnify and hold harmless [TELL24company], its officers, directors, employees, and agents, from and against any claims, damages, losses, liabilities, costs, and expenses arising from your use of the Thrifth2Landlord application.',
                context),
            _buildSection(
                '13. Entire Agreement',
                'These Terms constitute the entire agreement between you and TEL24company regarding your use of the Thrifth2Landlord application.',
                context),
            _buildSection(
                '14. Contact Us',
                'If you have any questions or concerns about these Terms, please contact us at [Tell24company@gmail.com].',
                context),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppSizes.primaryGapHeight),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          SizedBox(height: 4),
          Text(
            content,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
