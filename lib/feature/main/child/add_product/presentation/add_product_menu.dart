import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listy_chef/core/di/di.dart';
import 'package:listy_chef/core/presentation/foundation/app_bottom_sheet.dart';
import 'package:listy_chef/core/presentation/foundation/app_text_button.dart';
import 'package:listy_chef/core/presentation/foundation/platform_call.dart';
import 'package:listy_chef/core/presentation/foundation/text/app_outlined_text_field.dart';
import 'package:listy_chef/core/presentation/theme/app_theme_provider.dart';
import 'package:listy_chef/core/presentation/theme/strings.dart';
import 'package:listy_chef/feature/main/child/add_product/presentation/bloc/mod.dart';

Future<void> showAddProductMenu(BuildContext context) => platformCall(
  android: _showMobileAddProductMenu,
  iOS: _showMobileAddProductMenu,
  macOS: _showMobileAddProductMenu,
  linux: _showMobileAddProductMenu,
  windows: _showMobileAddProductMenu,
  web: _showMobileAddProductMenu,
)(context);

Future<void> _showMobileAddProductMenu(BuildContext context) =>
  showAppBottomSheet(
    context: context,
    builder: (context) => _ShowAddProductMenuContent(blocFactory: di()),
  );

final class _ShowAddProductMenuContent extends StatefulWidget {
  final AddProductBlocFactory blocFactory;
  const _ShowAddProductMenuContent({required this.blocFactory});

  @override
  State<StatefulWidget> createState() => _ShowAddProductMenuContentState();
}

final class _ShowAddProductMenuContentState extends State<_ShowAddProductMenuContent> {

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => widget.blocFactory(),
    child: BlocPresentationListener<AddProductBloc, AddProductEffect>(
      listener: (context, effect) => switch (effect) {
        EffectCloseMenu() => Navigator.of(context, rootNavigator: true).pop(),
      },
      child: BlocBuilder<AddProductBloc, AddProductState>(
        builder: (context, state) {
          final contentPadding = EdgeInsets.symmetric(
            horizontal: context.appTheme.dimensions.padding.medium,
          );

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: contentPadding,
                child: AppOutlineTextField(
                  controller: controller,
                  label: context.strings.cart_product_field_placeholder,
                  textColor: context.appTheme.colors.text.secondary,
                  textSize: context.appTheme.typography.h.h4.fontSize,
                  fontWeight: FontWeight.w700,
                  focusedColor: context.appTheme.colors.text.secondary,
                  unfocusedColor: context.appTheme.colors.text.disabled,
                  onChange: (title) => context.addAddProductEvent(
                    EventUpdateProductTitle(title: title),
                  ),
                ),
              ),

              SizedBox(height: context.appTheme.dimensions.padding.small),

              Padding(
                padding: contentPadding,
                child: AppTextButton(
                  text: context.strings.ok,
                  isEnabled: state.isConfirmButtonEnabled,
                  enabledColor: context.appTheme.colors.text.secondary,
                  disabledColor: context.appTheme.colors.text.disabled,
                  onClick: () => context.addAddProductEvent(EventConfirmCreation()),
                ),
              ),
            ],
          );
        },
      ),
    ),
  );
}
