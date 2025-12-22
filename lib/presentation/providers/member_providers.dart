// ignore_for_file: unused_element, unused_local_variable

import 'package:association_appli/core/errors/failure.dart';
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

  MemberState _state = MemberState.initial;
  MemberState get state => _state;
  String errorMessage = '';
  List<MemberEntity> _members = [];
  List<MemberEntity> get members => _members;

  List<MemberEntity> _responsibleMembersList = [];
  List<MemberEntity> get responsibleMembersList => _responsibleMembersList;
  List<MemberEntity> searchedMembers = [];

  MemberEntity? memberEntity;
  bool isSearching = false;
  bool isCategory = false;
  String? lastCategoryStatus;

  void _setLoading() {
    _state = MemberState.loading;
    // members = [];
    searchedMembers = [];
    isSearching = false;
    notifyListeners();
  }

  void _setSucces(List<MemberEntity> data, {bool isOfficeList = false}) {
    if (isOfficeList) {
      _responsibleMembersList = data;
    } else {
      _members = data;
    }
    _state = MemberState.succes;
    notifyListeners();
  }

  void reasetState() {
    _state = MemberState.initial;
    notifyListeners();
  }

  void _failureState({required Failure failure}) {
    _state = MemberState.error;
    errorMessage = failure.errorMessage;
    notifyListeners();
  }

  void createMember({required MemberEntity memberEntity}) async {
    _setLoading();
    var result = await createMemberUsecase(memberEntity: memberEntity);
    result.fold(
      (failure) {
        _failureState(failure: failure);
      },
      (createSuccess) {
        _state = MemberState.succes;
        notifyListeners();
      },
    );
  }

  void getMembers() async {
    _setLoading();
    lastCategoryStatus = null;
    isCategory = false;
    var result = await getAllMembersUsecase();

    result.fold(
      (failure) {
        _failureState(failure: failure);
        // members = [];
      },
      (allListMembers) {
        _setSucces(allListMembers);
      },
    );
  }

  void getMembersByStatus({required String category}) async {
    _setLoading();
    // members = [];
    lastCategoryStatus = category;
    isCategory = true;
    var membersCategory = await getMemberByStatusUsecase(
      memberCategory: category,
    );
    isCategory = true;
    membersCategory.fold(
      (failure) {
        _failureState(failure: failure);
        // members = [];
      },
      (filteredMembers) {
        _setSucces(filteredMembers);
        // state = MemberState.succes;
        // members = filteredMembers;
        // isCategory = true;
        // notifyListeners();
      },
    );
  }

  void deleteMember({required int id}) async {
    _setLoading();
    var memberToDelete = await deleteMemberUsecase(id: id);
    memberToDelete.fold(
      (failure) {
        _failureState(failure: failure);
      },
      (deleteSucces) {
        _state = MemberState.succes;
        if (lastCategoryStatus != null) {
          getMembersByStatus(category: lastCategoryStatus!);
        } else {
          getMembers();
        }
        loadResponsibleMembers();
      },
    );
  }

  void updateMember({required MemberEntity memberEntity}) async {
    var memberToUpdate = await updateMemberUsecase(memberEntity: memberEntity);
    memberToUpdate.fold(
      (failure) {
        _failureState(failure: failure);
      },
      (_) {
        if (lastCategoryStatus != null) {
          getMembersByStatus(category: lastCategoryStatus!);
        } else {
          getMembers();
        }
        loadResponsibleMembers();

        // getMembers();
        notifyListeners();
      },
    );
  }

  void clearSearchResult() {
    searchedMembers = [];
    isSearching = false;
    notifyListeners();
  }

  // void searchMember({
  //   required String fullName,
  //   required String category,
  // }) async {
  //   isSearching = true;
  //   notifyListeners();
  //   var members = await searchMemberUsecase(fullName: fullName);
  //   members.fold(
  //     (failure) {
  //       _state = MemberState.error;
  //       errorMessage = failure.errorMessage;
  //       searchedMembers = [];
  //       notifyListeners();
  //     },
  //     (membersList) {
  //       final searchedMembers =
  //           membersList.where((member) => member.category == category).toList();
  //       // _setSucces(searchedMembers);
  //       isSearching = false;
  //       notifyListeners();
  //     },
  //   );
  // }

  void searchMember({
    required String fullName,
    required String category,
  }) async {
    isSearching = true;

    if (fullName.isEmpty) {
      clearSearchResult();
      return;
    }

    notifyListeners();

    var members = await searchMemberUsecase(fullName: fullName);
    members.fold(
      (failure) {
        _state = MemberState.error;
        errorMessage = failure.errorMessage;
        searchedMembers = [];
        isSearching = true;
        notifyListeners();
      },
      (membersList) {
        final results =
            membersList.where((member) => member.category == category).toList();

        searchedMembers = results;
        isSearching = true;

        notifyListeners();
      },
    );
  }

  void loadResponsibleMembers() async {
    _setLoading();
    var result = await getAllMembersUsecase();
    result.fold(
      (failure) {
        _failureState(failure: failure);
      },
      (allMembers) {
        final responsibleMembers = allMembers.where(
          (member) =>
              member.memberResponsability != null &&
              member.memberResponsability!.isNotEmpty,
        );
        final listResponsibleMembers = responsibleMembers.toList();
        _setSucces(listResponsibleMembers, isOfficeList: true);
      },
    );
  }
}
