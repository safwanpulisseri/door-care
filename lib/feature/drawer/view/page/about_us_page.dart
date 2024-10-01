import '../widget/appbar_widget.dart';
import 'package:flutter/material.dart';
import '../../../../core/util/svg_asset.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/util/redirect_link.dart';
import '../../../../core/widget/padding_widget.dart';
import '../../../../core/theme/color/app_color.dart';
import '../../../../core/widget/opacity_container.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const AppBarSingle(),
      body: PaddingWidget(
        child: SingleChildScrollView( 
          child: Column(
            children: [
             
              Row(
                children: [
                  const OpacityContainer(),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'About us',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          color: AppColor.secondary,
                          fontSize: 30,
                        ),
                  ),
                ],
              ),

              const SizedBox(height: 20), 

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AppSvgPath.mainLogo,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: screenWidth * 0.9,
                    child: const Text(
                      "This app was developed as a part of my project, marking a significant milestone in my career. DoorCare is a home service platform that allows users to book plumbing, electrical, and other services with ease. It provides a seamless experience for users to manage service bookings and track their progress in real-time. If you have any questions or feedback about DoorCare, you can contact us at:",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () async {
                      await RedirectLink.launchEmail(); 
                    },
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'safwanpulisseri123@gmail.com', 
                          style: TextStyle(
                            color: AppColor.toneFive,
                            decoration: TextDecoration.underline,
                            fontSize:  screenWidth * 0.045,
                          ),
                        ),
                       const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Icon(FontAwesomeIcons.link),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20), 
            ],
          ),
        ),
      ),
    );
  }
}
