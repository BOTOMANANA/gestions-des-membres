import 'package:association_appli/presentation/colors/Light_theme_colors.dart';
import 'package:association_appli/presentation/fonts/app_fonts.dart';
import 'package:association_appli/presentation/widgets/create_date_time_at.dart';
import 'package:flutter/material.dart';

class ActivityItemWidget extends StatelessWidget {
  const ActivityItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),

      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(
            width: 1.0,
            color: LightThemeColors.textFieldBorderColors,
          ),
        ),
        child: _onTapActivityItem(),
      ),
    );
  }

  Widget _onTapActivityItem() {
    return InkWell(
      borderRadius: BorderRadius.circular(14.0),
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            const SizedBox(width: 8.0),
            _activityListInformation(),
            createDateTimeAt(
              createAt: DateTime.now(),
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }

  Widget _activityListInformation() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _titleActivity(data: 'Activity name'),
          const SizedBox(height: 2),
          _subTitleActivity(data: 'Price Activity', size: 14.0),
          const SizedBox(height: 2),
          _subTitleActivity(data: 'isPayed', size: 12.0),
        ],
      ),
    );
  }

  Text _titleActivity({required String data}) {
    return Text(
      data,
      style: AppFonts.robotoFont(
        size: 18.0,
        color: LightThemeColors.colorPrimary,
        weight: FontWeight.bold,
      ),
    );
  }

  Text _subTitleActivity({required String data, required double size}) {
    return Text(
      data,
      style: AppFonts.robotoFont(
        size: size,
        color: Colors.white54,
        weight: FontWeight.w600,
      ),
    );
  }
}
