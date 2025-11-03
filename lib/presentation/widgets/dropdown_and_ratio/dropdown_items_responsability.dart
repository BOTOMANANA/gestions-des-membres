import 'package:association_appli/presentation/colors/Light_theme_colors.dart';
import 'package:flutter/material.dart';

final List<Map> responsabilityOptions = [
  {
    'id': '1',
    'imagePath': 'assets/icons/basketball.png',
    'name': 'Basket-ball',
  },
  {'id': '2', 'imagePath': 'assets/icons/football.png', 'name': 'Foot-ball'},
  {'id': '3', 'imagePath': 'assets/icons/quiz.png', 'name': 'Quiz'},
  {'id': '4', 'imagePath': 'assets/icons/materials.png', 'name': 'Materiels'},
  {'id': '5', 'imagePath': 'assets/icons/danse.png', 'name': 'Danse'},
];

List<DropdownMenuItem<String>> dropdownItemsResponsability() {
  return responsabilityOptions.asMap().entries.map((entry) {
    int index = entry.key;
    var item = entry.value;
    bool isLast = index == responsabilityOptions.length - 1;

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
                Text(item['name']),
              ],
            ),
            SizedBox(height: 10.0),
            if (!isLast)
              Divider(height: 1, color: LightThemeColors.textFieldBorderColors),
          ],
        ),
      ),
    );
  }).toList();
}
