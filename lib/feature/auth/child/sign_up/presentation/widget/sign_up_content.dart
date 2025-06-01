import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listy_chef/core/presentation/foundation/app_filled_button.dart';
import 'package:listy_chef/core/presentation/foundation/app_outlined_text_field.dart';
import 'package:listy_chef/core/presentation/theme/app_theme_provider.dart';
import 'package:listy_chef/core/presentation/theme/strings.dart';
import 'package:listy_chef/core/utils/ext/bool_ext.dart';
import 'package:listy_chef/feature/auth/child/sign_up/presentation/bloc/mod.dart';
import 'package:listy_chef/feature/auth/presentation/widget/application_icon.dart';

final class SignUpContent extends StatefulWidget {
  final String? initialEmail;
  const SignUpContent({super.key, this.initialEmail});

  @override
  State<StatefulWidget> createState() => _SignUpContentState();
}

final class _SignUpContentState extends State<SignUpContent> {

  late TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController(text: widget.initialEmail);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<SignUpBloc, SignUpState>(
    builder: (context, state) {
      final theme = context.appTheme;
      final strings = context.strings;

      Widget CommonDimensions({required Widget child}) => ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: theme.dimensions.size.extraEnormous,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: theme.dimensions.padding.extraMedium,
          ),
          child: child,
        ),
      );

      return SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ApplicationIcon(),

            SizedBox(height: theme.dimensions.padding.extraMedium),

            CommonDimensions(
              child: Text(
                strings.auth_welcome_title,
                textAlign: TextAlign.center,
                style: theme.typography.h.h2.copyWith(
                  color: theme.colors.text.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            SizedBox(height: theme.dimensions.padding.extraMedium),

            CommonDimensions(
              child: AppOutlineTextField(
                controller: controller,
                label: strings.auth_email_label,
                error: state.email.error.ifTrue(strings.auth_error_email_empty),
                onChanged: (input) => BlocProvider
                  .of<SignUpBloc>(context)
                  .add(EventEmailChange(email: input)),
              ),
            ),

            SizedBox(height: theme.dimensions.padding.extraMedium),

            CommonDimensions(
              child: AppOutlineTextField(
                label: strings.auth_nickname_label,
                error: state.nickname.error.ifTrue(strings.auth_error_nickname_empty),
                onChanged: (input) => BlocProvider
                  .of<SignUpBloc>(context)
                  .add(EventNicknameChange(nickname: input)),
              ),
            ),

            SizedBox(height: theme.dimensions.padding.extraMedium),

            CommonDimensions(
              child: AppOutlineTextField(
                obscureText: true,
                label: strings.auth_password_label,
                error: state.password.error.ifTrue(strings.auth_error_short_password),
                onChanged: (input) => BlocProvider
                  .of<SignUpBloc>(context)
                  .add(EventPasswordChange(password: input)),
              ),
            ),

            SizedBox(height: theme.dimensions.padding.extraMedium),

            CommonDimensions(
              child: AppFilledButton(
                text: strings.auth_sign_up,
                isEnabled: state.isConfirmButtonEnabled,
                onClick: () => BlocProvider
                  .of<SignUpBloc>(context)
                  .add(EventConfirmClick()),
              ),
            ),

            SizedBox(height: theme.dimensions.padding.extraMedium),
          ],
        ),
      );
    },
  );
}
