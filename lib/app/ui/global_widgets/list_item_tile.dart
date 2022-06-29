import 'package:flutter/material.dart';
import 'package:moneyapp/app/ui/constants/app_text_styles.dart';
import 'package:moneyapp/app/ui/constants/ui_constants.dart';
import 'package:moneyapp/app/ui/global_widgets/svg_icon.dart';

class ListItemTile extends StatelessWidget {
  const ListItemTile({
    Key? key,
    required this.title,
    this.icon,
    this.trailing,
    this.onTap,
    this.textColor,
    this.fontWeight,
  }) : super(key: key);

  final String title;
  final String? icon;
  final VoidCallback? onTap;
  final Color? textColor;
  final FontWeight? fontWeight;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: UiConstants.basePadding,
        color: Colors.white,
        child: Row(
          children: <Widget>[
            if (icon != null) ...<Widget>[
              SvgIcon(path: icon!),
              const SizedBox(width: 8),
            ],
            Text(title, style: AppTextStyles.transactionItemTitle.copyWith(color: textColor, fontWeight: fontWeight)),
            const Spacer(),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}
