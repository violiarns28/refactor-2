import 'package:dot_coaching/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DropDown<T> extends StatefulWidget {
  final FocusNode? currFocusNode;
  final FocusNode? nextFocusNode;
  final T value;
  final List<DropdownMenuItem<T>> items;
  final bool hintIsVisible;
  final String? hint;
  final ValueChanged<T?>? onChanged;
  final Widget? prefixIcon;
  final Function(T)? validator;
  final EdgeInsetsGeometry? contentPadding;
  final Color? fillColor;
  final InputDecoration? decoration;

  const DropDown({
    super.key,
    this.currFocusNode,
    this.nextFocusNode,
    required this.value,
    required this.items,
    this.hint,
    required this.onChanged,
    this.hintIsVisible = true,
    this.prefixIcon,
    this.validator,
    this.contentPadding,
    this.fillColor,
    this.decoration,
  });

  @override
  State<DropDown<T>> createState() => _DropDownState();
}

class _DropDownState<T> extends State<DropDown<T>> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // margin: EdgeInsets.symmetric(vertical: 8.h),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: widget.hintIsVisible,
            child: Padding(
              padding: EdgeInsets.only(
                left: 12.w,
              ),
              child: Text(
                widget.hint ?? '',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
          widget.hintIsVisible == true ? SizedBox(height: 4.h) : Container(),
          ButtonTheme(
            key: widget.key,
            alignedDropdown: true,
            padding: EdgeInsets.zero,
            child: DropdownButtonFormField<T>(
              isExpanded: true,
              focusNode: widget.currFocusNode,
              dropdownColor: Theme.of(context).scaffoldBackgroundColor,
              icon: const Icon(Icons.arrow_drop_down),
              decoration: widget.decoration ??
                  InputDecoration(
                    alignLabelWithHint: true,
                    isDense: true,
                    isCollapsed: true,
                    filled: true,
                    fillColor:
                        widget.fillColor ?? context.theme.colorScheme.surface,
                    prefixIcon: SizedBox(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                            ),
                            child: widget.prefixIcon,
                          ),
                          // vertical line,
                          Container(
                            width: 1,
                            height: 24.h,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                    prefixIconConstraints: BoxConstraints(
                      minHeight: 24.h,
                      minWidth: 24.h,
                    ),
                    contentPadding: widget.contentPadding ??
                        EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 16.h,
                        ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        4.r,
                      ),
                      borderSide: BorderSide(
                        color: context.isDarkMode
                            ? Colors.grey[700]!
                            : Colors.grey[300]!,
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      gapPadding: 0,
                      borderRadius: BorderRadius.circular(
                        4.r,
                      ),
                      borderSide: BorderSide(
                        color: context.isDarkMode
                            ? Colors.grey[700]!
                            : Colors.grey[300]!,
                      ),
                    ),
                    errorStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.error,
                        ),
                    focusedErrorBorder: OutlineInputBorder(
                      gapPadding: 0,
                      borderRadius: BorderRadius.circular(4.r),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      gapPadding: 0,
                      borderRadius: BorderRadius.circular(4.r),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      gapPadding: 0,
                      borderRadius: BorderRadius.circular(4.r),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
              value: widget.value,
              items: widget.items,
              validator: widget.validator as String? Function(T?)?,
              onChanged: (value) {
                if (value == null) return;
                if (widget.onChanged != null) {
                  widget.onChanged!(value);
                }
                setState(() {
                  fieldFocusChange(
                    context,
                    widget.currFocusNode ?? FocusNode(),
                    widget.nextFocusNode,
                  );
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
