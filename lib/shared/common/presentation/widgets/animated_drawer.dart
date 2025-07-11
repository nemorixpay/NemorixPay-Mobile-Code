import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:nemorixpay/config/constants/image_url.dart';
import 'package:nemorixpay/config/routes/route_names.dart';
import 'package:nemorixpay/config/theme/nemorix_colors.dart';
import 'package:nemorixpay/l10n/app_localizations.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/nemorix_snackbar.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/yes_no_dialog.dart';

/// @file        animated_drawer.dart
/// @brief       New implementation of an animated drawer using advanced_drawer package.
/// @details     An advanced drawer widget, that can be fully customized with size,
///              text, color, radius of corners.
/// @author      Miguel Fagundez
/// @date        07/08/2025
/// @version     1.0
/// @copyright   Apache 2.0 License
class AnimatedDrawer extends StatefulWidget {
  final Widget body;

  const AnimatedDrawer({
    super.key,
    required this.body,
  });

  @override
  State<AnimatedDrawer> createState() => _AnimatedDrawerState();
}

class _AnimatedDrawerState extends State<AnimatedDrawer> {
  final _animatedDrawerController = AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return AdvancedDrawer(
      backdropColor: NemorixColors.greyLevel2,
      controller: _animatedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 500),
      animateChildDecoration: true,
      rtlOpening: false,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 1.0)],
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      drawer: SafeArea(
        child: ListTileTheme(
          textColor: Colors.white,
          iconColor: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                height: 120,
                width: 120,
                margin: const EdgeInsets.only(top: 20, bottom: 60),
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  color: Colors.black26,
                  shape: BoxShape.circle,
                ),
                child: Container(
                  color: Colors.white,
                  child: Image.asset(
                    ImageUrl.appleLogo,
                    width: 100,
                    height: 100,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  _animatedDrawerController.hideDrawer();
                },
                leading: const Icon(Icons.home),
                title: Text(localizations.home),
              ),
              ListTile(
                onTap: () {
                  _animatedDrawerController.hideDrawer();
                  Navigator.pushNamed(
                    context,
                    RouteNames.settings,
                  );
                },
                leading: const Icon(Icons.settings),
                title: Text(localizations.settings),
              ),
              const Spacer(),
              ListTile(
                onTap: () async {
                  await showDialog(
                    context: context,
                    builder: (BuildContext context) => YesNoDialog(
                      title: localizations.signOut,
                      message: localizations.confirmSignOut,
                      onYesPressed: () {
                        FirebaseAuth.instance.signOut();
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          RouteNames.signIn,
                          (route) => false,
                        );
                      },
                      onNoPressed: () {
                        Navigator.of(context).pop();
                      },
                      yesText: localizations.yes,
                      noText: localizations.no,
                    ),
                  );
                },
                leading: const Icon(Icons.output_outlined),
                title: Text(localizations.signOut),
              ),
            ],
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(''),
          leading: IconButton(
            onPressed: () {
              _animatedDrawerController.showDrawer();
            },
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: _animatedDrawerController,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  key: ValueKey<bool>(value.visible),
                  child: Icon(value.visible ? Icons.clear : Icons.menu),
                );
              },
            ),
          ),
        ),
        body: widget.body,
      ),
    );
  }
}
