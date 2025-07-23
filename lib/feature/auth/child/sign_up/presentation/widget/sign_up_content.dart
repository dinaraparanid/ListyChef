import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listy_chef/core/presentation/foundation/app_filled_button.dart';
import 'package:listy_chef/core/presentation/foundation/text/app_outlined_text_field.dart';
import 'package:listy_chef/core/presentation/theme/app_theme_provider.dart';
import 'package:listy_chef/core/presentation/theme/images.dart';
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

  late TextEditingController emailController;
  late TextEditingController nicknameController;

  @override
  void initState() {
    emailController = TextEditingController(text: widget.initialEmail);
    nicknameController = TextEditingController(text: '');
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

            BlocPresentationListener<SignUpBloc, SignUpEffect>(
              listener: (context, effect) {
                if (effect is EffectClearEmail) {
                  emailController.clear();
                }
              },
              child: CommonDimensions(
                child: AppOutlineTextField(
                  controller: emailController,
                  label: strings.auth_email_label,
                  error: state.email.error.ifTrue(strings.auth_error_email_empty),
                  suffixIcon: state.isEmailClearIconVisible.ifTrue(
                    AppImages.loadSvg('ic_close'),
                  ),
                  onChange: (input) => BlocProvider
                    .of<SignUpBloc>(context)
                    .add(EventEmailChange(email: input)),
                  onSuffixClick: () => BlocProvider
                    .of<SignUpBloc>(context)
                    .add(EventClearEmail()),
                ),
              ),
            ),

            SizedBox(height: theme.dimensions.padding.extraMedium),

            BlocPresentationListener<SignUpBloc, SignUpEffect>(
              listener: (context, effect) {
                if (effect is EffectClearNickname) {
                  nicknameController.clear();
                }
              },
              child: CommonDimensions(
                child: AppOutlineTextField(
                  controller: nicknameController,
                  label: strings.auth_nickname_label,
                  error: state.nickname.error.ifTrue(strings.auth_error_nickname_empty),
                  suffixIcon: state.isNicknameClearIconVisible.ifTrue(
                    AppImages.loadSvg('ic_close'),
                  ),
                  onChange: (input) => BlocProvider
                    .of<SignUpBloc>(context)
                    .add(EventNicknameChange(nickname: input)),
                  onSuffixClick: () => BlocProvider
                    .of<SignUpBloc>(context)
                    .add(EventClearNickname()),
                ),
              ),
            ),

            SizedBox(height: theme.dimensions.padding.extraMedium),

            CommonDimensions(
              child: AppOutlineTextField(
                obscureText: true,
                label: strings.auth_password_label,
                error: state.password.error.ifTrue(strings.auth_error_short_password),
                suffixIcon: AppImages.loadSvg(
                  state.isPasswordVisible ? 'ic_eye' : 'ic_eye_closed',
                ),
                onChange: (input) => BlocProvider
                  .of<SignUpBloc>(context)
                  .add(EventPasswordChange(password: input)),
                onSuffixClick: () => BlocProvider
                  .of<SignUpBloc>(context)
                  .add(EventChangePasswordVisibility()),
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
