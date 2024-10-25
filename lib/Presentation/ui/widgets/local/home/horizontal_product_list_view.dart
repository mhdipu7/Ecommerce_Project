import 'package:crafty_bay/Presentation/ui/widgets/global/product_card.dart';
import 'package:crafty_bay/data/models/product/product_model.dart';
import 'package:flutter/material.dart';

class HorizontalProductListView extends StatelessWidget {
  const HorizontalProductListView({
    super.key,
    required this.productList,
  });

  final List<ProductModel> productList;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: productList.length,
      itemBuilder: (context, index) {
        return ProductCard(
          product: productList[index],
        );
      },
      separatorBuilder: (_, __) {
        return const SizedBox(width: 8);
      },
    );
  }
}