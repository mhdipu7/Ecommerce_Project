import 'package:carousel_slider/carousel_slider.dart';
import 'package:crafty_bay/Presentation/state_holders/home/slider_list_controller.dart';
import 'package:crafty_bay/Presentation/ui/utils/colors/app_colors.dart';
import 'package:crafty_bay/Presentation/ui/widgets/global/centered_circular_progress_indicator.dart';
import 'package:crafty_bay/data/models/slider/slider_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeBannerSlider extends StatefulWidget {
  const HomeBannerSlider({
    super.key,
  });

  @override
  State<HomeBannerSlider> createState() => _HomeBannerSliderState();
}

class _HomeBannerSliderState extends State<HomeBannerSlider> {
  final ValueNotifier<int> _selectedIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SliderListController>(builder: (sliderListController) {
      return Visibility(
        visible: !sliderListController.inProgress,
        replacement: const CenteredCircularProgressIndicator(),
        child: Column(
          children: <Widget>[
            _buildSlider(sliderListController),
            const SizedBox(height: 8),
            _buildSliderDots(sliderListController)
          ],
        ),
      );
    });
  }

  Widget _buildSliderDots(SliderListController sliderListController) {
    return ValueListenableBuilder(
      valueListenable: _selectedIndex,
      builder: (context, currentIndex, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            sliderListController.sliderList.length,
            (index) {
              return _buildDot(currentIndex, index);
            },
          ),
        );
      },
    );
  }

  Widget _buildDot(int currentIndex, int index) {
    return Container(
      height: 12,
      width: 12,
      key: ValueKey(index),
      margin: const EdgeInsets.only(right: 4),
      decoration: BoxDecoration(
        color: currentIndex == index ? AppColors.themeColor : null,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildSlider(SliderListController sliderListController) {
    return CarouselSlider(
      options: CarouselOptions(
          height: 180.0,
          viewportFraction: 1,
          onPageChanged: (index, reason) {
            _selectedIndex.value = index;
          }),
      items: sliderListController.sliderList
          .map(
            (slider) => _buildSliderItem(context, slider),
          )
          .toList(),
    );
  }

  Widget _buildSliderItem(BuildContext context, SliderModel slider) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 3.0),
      decoration: BoxDecoration(
        color: AppColors.themeColor,
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
            image: NetworkImage(slider.image ?? ''), fit: BoxFit.cover),
      ),
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSliderText(slider, context),
            const SizedBox(height: 16),
            _buildBuyNowButton()
          ],
        ),
      ),
    );
  }

  Widget _buildSliderText(SliderModel slider, BuildContext context) {
    return Text(
      textAlign: TextAlign.center,
      slider.price ?? '',
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: AppColors.blackColor,
            fontWeight: FontWeight.bold,
          ),
    );
  }

  Widget _buildBuyNowButton() {
    return SizedBox(
      width: 100,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: AppColors.themeColor,
          backgroundColor: AppColors.whiteColor,
        ),
        onPressed: () {},
        child: const Text("Buy now"),
      ),
    );
  }

  @override
  void dispose() {
    _selectedIndex.dispose();
    super.dispose();
  }
}
