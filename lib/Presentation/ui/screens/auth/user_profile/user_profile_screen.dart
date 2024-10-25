import 'package:crafty_bay/Presentation/state_holders/auth/user_profile/user_profile_controller.dart';
import 'package:crafty_bay/Presentation/ui/utils/assets_paths/assets_path.dart';
import 'package:crafty_bay/Presentation/ui/widgets/local/user_profile/edit_profile_view.dart';
import 'package:crafty_bay/Presentation/ui/widgets/local/user_profile/user_information_view.dart';
import 'package:crafty_bay/data/models/user/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final UserProfileController _userProfileController =
      Get.find<UserProfileController>();

  @override
  void initState() {
    super.initState();
    _userProfileController.loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: _buildAppBar(),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GetBuilder<UserProfileController>(
              builder: (userProfileController) {
            if (userProfileController.user == null) {
              return const Center(child: Text("User Data not found."));
            }
            return Column(
              children: [
                _buildProfileSection(
                  textTheme,
                  userProfileController.user!,
                ),
                const SizedBox(height: 24),
                _buildTabBarAndTabBarView(userProfileController.user!),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildTabBarAndTabBarView(UserModel user) {
    return Expanded(
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Text("Information"),
              Text("Edit"),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                UserInformationView(user: user),
                const EditProfileView(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileSection(TextTheme textTheme, UserModel user) {
    return Column(
      children: [
        _buildProfileImage(),
        const SizedBox(height: 8),
        _buildProfileBottom(
          textTheme: textTheme,
          userName: user.cusName ?? 'Unknown User',
          phoneNumber: user.cusPhone ?? 'Unknown Phone',
        ),
      ],
    );
  }

  Widget _buildProfileBottom(
      {required TextTheme textTheme,
      required String userName,
      required String phoneNumber}) {
    return Column(
      children: [
        Text(
          userName,
          style: textTheme.titleLarge,
        ),
        Text(
          phoneNumber,
          style: textTheme.titleMedium,
        ),
      ],
    );
  }

  Widget _buildProfileImage() {
    return Container(
      height: 100,
      width: 100,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage(AssetsPath.dummyProfile),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: const Icon(Icons.arrow_back_ios),
      ),
      title: const Text("User Profile"),
    );
  }
}
