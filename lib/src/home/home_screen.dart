import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_template/core/base/base_widget/base_stateful_widget.dart';
import 'package:flutter_riverpod_template/core/util/app_color.dart';
import 'package:flutter_riverpod_template/src/home/view_model/home_view_model.dart';
import 'package:flutter_riverpod_template/src/home/widgets/item_card_widget.dart';
import 'package:flutter_riverpod_template/src/widget/render/gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends BaseStatefulWidget<HomeViewModel, HomeState> {
  const HomeScreen(super.vm, {super.key});

  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BasePageState<HomeScreen> {
  @override
  PreferredSizeWidget? buildAppbar() {
    return AppBar(
      title: const Text('Home Screen', style: TextStyle(color: Colors.white)),
      centerTitle: true,
      leading: GestureDetector(
        onTap: onBackPressed,
        child: const Icon(Icons.arrow_back_ios, color: Colors.white),
      ),
      actions: [
        Consumer(
          builder: (_, ref, _) {
            return IconButton(
              onPressed: () => ref.read(widget.vm.notifier).fetchProducts(),
              icon: const Icon(Icons.refresh, color: Colors.white),
            );
          },
        ),
      ],
      backgroundColor: AppColor.green900,
    );
  }

  @override
  Widget buildView(BuildContext context) {
    return Consumer(
      builder: (_, ref, _) {
        final products = ref.watch(widget.vm.select((state) => state.products));
        final isLoading = ref.watch(
          widget.vm.select((state) => state.isLoading),
        );
        if (isLoading && products.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (products.isEmpty) {
          return const Center(child: Text('No products available'));
        }

        return ListView.separated(
          padding: const EdgeInsets.all(12).r,
          itemCount: products.length,
          itemBuilder: (_, index) {
            final item = products[index];
            return ItemCard(title: item.title, subtitle: item.category);
          },
          separatorBuilder: (_, _) => const Gap.height(12),
        );
      },
    );
  }
}
