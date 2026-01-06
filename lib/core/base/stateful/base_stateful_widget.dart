import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_template/core/base/base_view_model/base_state.dart';
import 'package:flutter_riverpod_template/core/base/base_view_model/base_viewmodel.dart';

abstract class BaseStatefulWidget< T extends BaseViewModel<S>, S extends BaseState> extends StatefulWidget {
  const BaseStatefulWidget(this.vm, {super.key});

  final NotifierProvider<T, S> vm;
}

abstract class BasePageState<W extends StatefulWidget> extends State<W> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: buildAppbar(),
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      backgroundColor: backgroundColor,
      bottomNavigationBar: bottomNavigationBar(),
      body: buildView(context),
      floatingActionButton: floatingActionButton(),
      floatingActionButtonLocation: floatingActionButtonLocation(),
    );
  }

  bool get resizeToAvoidBottomInset => true;

  PreferredSizeWidget? buildAppbar() => null;

  /// The key for the scaffold widget
  Key? get scaffoldKey => null;

  /// The background color of the scaffold
  Color? get backgroundColor => null;

  Widget? bottomNavigationBar() => null;

  @mustCallSuper
  @protected
  Widget buildView(BuildContext context);

  Widget? floatingActionButton() => null;

  FloatingActionButtonLocation? floatingActionButtonLocation() => null;

  Future<bool> onBackPressed({dynamic param}) {
    return _onWillPop(param);
  }

  Future<bool> _onWillPop(dynamic param) {
    if (Navigator.canPop(context)) {
      if (param != null) {
        Navigator.pop(context, param);
        return Future.value(false);
      } else {
        Navigator.pop(
          context,
        );
        return Future.value(false);
      }
    }
    return Future.value(true);
  }
}
