import 'package:door_care/core/util/png_asset.dart';
import 'package:door_care/feature/auth/auth_bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialAuthWidget extends StatefulWidget {
  const SocialAuthWidget({super.key});

  @override
  State<SocialAuthWidget> createState() => _SocialAuthWidgetState();
}

class _SocialAuthWidgetState extends State<SocialAuthWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(
              child: Divider(
                thickness: 0.5,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Or continue with',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
            const Expanded(
              child: Divider(
                thickness: 0.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return GestureDetector(
              onTap: () {
                context.read<AuthBloc>().add(AuthGoogleEvent());
              },
              child: Container(
                height: 65,
                width: 65,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromRGBO(238, 238, 238, 1),
                ),
                child: Center(
                  child: Image.asset(
                    AppPngPath.google,
                    height: 35,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
