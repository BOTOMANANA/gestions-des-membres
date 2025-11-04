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
  }) {
    _initializeDefaultMembers();
  }

  MemberState state = MemberState.initial;
  String errorMessage = '';
  List<MemberEntity> members = [];
  List<MemberEntity> membreSearch = [];
  MemberEntity? memberEntity;

  void _setLoading() {
    state = MemberState.loading;
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
        print('=========== MemberCreate with success');
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
    var result = await getMemberByStatusUsecase(memberCategory: category);
    result.fold(
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
    var user = await deleteMemberUsecase(id: id);

    user.fold(
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

  void searchSingleMember({required String fullName}) async {
    _setLoading();
    var members = await searchMemberUsecase(fullName: fullName);
    members.fold(
      (failure) {
        state = MemberState.error;
        errorMessage = failure.errorMessage;
        membreSearch = [];
        notifyListeners();
      },
      (membersList) {
        membreSearch = membersList;
        notifyListeners();
      },
    );
  }

  void _initializeDefaultMembers() {
    members = [
      MemberEntity(
        id: null,
        fullName: 'Rabe Andry',
        genre: 'Femme',
        country: 'Madagascar',
        cinNumber: 123456789,
        phoneNumber: 0341234567,
        faculty: 'Informatique',
        quarter: 'Fianarantsoa',
        studentCardNumber: 'STU001',
        category: 'Novice',
        memberResponsability: 'Aucun',
        memberShipFee: 5000,
      ),
      MemberEntity(
        id: null,
        fullName: 'Rakoto Jean',
        genre: 'Home',
        country: 'Madagascar',
        cinNumber: 987654321,
        phoneNumber: 0349876543,
        faculty: 'Droit',
        quarter: 'Ambalavao',
        studentCardNumber: 'STU002',
        category: 'Ancien',
        memberResponsability: 'Trésorier',
        memberShipFee: 8000,
      ),
    ];

    notifyListeners(); // ✅ notifie l’UI
  }
}

// j'utilise le fold pour bien gerer le succes et echec sans faire de if et else si il est echec retourner a gauche sinon a droite
