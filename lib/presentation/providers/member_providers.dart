// ignore_for_file: unused_element, unused_local_variable

import 'package:association_appli/domain/entities/member_entity.dart';
import 'package:association_appli/domain/usecases/member_usecases/create_member_usecase.dart';
import 'package:association_appli/domain/usecases/member_usecases/delete_member_usecase.dart';
import 'package:association_appli/domain/usecases/member_usecases/get_all_members_usecase.dart';
import 'package:association_appli/domain/usecases/member_usecases/get_member_by_status_usecase.dart';
import 'package:association_appli/domain/usecases/member_usecases/update_member_usecase.dart';
import 'package:flutter/material.dart';

enum MemberState { initial, loading, succes, error }

class MemberProviders with ChangeNotifier {
  final CreateMemberUsecase createMemberUsecase;
  final GetAllMembersUsecase getAllMembersUsecase;
  final GetMemberByStatusUsecase getMemberByStatusUsecase;
  final DeleteMemberUsecase deleteMemberUsecase;
  final UpdateMemberUsecase updateMemberUsecase;

  MemberProviders({
    required this.createMemberUsecase,
    required this.getAllMembersUsecase,
    required this.getMemberByStatusUsecase,
    required this.deleteMemberUsecase,
    required this.updateMemberUsecase,
  }) {
    _initializeDefaultMembers();
  }

  MemberState state = MemberState.initial;
  String errorMessage = '';
  List<MemberEntity> members = [];
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

  void getMembersByStatus({required MemberStatus status}) async {
    _setLoading();
    var result = await getMemberByStatusUsecase(status: status);
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
    var result = await deleteMemberUsecase(id: id);

    result.fold(
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

  void _initializeDefaultMembers() {
    members = [
      MemberEntity(
        id: 1,
        fullName: 'Rabe Andry',
        country: 'Madagascar',
        cinNumber: 123456789,
        phoneNumber: '0341234567',
        faculty: 'Informatique',
        district: 'Fianarantsoa',
        studentCardNumber: 'STU001',
        status: MemberStatus.NOVICE,
        memberResponsability: 'Aucun',
        memberShipFee: 5000.0,
      ),
      MemberEntity(
        id: 2,
        fullName: 'Rakoto Jean',
        country: 'Madagascar',
        cinNumber: 987654321,
        phoneNumber: '0349876543',
        faculty: 'Droit',
        district: 'Ambalavao',
        studentCardNumber: 'STU002',
        status: MemberStatus.ANCIEN,
        memberResponsability: 'Trésorier',
        memberShipFee: 8000.0,
      ),
    ];

    notifyListeners(); // ✅ notifie l’UI
  }
}

// j'utilise le fold pour bien gerer le succes et echec sans faire de if et else si il est echec retourner a gauche sinon a droite
