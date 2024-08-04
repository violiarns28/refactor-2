import 'package:flutter/material.dart';

class Parent extends StatelessWidget {
  final Widget? body;
  final PreferredSizeWidget? appBar;
  final bool avoidBottomInset;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final Color? backgroundColor;
  final Key? scaffoldKey;
  final bool resizeToAvoidBottomInset;
  final bool extendBodyBehindAppBar;
  final bool extendBody;
  final Widget? endDrawer;

  const Parent({
    super.key,
    this.body,
    this.appBar,
    this.avoidBottomInset = true,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.backgroundColor,
    this.scaffoldKey,
    this.resizeToAvoidBottomInset = true,
    this.extendBodyBehindAppBar = false,
    this.extendBody = true,
    this.endDrawer,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        appBar: appBar,
        body: body,
        floatingActionButton: floatingActionButton,
        bottomNavigationBar: bottomNavigationBar,
        backgroundColor: backgroundColor,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        extendBodyBehindAppBar: extendBodyBehindAppBar,
        extendBody: extendBody,
        endDrawer: endDrawer,
      ),
    );
  }
}
