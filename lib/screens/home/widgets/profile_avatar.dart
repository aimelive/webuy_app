import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/colors.dart';
import '../../../constants/shared.dart';
import '../../profile/profile.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    Key? key,
    required this.authUser,
  }) : super(key: key);

  final AuthUser authUser;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => pushPage(
        context,
        to: const Profile(),
      ),
      child: CircleAvatar(
        backgroundColor: primaryColor,
        foregroundColor: white,
        radius: 25.r,
        child: Text(
          authUser.name == null || authUser.name!.isEmpty
              ? authUser.email![0].toUpperCase()
              : authUser.name![0].toUpperCase(),
          style: TextStyle(fontSize: 25.sp),
        ),
      ),
    );
  }
}
