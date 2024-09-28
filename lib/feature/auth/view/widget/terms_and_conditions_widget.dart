import 'package:flutter/material.dart';

import '../../../../core/util/redirect_link.dart';
import '../../../../core/widget/navigation_text.dart';

class TermsAndConditionsWidget extends StatelessWidget {
  //final bool animate;
  const TermsAndConditionsWidget({
    //  this.animate = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NavigationText(
          leadingText: "By proceeding, I accept Door Care",
          buttonText: 'T&C',
          callback: () async {
            await RedirectLink.launchPrivacyPolicy();
          },
        ),
        NavigationText(
          leadingText: "and",
          buttonText: 'Privacy Policy.',
          callback: () async {
            await RedirectLink.launchPrivacyPolicy();
          },
        ),
      ],
    );
  }
}
