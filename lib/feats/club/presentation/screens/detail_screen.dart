import 'package:cached_network_image/cached_network_image.dart';
import 'package:dot_coaching/core/core.dart';
import 'package:dot_coaching/feats/feats.dart';
import 'package:dot_coaching/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ClubDetailScreen extends StatefulWidget {
  final ClubModel club;
  const ClubDetailScreen({super.key, required this.club});

  @override
  State<ClubDetailScreen> createState() => _ClubDetailScreenState();
}

class _ClubDetailScreenState extends State<ClubDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Parent(
      body: RoundedTopBackground(
        title: widget.club.name,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              H1Text(context.str?.management ?? 'Management'),
              SizedBox(height: 8.h),
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withOpacity(0.1),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ManageButton(
                          icon: Assets.icons.program.svg(width: 32.w),
                          text: 'Program',
                          onTap: () => context.pushNamed(
                            AppRoutes.coachProgram.name,
                            extra: {
                              'club': widget.club,
                            },
                          ),
                        ),
                        ManageButton(
                          icon: Assets.icons.exam.svg(width: 32.w),
                          text: 'Exam',
                          onTap: () {
                            context.pushNamed(
                              AppRoutes.coachExam.name,
                              extra: {
                                'club': widget.club,
                              },
                            );
                          },
                        ),
                        ManageButton(
                          icon: Assets.icons.tactical.svg(width: 32.w),
                          text: 'Tactical',
                          onTap: () {
                            context.pushNamed(
                              AppRoutes.coachTactical.name,
                              extra: {
                                'club': widget.club,
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ManageButton(
                          icon: Assets.icons.invite.svg(width: 32.w),
                          text: 'Invite',
                          onTap: () {
                            context.pushNamed(
                              AppRoutes.coachAddMember.name,
                              pathParameters: {
                                'clubId': widget.club.id.toString(),
                              },
                            );
                          },
                        ),
                        ManageButton(
                          icon: Assets.icons.members.svg(width: 32.w),
                          text: 'Members',
                          onTap: () {
                            context.pushNamed(
                              AppRoutes.coachClubMember.name,
                              pathParameters: {
                                'clubId': widget.club.id.toString(),
                              },
                            );
                          },
                        ),
                        ManageButton(
                          icon: Assets.icons.assets.svg(width: 32.w),
                          text: 'Assets',
                          onTap: () {
                            context.pushNamed(
                              AppRoutes.coachMedia.name,
                              pathParameters: {
                                'clubId': widget.club.id.toString(),
                              },
                            );
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                context.str?.settings ?? 'Settings',
                style: context.theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.h),
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withOpacity(0.1),
                ),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        context.pushNamed(
                          AppRoutes.coachEditClub.name,
                          extra: {
                            'club': widget.club,
                          },
                        );
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.edit,
                            color: context.theme.colorScheme.onPrimary,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            context.str?.edit ?? 'Edit',
                            style:
                                context.theme.textTheme.titleMedium?.copyWith(
                              color: context.theme.colorScheme.onPrimary,
                            ),
                          ),
                          const Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 16.sp,
                            color: context.theme.colorScheme.onPrimary,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 4.h),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: context.theme.colorScheme.error,
                      ),
                      onPressed: () {},
                      child: Row(
                        children: [
                          Icon(
                            Icons.logout,
                            color: context.theme.colorScheme.onError,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            context.str?.leave ?? 'Leave',
                            style:
                                context.theme.textTheme.titleMedium?.copyWith(
                              color: context.theme.colorScheme.onError,
                            ),
                          ),
                          const Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 16.sp,
                            color: context.theme.colorScheme.onError,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                context.str?.about ?? 'About',
                style: context.theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.h),
              Row(
                children: [
                  CachedNetworkImage(
                    imageUrl: sportImage(widget.club.media?.url).sanitize(),
                    width: 48.w,
                    height: 48.w,
                    imageBuilder: (context, imageProvider) => Container(
                      width: 48.w,
                      height: 48.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.club.name,
                        style: context.theme.textTheme.titleLarge
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 4.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: context.theme.colorScheme.tertiary
                              .withOpacity(0.2),
                          borderRadius: BorderRadius.circular(32.r),
                        ),
                        child: Text(
                          widget.club.type.name,
                          style: context.theme.textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                'Established at: ${widget.club.createdAt!.toDayMonthYear(locale: context.locale.languageCode)}',
                style: context.theme.textTheme.bodyMedium,
              ),
              Text(
                widget.club.description,
                style: context.theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
