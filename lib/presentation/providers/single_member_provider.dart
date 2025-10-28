import 'package:association_appli/domain/entities/member_entity.dart';
import 'package:association_appli/domain/usecases/member_usecases/get_member_by_id_usecase.dart';
import 'package:flutter/foundation.dart';

enum SingleMemberState { initial, error, loading, succes }

class SingleMemberProvider with ChangeNotifier {
  final GetMemberByIdUsecase getMemberByIdUsecase;
  SingleMemberProvider({required this.getMemberByIdUsecase});

  SingleMemberState state = SingleMemberState.initial;
  String errorMessage = '';

  MemberEntity? memberEntity;

  void _setLoading() {
    state = SingleMemberState.loading;
    notifyListeners();
  }

  void getMemberById({required int id}) async {
    _setLoading();
    var result = await getMemberByIdUsecase(id: id);
    result.fold(
      (failure) {
        state = SingleMemberState.error;
        errorMessage = failure.errorMessage;
        notifyListeners();
      },
      (singleMember) {
        state = SingleMemberState.succes;
        memberEntity = singleMember;
        notifyListeners();
      },
    );
  }
}
