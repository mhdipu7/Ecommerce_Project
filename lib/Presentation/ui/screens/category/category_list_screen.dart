import 'package:crafty_bay/Presentation/state_holders/category/category_list_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/main_bottom_nav/main_bottom_nav_controller.dart';
import 'package:crafty_bay/Presentation/ui/utils/assets_paths/assets_path.dart';
import 'package:crafty_bay/Presentation/ui/widgets/global/centered_circular_progress_indicator.dart';
import 'package:crafty_bay/Presentation/ui/widgets/local/category/category_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class CategoryListScreen extends StatelessWidget {
  const CategoryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (dipPop, result) {
        backToHome();
      },
      child: Scaffold(
        appBar: _buildAppBar(),
        body: RefreshIndicator(
          onRefresh: () async {
            Get.find<CategoryListController>().getCategoryList();
          },
          child: GetBuilder<CategoryListController>(
              builder: (categoryListController) {
            if (categoryListController.inProgress) {
              return const CenteredCircularProgressIndicator();
            }

            if (categoryListController.errorMessage != null) {
              return Center(
                child: Text(categoryListController.errorMessage!),
              );
            }

            if (categoryListController.categoryList.isEmpty) {
              return Center(
                child: Column(
                  children: [
                    Lottie.asset(AssetsPath.emptyLottie),
                    Text(
                      "Category List Empty",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              );
            }
            return GridView.builder(
              itemCount: categoryListController.categoryList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                return CategoryCard(
                  categoryModel: categoryListController.categoryList[index],
                );
              },
            );
          }),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
        // leading: IconButton(
        //   onPressed: backToHome,
        //   icon: const Icon(Icons.arrow_back_ios),
        // ),
        automaticallyImplyLeading: false,
        title: const Text("Categories"),
      );
  }

  void backToHome() {
    Get.find<MainBottomNavController>().backToHome();
  }
}
