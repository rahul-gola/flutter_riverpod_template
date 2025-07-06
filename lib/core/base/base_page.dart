import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_template/core/base/base_page_state.dart';
import 'package:flutter_riverpod_template/core/base/base_view_model.dart';
import 'package:flutter_riverpod_template/core/base/base_widget.dart';

/// Every Page/View should be inherited from this
abstract class BasePage<VM extends BaseViewModel> extends StatefulWidget {
  const BasePage({super.key});
}

abstract class BasePageState<VM extends BaseViewModel, T extends BasePage<VM>>
    extends CoreBasePageState<VM, T> {
  /// Declare and initialization of viewModel for the page
  ProviderBase<VM> provideBase();
}

abstract class BaseStatefulPage<
  VM extends BaseViewModel,
  B extends BasePage<VM>
>
    extends BasePageState<VM, B> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<VM>(
      providerBase: provideBase(),
      onModelReady: onBaseModelReady,
      builder: (BuildContext context, VM? model, Widget? child) {
        return getLayout();
      },
    );
  }
}
