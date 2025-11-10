// ignore_for_file: unused_element, unused_local_variable

import 'package:association_appli/domain/entities/member_entity.dart';
import 'package:association_appli/domain/usecases/member_usecases/create_member_usecase.dart';
import 'package:association_appli/domain/usecases/member_usecases/delete_member_usecase.dart';
import 'package:association_appli/domain/usecases/member_usecases/get_all_members_usecase.dart';
import 'package:association_appli/domain/usecases/member_usecases/get_member_by_status_usecase.dart';
import 'package:association_appli/domain/usecases/member_usecases/search_member_usecase.dart';
import 'package:association_appli/domain/usecases/member_usecases/update_member_usecase.dart';
import 'package:flutter/material.dart';

enum MemberState { initial, loading, succes, error }

class MemberProviders with ChangeNotifier {
  final CreateMemberUsecase createMemberUsecase;
  final GetAllMembersUsecase getAllMembersUsecase;
  final GetMemberByStatusUsecase getMemberByStatusUsecase;
  final DeleteMemberUsecase deleteMemberUsecase;
  final UpdateMemberUsecase updateMemberUsecase;
  final SearchMemberUsecase searchMemberUsecase;

  MemberProviders({
    required this.createMemberUsecase,
    required this.getAllMembersUsecase,
    required this.getMemberByStatusUsecase,
    required this.deleteMemberUsecase,
    required this.updateMemberUsecase,
    required this.searchMemberUsecase,
  });

  MemberState state = MemberState.initial;
  String errorMessage = '';
  List<MemberEntity> members = [];
  List<MemberEntity> searchedMembers = [];
  MemberEntity? memberEntity;
  bool isSearching = false;

  void _setLoading() {
    state = MemberState.loading;
    members = []; // Correction: On vide explicitement la liste des membres
    searchedMembers = [];
    isSearching = false;
    notifyListeners();
  }

  void reasetState() {
    state = MemberState.initial;
    notifyListeners();
  }

  void createMember({required MemberEntity memberEntity}) async {
    _setLoading();
    var result = await createMemberUsecase(memberEntity: memberEntity);
    result.fold(
      (failure) {
        state = MemberState.error;
        errorMessage = failure.errorMessage;
        notifyListeners();
      },
      (createSuccess) {
        state = MemberState.succes;
      },
    );
  }

  void getMembers() async {
    _setLoading();
    var result = await getAllMembersUsecase();

    result.fold(
      (failure) {
        state = MemberState.error;
        errorMessage = failure.errorMessage;
        members = [];
        notifyListeners();
      },
      (allListMembers) {
        state = MemberState.succes;
        members = allListMembers;
        notifyListeners();
      },
    );
  }

  void getMembersByStatus({required String category}) async {
    _setLoading();
    members = [];
    var membersCategory = await getMemberByStatusUsecase(
      memberCategory: category,
    );
    membersCategory.fold(
      (failure) {
        state = MemberState.error;
        errorMessage = failure.errorMessage;
        members = [];
        notifyListeners();
      },
      (filteredMembers) {
        state = MemberState.succes;
        members = filteredMembers;
        notifyListeners();
      },
    );
  }

  void deleteMember({required int id}) async {
    _setLoading();
    var memberToDelete = await deleteMemberUsecase(id: id);

    memberToDelete.fold(
      (failure) {
        state = MemberState.error;
        errorMessage = failure.errorMessage;
        notifyListeners();
      },
      (deleteSucces) {
        state = MemberState.succes;
      },
    );
  }

  void updateMember({required MemberEntity memberEntity}) async {
    var memberToUpdate = await updateMemberUsecase(memberEntity: memberEntity);
    memberToUpdate.fold(
      (failure) {
        state = MemberState.error;
        errorMessage = failure.errorMessage;
        notifyListeners();
      },
      (_) {
        getMembers();
        notifyListeners();
      },
    );
  }

  void searchSingleMember({required String fullName}) async {
    isSearching = true;
    notifyListeners();
    var members = await searchMemberUsecase(fullName: fullName);
    members.fold(
      (failure) {
        state = MemberState.error;
        errorMessage = failure.errorMessage;
        searchedMembers = [];
        notifyListeners();
      },
      (membersList) {
        searchedMembers = membersList;
        notifyListeners();
      },
    );
  }

  void clearSearchResult() {
    searchedMembers = [];
    notifyListeners();
  }
}
