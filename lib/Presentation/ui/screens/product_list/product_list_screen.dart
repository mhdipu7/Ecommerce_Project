import 'package:crafty_bay/Presentation/state_holders/category/list_product_by_category_controller.dart';
import 'package:crafty_bay/Presentation/ui/utils/assets_paths/assets_path.dart';
import 'package:crafty_bay/Presentation/ui/widgets/global/centered_circular_progress_indicator.dart';
import 'package:crafty_bay/Presentation/ui/widgets/global/empty_widget.dart';
import 'package:crafty_bay/Presentation/ui/widgets/global/product_card.dart';
import 'package:crafty_bay/data/models/category/category_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({
    super.key,
  });

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late CategoryModel categoryModel;

  @override
  void initState() {
    super.initState();

    categoryModel = Get.arguments['categoryModel'];

    Get.find<ListProductByCategoryController>()
        .getListProductByCategory(categoryModel.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(categoryModel.categoryName ?? ''),
      body: GetBuilder<ListProductByCategoryController>(
          builder: (listProductByCategoryController) {
        if (listProductByCategoryController.inProgress) {
          return const CenteredCircularProgressIndicator();
        }

        if(listProductByCategoryController.productList.isEmpty){
          return EmptyWidget(message: "${categoryModel.categoryName} product not found.");
        }

        if (listProductByCategoryController.errorMessage != null) {
          return Center(
            child: Text(
              listProductByCategoryController.errorMessage.toString(),
            ),
          );
        }

        if (listProductByCategoryController.productList.isEmpty) {
          return Center(
            child: Column(
              children: [
                Lottie.asset(AssetsPath.emptyLottie),
                Text(
                  "Product List Empty",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.only(
            top: 8.0,
            left: 8.0,
            right: 8.0,
          ),
          child: GridView.builder(
            itemCount: listProductByCategoryController.productList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1,
              crossAxisSpacing: 2,
              mainAxisSpacing: 11,
            ),
            itemBuilder: (context, index) {
              return FittedBox(
                child: ProductCard(
                  product: listProductByCategoryController.productList[index],
                ),
              );
            },
          ),
        );
      }),
    );
  }

  AppBar _buildAppBar(String categoryName) {
    return AppBar(
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: const Icon(Icons.arrow_back_ios),
      ),
      title: Text(categoryName),
    );
  }
}
