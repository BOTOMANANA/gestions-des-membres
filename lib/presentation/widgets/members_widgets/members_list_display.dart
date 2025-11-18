import 'package:association_appli/domain/entities/member_entity.dart';
import 'package:association_appli/presentation/widgets/input_search_members.dart';
import 'package:association_appli/presentation/widgets/member_item_widget.dart';
import 'package:association_appli/presentation/widgets/members_widgets/members_load_status_widgets.dart';
import 'package:flutter/material.dart';

class MemberListDisplay extends StatelessWidget {
  final List<MemberEntity> memberList;
  final bool isSearching;
  final bool isCategoryDataEmpty;
  final String categoryStatus;

  const MemberListDisplay({
    super.key,
    required this.memberList,
    required this.isSearching,
    required this.isCategoryDataEmpty,
    required this.categoryStatus,
  });

  Widget _buildMemberList() {
    return ListView.builder(
      itemCount: memberList.length,
      itemBuilder: (context, index) {
        return MemberItemWidget(memberEntity: memberList[index]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!isSearching && isCategoryDataEmpty) {
      return buildInitialEmptyStatePlaceholder(status: categoryStatus);
    }

    if (isSearching && memberList.isEmpty) {
      return buildSearchNoResultsPlaceholder(
        title: 'Aucun $categoryStatus trouvé',
        status: categoryStatus,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: InputSearchMembers(category: categoryStatus),
        ),
        const SizedBox(height: 12.0),
        Expanded(child: _buildMemberList()),
      ],
    );
  }
}
