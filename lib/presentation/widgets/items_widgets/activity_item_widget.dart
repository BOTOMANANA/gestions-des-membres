// ignore_for_file: deprecated_member_use
import 'package:association_appli/domain/entities/activity_entity.dart';
import 'package:association_appli/presentation/colors/Light_theme_colors.dart';
import 'package:association_appli/presentation/fonts/app_fonts.dart';
import 'package:association_appli/presentation/pages/activity_page/single_activity_page.dart';
import 'package:association_appli/presentation/providers/activity_provider.dart';
import 'package:association_appli/presentation/utils/formatted_date.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ActivityItemWidget extends StatelessWidget {
  final ActivityEntity activityEntity;

  ActivityItemWidget({super.key, required this.activityEntity});

  void _route({required BuildContext context, required int id}) {
    final route = Navigator.of(context);
    route.push(
      MaterialPageRoute(builder: (context) => SingleActivityPage(id: id)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String formattedDateRange = FormattedDate.formatDateRange(
      activityEntity.startDate,
      activityEntity.endDate,
    );

    return InkWell(
      onTap: () {},
      child: _buildbody(context: context, date: formattedDateRange),
    );
  }

  Widget _buildbody({required BuildContext context, required String date}) {
    final Offset distance = Offset(4.0, 4.0);
    return Container(
      height: 92.0,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          _buildShadow(
            offset: distance,
            color: LightThemeColors.colorPrimary.withOpacity(0.12),
          ),
          _buildShadow(
            offset: -distance,
            color: LightThemeColors.textFieldBorderColors.withOpacity(0.12),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Stack(
          children: [
            Column(
              children: [
                // ClipRRect(child: Image.asset('assets/images/call.png')),
                _buildInfoSection(date: date),
              ],
            ),

            Positioned(
              right: 0.0,
              bottom: 0.0,
              child: _buildDeleteButton(
                context: context,
                id: activityEntity.id!,
              ),
            ),
          ],
        ),
      ),
    );
  }

  BoxShadow _buildShadow({required Offset offset, required Color color}) {
    final double blur = 15.0;
    return BoxShadow(
      offset: offset,
      blurRadius: blur,
      color: color,
      spreadRadius: 1.0,
    );
  }

  Widget _buildInfoSection({required String date}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildTitle(),
        SizedBox(height: 8.0),
        _buildLocation(),
        SizedBox(height: 8.0),
        _buildDateRange(date: date),
      ],
    );
  }

  Widget _buildTitle() {
    return Text(
      activityEntity.name,
      style: AppFonts.robotoFont(size: 14.0, color: LightThemeColors.textBlack),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildLocation() {
    return Row(
      children: [
        const Icon(
          Icons.location_on_outlined,
          size: 18,
          color: Colors.blueGrey,
        ),
        const SizedBox(width: 8),
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

  Widget _buildDateRange({required String date}) {
    return Row(
      children: [
        Icon(Icons.calendar_month, size: 16.0),
        const SizedBox(width: 8),
        Text(
          date,
          style: AppFonts.robotoCondensedFont(
            size: 12.0,
            color: LightThemeColors.colorPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildDeleteButton({required BuildContext context, required int id}) {
    return SizedBox(
      height: 30.0,
      width: 90.0,
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
