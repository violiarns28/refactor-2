import 'package:dot_coaching/core/core.dart';
import 'package:dot_coaching/feats/feats.dart';
import 'package:dot_coaching/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class PorgramDetailScreen extends StatelessWidget {
  final ProgramModel program;
  const PorgramDetailScreen({super.key, required this.program});

  @override
  Widget build(BuildContext context) {
    return Parent(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF5767ED), Color(0xFF32ADBE)],
              ),
            ),
          ),
          Positioned(
            top: 32,
            left: 8,
            right: 8,
            child: Row(
              children: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      width: 2,
                      color: context.theme.colorScheme.onPrimary,
                    ),
                  ),
                  onPressed: () {
                    context.pop();
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_circle_left_outlined,
                        color: context.theme.colorScheme.onPrimary,
                        size: 14.sp,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        context.str?.back ?? 'Back',
                        style: TextStyle(
                          color: context.theme.colorScheme.onPrimary,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  width: 216.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(64.r),
                  ),
                  child: Text(
                    program.name,
                    style: context.theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 18.sp,
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: 90,
            child: Container(
              width: 344.w,
              height: 680.h,
              padding: EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w),
              decoration: BoxDecoration(
                color: context.theme.colorScheme.surface,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32.r),
                  topRight: Radius.circular(32.r),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Start date : ${program.startDate!.toDayMonthYear()}',
                            style: context.theme.textTheme.bodyLarge,
                          ),
                          Text(
                            'End date : ${program.endDate!.toDayMonthYear()}',
                            style: context.theme.textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
