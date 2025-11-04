import 'package:association_appli/presentation/colors/Light_theme_colors.dart';
import 'package:flutter/material.dart';

List<Map> categoryOptions = [
  {'id': '1', 'imagePath': 'assets/icons/football.png', 'name': 'Novice'},
  {'id': '2', 'imagePath': 'assets/icons/quiz.png', 'name': 'Ancien(ne)'},
  {'id': '3', 'imagePath': 'assets/icons/materials.png', 'name': 'Doyen(ne)'},
];

List<DropdownMenuItem<String>> memberCategoryItem({required String? selected}) {
  return categoryOptions.asMap().entries.map((entry) {
    int index = entry.key;
    var item = entry.value;
    bool isLast = index == categoryOptions.length - 1;
    bool canSelected = item['name'] == selected;

    return DropdownMenuItem<String>(
      value: item['name'],
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Image.asset(item['imagePath'], width: 24),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    item['name'],
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            if (!isLast)
              SizedBox(
                width: 120.0,
                child: Divider(
                  height: 1,
                  thickness: 1.0,
                  color:
                      canSelected
                          ? Colors.transparent
                          : LightThemeColors.textFieldBorderColors,
                ),
              ),
          ],
        ),
      ),
    );
  }).toList();
}
