// ignore_for_file: deprecated_member_use
import 'package:association_appli/domain/entities/activity_entity.dart';
import 'package:association_appli/presentation/colors/Light_theme_colors.dart';
import 'package:association_appli/presentation/fonts/app_fonts.dart';
import 'package:association_appli/presentation/pages/activity_page/single_activity_page.dart';
import 'package:association_appli/presentation/providers/activity_provider.dart';
import 'package:association_appli/presentation/utils/date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActivityItemWidget extends StatelessWidget {
  final ActivityEntity activityEntity;

  ActivityItemWidget({super.key, required this.activityEntity});

  void _navigateToActivityDetails({
    required BuildContext context,
    required int id,
  }) {
    final route = Navigator.of(context);
    route.push(
      MaterialPageRoute(builder: (context) => SingleActivityPage(id: id)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String dateRangeText = DateFormatter.formatDateRange(
      activityEntity.startDate,
      activityEntity.endDate,
    );

    return InkWell(
      onTap: () {},
      child: _buildCardBody(context: context, date: dateRangeText),
    );
  }

  Widget _buildCardBody({required BuildContext context, required String date}) {
    final Offset shadowOffset = Offset(4.0, 4.0);
    return Container(
      height: 92.0,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          _buildBoxShadow(
            offset: shadowOffset,
            color: LightThemeColors.colorPrimary.withOpacity(0.12),
          ),
          _buildBoxShadow(
            offset: -shadowOffset,
            color: LightThemeColors.textFieldBorderColors.withOpacity(0.12),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 100,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),

                SizedBox(width: 12),

                Expanded(child: _buildActivityInfo(date: date)),
              ],
            ),

            Positioned(
              right: 0.0,
              bottom: 0.0,
              child: _buildDeleteActionButton(
                context: context,
                id: activityEntity.id!,
              ),
            ),
          ],
        ),
      ),
    );
  }

  BoxShadow _buildBoxShadow({required Offset offset, required Color color}) {
    final double blur = 15.0;
    return BoxShadow(
      offset: offset,
      blurRadius: blur,
      color: color,
      spreadRadius: 1.0,
    );
  }

  Widget _buildActivityInfo({required String date}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildActivityTitle(),
        SizedBox(height: 4.0),
        _buildActivityLocation(),
        SizedBox(height: 4.0),
        _buildActivityDateRange(date: date),
      ],
    );
  }

  Widget _buildActivityTitle() {
    return Text(
      activityEntity.name,
      style: AppFonts.robotoFont(
        size: 14.0,
        color: LightThemeColors.textBlack,
        weight: FontWeight.w500,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildActivityLocation() {
    return Row(
      children: [
        Icon(Icons.location_on_outlined, size: 18, color: Colors.grey[400]),
        const SizedBox(width: 4.0),
        Expanded(
          child: Text(
            activityEntity.location,
            style: AppFonts.robotoCondensedFont(
              size: 12.0,
              color: LightThemeColors.textSemiBlack,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildActivityDateRange({required String date}) {
    return Row(
      children: [
        Icon(
          Icons.calendar_today_outlined,
          size: 16.0,
          color: Colors.grey[400],
        ),
        const SizedBox(width: 4.0),
        Text(
          date,
          style: AppFonts.robotoCondensedFont(
            size: 12.0,
            color: LightThemeColors.textSemiBlack,
          ),
        ),
      ],
    );
  }

  Widget _buildDeleteActionButton({
    required BuildContext context,
    required int id,
  }) {
    return SizedBox(
      height: 34.0,
      width: 80.0,
      child: TextButton(
        onPressed: () {
          Provider.of<ActivityProvider>(
            context,
            listen: false,
          ).deleteActivity(id: id);
        },
        style: buttonStyle,
        child: Text(
          'Supprimer\n       ',
          style: AppFonts.robotoCondensedFont(size: 12.0, color: Colors.white),
        ),
      ),
    );
  }

  final ButtonStyle buttonStyle = TextButton.styleFrom(
    backgroundColor: LightThemeColors.colorPrimary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.circular(8.0),
    ),
  );
}
