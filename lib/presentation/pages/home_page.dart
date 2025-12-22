// ignore_for_file: deprecated_member_use, library_prefixes
import 'package:association_appli/presentation/colors/Light_theme_colors.dart';
import 'package:association_appli/presentation/fonts/app_fonts.dart';
import 'package:association_appli/presentation/providers/member_providers.dart';
import 'package:association_appli/presentation/routes/page_routes.dart';
import 'package:association_appli/presentation/widgets/build_label_between_section.dart';
import 'package:association_appli/presentation/widgets/button_widgets/custom_icon_button.dart';
import 'package:association_appli/presentation/widgets/caroussel_widget.dart';
import 'package:association_appli/presentation/widgets/create_category_navigation_row.dart';
import 'package:association_appli/presentation/widgets/members_widgets/build_error_state_placeholder.dart';
import 'package:association_appli/presentation/widgets/members_widgets/build_loading_indicator.dart';
import 'package:association_appli/presentation/widgets/members_widgets/display_offices_members.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final provider = Provider.of<MemberProviders>(context, listen: false);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.loadResponsibleMembers();
    });
  }

  void _loadOfficeMembers() {
    provider.loadResponsibleMembers();
  }

  // 2. Fonction pour la navigation avec attente de retour
  void _navigateAndRefresh(BuildContext context) async {
    await Navigator.pushNamed(context, PageRoutes.createMember);
    _loadOfficeMembers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildHeaderWidget(),
      backgroundColor: Colors.white,
      body: Consumer<MemberProviders>(
        builder: (context, provider, _) {
          final responsibleMembers = provider.responsibleMembersList;
          String message = provider.errorMessage;

          return Column(
            children: [
              // CarousselWidget(),
              const SlideCarouselWidget(),

              BuildCategoriesLabelSection(
                onPressed: () => _navigateAndRefresh(context),
              ),
              const CreateCategoryNavigationRow(),
              const SizedBox(height: 4.0),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: BuildLabelBetweenSection(
                  leftLabel: 'Listes burreaux',
                  leftLabelColor: LightThemeColors.textBlack.withOpacity(0.8),
                  rightLabel: 'Voir plus',
                  rightLabelColor: LightThemeColors.textFieldBorderColors,
                  onPressed: () {
                    Navigator.pushNamed(context, PageRoutes.officeMembers);
                  },
                ),
              ),

              if (provider.state == MemberState.loading &&
                  responsibleMembers.isEmpty)
                Expanded(child: Center(child: buildLoadingIndicator()))
              else if (provider.state == MemberState.error &&
                  responsibleMembers.isEmpty)
                Expanded(
                  child: Center(
                    child: buildErrorStatePlaceholder(errorMessage: message),
                  ),
                )
              else if (responsibleMembers.isEmpty)
                const Center(
                  child: Column(
                    children: [
                      SizedBox(height: 50.0),
                      Text('Aucun membre des burreaux à afficher.'),
                    ],
                  ),
                )
              else
                Expanded(
                  child: DisplayOfficesMembers(memberList: responsibleMembers),
                ),
            ],
          );
        },
      ),
    );
  }

  AppBar _buildHeaderWidget() {
    return AppBar(
      backgroundColor: Colors.white,
      leading: customIconButton(
        iconPath: 'assets/icons/menu.png',
        size: 18.0,
        onPressed: () {},
      ),
      title: Padding(
        padding: const EdgeInsets.only(right: 18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/icons/localisation.png'),
            SizedBox(width: 4.0),
            Text(
              'Votre association',
              style: AppFonts.robotoCondensedFont(
                size: 16.0,
                color: LightThemeColors.textBlack,
                weight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: Container(
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
              color: LightThemeColors.colorPrimary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(40.0),
            ),
          ),
        ),
      ],
    );
  }
}
