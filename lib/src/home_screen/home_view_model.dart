import 'package:domain/usecase/fetch_province.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod_template/core/base/base_view_model.dart';

class HomeViewModel extends BaseViewModel {
  HomeViewModel(this._fetchProvinceUseCase);

  final FetchProvinceUseCase _fetchProvinceUseCase;

  Future<void>  fetchProvince() async {
    (await _fetchProvinceUseCase.execute(
      params: FetchProvinceParams(),
    )).fold(
      (l) {
        debugPrint(l.error?.message);
      },
      (r) {
        debugPrint('Response ${r.map((e) => e.name).toList()}');
      },
    );
  }

}

class User {
  const User({this.id = 0, this.name = ''});

  final int id;
  final String name;

  User copyWith({int? id, String? name}) {
    return User(id: id ?? this.id, name: name ?? this.name);
  }
}
