import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jcc/constants/string_constants.dart';
import 'package:jcc/generated/assets.dart';
import 'package:jcc/theme/colors.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: SvgPicture.asset(
            Assets.iconsBackArrow,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          CommonDataConstants.userProfile,
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontSize: 22,
              ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              Assets.iconsEdit,
              colorFilter: const ColorFilter.mode(AppColors.black, BlendMode.srcIn),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 90),
              child: SvgPicture.asset(
                Assets.backgroundsUserProfileBackground,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Hero(
                      tag: 'profile',
                      child: Container(
                        height: 180,
                        width: 260,
                        clipBehavior: Clip.hardEdge,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                        child: Image.asset(
                          Assets.imageProfileImage,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: Text(
                    ScreensDataConstants.fullName,
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          color: AppColors.darkMidnightBlue50,
                        ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    "Jay Pedhadiya",
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          fontSize: 22,
                          color: AppColors.darkMidnightBlue,
                        ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: Text(
                    ScreensDataConstants.mobileNo,
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          color: AppColors.darkMidnightBlue50,
                        ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    "+91 90923 33299",
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          fontSize: 22,
                          color: AppColors.darkMidnightBlue,
                        ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: Text(
                    ScreensDataConstants.email,
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          color: AppColors.darkMidnightBlue50,
                        ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    "codersflow20@gmail.com",
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          fontSize: 22,
                          color: AppColors.darkMidnightBlue,
                        ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
