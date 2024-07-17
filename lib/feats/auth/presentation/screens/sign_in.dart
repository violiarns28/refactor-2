import 'package:dot_coaching/core/core.dart';
import 'package:dot_coaching/feats/feats.dart';
import 'package:dot_coaching/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        final msg = Strings.of(context);
        if (state.state == BaseState.failure || state.failure != null) {
          msg?.failedSignIn.toToastError(context);
        }
        if (state.status == AuthStatus.authenticated) {
          msg?.successSignIn.toToastSuccess(context);
          context.read<AuthCubit>().clear();
          context.pushReplacementNamed(AppRoutes.athleteHome.name);
        }
      },
      child: Parent(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                'assets/images/hero/sign-in.png',
                width: 344.w,
                height: 260.w,
              ),
              SizedBox(height: 20.h),
              const SignInFormWidget(),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 12.w),
                      height: 1,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const Text(
                    'or',
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 12.w),
                      height: 1,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Don\'t have an account?',
                  ),
                  SizedBox(width: 4.w),
                  InkWell(
                    onTap: () => context.pushNamed(AppRoutes.authSignUp.name),
                    child: Text(
                      'Sign Up',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
