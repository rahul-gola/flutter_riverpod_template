import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_template/core/base/base_page.dart';
import 'package:flutter_riverpod_template/core/di/di.dart';
import 'package:flutter_riverpod_template/src/home_screen/home_view_model.dart';

class HomeScreen extends BasePage<HomeViewModel> {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends BaseStatefulPage<HomeViewModel, HomeScreen> {

  @override
  ProviderBase<HomeViewModel> provideBase() {
    return homeViewModelProvider;
  }

  @override
  Widget buildView(BuildContext context, HomeViewModel model) {
    return Column(
      spacing: 10,
      children: [
        const SizedBox(height: 60),
        ElevatedButton(
          onPressed: () => model.fetchProvince(),
          child: const Text('Update User'),
        ),
      ],
    );
  }
}
