import 'package:cached_network_image/cached_network_image.dart';
import 'package:dot_coaching/core/routes/app_routes.dart';
import 'package:dot_coaching/core/widgets/widgets.dart';
import 'package:dot_coaching/feats/feats.dart';
import 'package:dot_coaching/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ProgramContainer extends StatelessWidget {
  final ProgramModel program;
  final ClubModel club;
  final bool isCoach;

  const ProgramContainer({
    super.key,
    required this.program,
    required this.club,
    this.isCoach = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: theme.colorScheme.primaryContainer.withOpacity(0.1),
      ),
      margin: EdgeInsets.only(bottom: 8.w),
      padding: EdgeInsets.all(8.w),
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: sportImage(program.media?.url).sanitize(),
            width: 48.w,
            height: 48.w,
            imageBuilder: (context, imageProvider) => Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  H3Text(program.name),
                  Wrap(
                    spacing: 4.w, // Space between date texts
                    children: [
                      H6Text(
                        program.startDate?.toDayMonthYear() ?? '',
                      ),
                      const Text(' - '),
                      H6Text(
                        program.endDate?.toDayMonthYear() ?? '',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          isCoach
              ? PopupMenuButton(
                  icon: const Icon(
                    Icons.more_vert,
                  ),
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        child: Row(
                          children: [
                            const Icon(Icons.remove_red_eye),
                            const SizedBox(width: 8),
                            Text(
                              context.str?.detail ?? 'Detail',
                            ),
                          ],
                        ),
                        onTap: () => context.pushNamed(
                          AppRoutes.coachProgramDetail.name,
                          pathParameters: {
                            'id': program.id.toString(),
                          },
                          extra: {
                            'route': 'program',
                            'program': program,
                            'club': club,
                          },
                        ),
                      ),
                      PopupMenuItem(
                        child: Row(
                          children: [
                            const Icon(Icons.edit),
                            const SizedBox(width: 8),
                            Text(
                              context.str?.edit ?? 'Edit',
                            ),
                          ],
                        ),
                        onTap: () => context.pushNamed(
                          AppRoutes.coachEditProgram.name,
                          extra: {
                            'route': 'program',
                            'program': program,
                            'club': club,
                          },
                        ),
                      ),
                      PopupMenuItem(
                        child: Row(
                          children: [
                            const Icon(Icons.delete),
                            const SizedBox(width: 8),
                            Text(
                              context.str?.delete ?? 'Delete',
                            ),
                          ],
                        ),
                        onTap: () {
                          context.read<ProgramCubit>().delete(
                                ByIdParams(id: program.id.toString()),
                              );
                        },
                      ),
                    ];
                  },
                )
              : GestureDetector(
                  onTap: () => isCoach
                      ? context.pushNamed(
                          AppRoutes.coachProgramDetail.name,
                          pathParameters: {
                            'id': program.id.toString(),
                          },
                          extra: {
                            'route': 'program',
                            'program': program,
                            'club': club,
                          },
                        )
                      : context.pushNamed(
                          AppRoutes.athleteProgramDetail.name,
                          pathParameters: {
                            'id': program.id.toString(),
                          },
                          extra: {
                            'route': 'program',
                            'program': program,
                            'club': club,
                          },
                        ),
                  child: Row(
                    children: [
                      Text(
                        context.str?.detail ?? 'Detail',
                        style: context.theme.textTheme.bodyMedium?.copyWith(
                            color: context.theme.colorScheme.primary),
                      ),
                      SizedBox(width: 4.w),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 14.sp,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      SizedBox(width: 4.w),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
