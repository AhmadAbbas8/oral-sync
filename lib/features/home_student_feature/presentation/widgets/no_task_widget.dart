import "package:easy_localization/easy_localization.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:google_fonts/google_fonts.dart";
import "package:oralsync/core/utils/assets_manager.dart";
import "package:oralsync/translations/locale_keys.g.dart";

class NoTaskWidget extends StatelessWidget {
  const NoTaskWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          AssetsManager.noTasksSVG,
          fit: BoxFit.scaleDown,
        ),
        Text(
          LocaleKeys.no_tasks,
          style: GoogleFonts.acme(),
        ).tr(),
      ],
    );
  }
}
