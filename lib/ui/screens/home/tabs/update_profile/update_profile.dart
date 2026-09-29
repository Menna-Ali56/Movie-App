import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/ui/widgets/custom_elevated_button.dart';
import 'package:movie_app/utils/app_assets.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'package:movie_app/utils/app_routes.dart';
import 'package:movie_app/utils/app_styles.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  // Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  // Default avatar
  String selectedAvatar = AppAssets.avatar_1;

  // Loading
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  // Get user data from Firestore
  Future<void> getUserData() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    try {
      final doc = await FirebaseFirestore.instance
          .collection(MyUser.collectionName)
          .doc(user.uid)
          .get();

      if (doc.exists) {
        final data = doc.data();

        setState(() {
          nameController.text = data?['name'] ?? '';
          phoneController.text = data?['phone'] ?? '';
          selectedAvatar = data?['avatar'] ?? AppAssets.avatar_1;
        });
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error loading profile: $e'),
        ),
      );
    }
  }

  // Update user data
  Future<void> updateProfile() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    setState(() {
      isLoading = true;
    });

    try {
      await FirebaseFirestore.instance
          .collection(MyUser.collectionName)
          .doc(user.uid)
          .update({
        'name': nameController.text.trim(),
        'phone': phoneController.text.trim(),
        'avatar': selectedAvatar,
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Profile updated successfully',
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error updating profile: $e',
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  // Choose avatar
  Future<void> chooseAvatar() async {
    final avatar = await showModalBottomSheet<String>(
      backgroundColor: AppColors.transparentColor,
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 14,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.darkGray,
              borderRadius: BorderRadius.circular(20),
            ),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: AppAssets.listUpdatProfile.length,
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return InkWell(
                  splashColor: AppColors.transparentColor,
                  highlightColor: AppColors.transparentColor,
                  onTap: () {
                    Navigator.pop(
                      context,
                      AppAssets.listUpdatProfile[index],
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppColors.yellow,
                        width: 1,
                      ),
                    ),
                    child: Image.asset(
                      AppAssets.listUpdatProfile[index],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );

    if (avatar != null) {
      setState(() {
        selectedAvatar = avatar;
      });
    }
  }

  // delete account
  Future<void> deleteAccount() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    // تأكيد قبل الحذف
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Account'),
        content: const Text(
          'Are you sure? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    setState(() => isLoading = true);

    try {
      // 1) امسح بيانات المستخدم من Firestore
      await FirebaseFirestore.instance
          .collection(MyUser.collectionName)
          .doc(user.uid)
          .delete();

      // 2) امسح الحساب من Firebase Auth
      await user.delete();

      if (!mounted) return;

      // 3) ارجع لشاشة اللوجين وامسح كل الصفحات السابقة
      Navigator.of(context).pushNamedAndRemoveUntil(
        AppRoutes.login_screen,
            (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      if (e.code == 'requires-recent-login') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'For security, please log in again and then delete your account.',
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.message}')),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting account: $e')),
      );
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.transparentColor,
      appBar: AppBar(
        backgroundColor: AppColors.transparentColor,
        elevation: 0,
        leading: InkWell(
          splashColor: AppColors.transparentColor,
          highlightColor: AppColors.transparentColor,
          autofocus: true,
          onTap: () {
            Navigator.pop(
              context,
              AppRoutes.bottom_bar,
            );
          },
          child: const Icon(
            Icons.arrow_back_rounded,
            color: AppColors.yellow,
          ),
        ),
        title: Center(
          child: Text(
            "Pick Avatar",
            style: AppStyles.regular14Yellow,
          ),
        ),
        actions: const [
          SizedBox(
            width: 50,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar
            InkWell(
              splashColor: AppColors.transparentColor,
              highlightColor: AppColors.transparentColor,
              onTap: chooseAvatar,
              child: Center(
                child: SizedBox(
                  height: 150,
                  width: 150,
                  child: Image.asset(
                    selectedAvatar,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),

            // Name
            Padding(
              padding: const EdgeInsets.only(
                top: 40,
                right: 10,
                left: 10,
              ),
              child: TextField(
                controller: nameController,
                cursorColor: AppColors.yellow,
                style: const TextStyle(
                  color: AppColors.yellow,
                ),
                decoration: InputDecoration(
                  fillColor: AppColors.darkGray,
                  filled: true,
                  prefixIcon: Image.asset(AppAssets.user),
                  hintText: 'John Safwat',
                  hintStyle: AppStyles.roboto20White500,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 10,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: AppColors.darkGray,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: AppColors.yellow,
                      width: 1,
                    ),
                  ),
                ),
              ),
            ),

            // Phone
            Padding(
              padding: const EdgeInsets.only(
                top: 15,
                right: 10,
                left: 10,
              ),
              child: TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                cursorColor: AppColors.yellow,
                style: const TextStyle(
                  color: AppColors.yellow,
                ),
                decoration: InputDecoration(
                  fillColor: AppColors.darkGray,
                  filled: true,
                  prefixIcon: Image.asset(
                    AppAssets.phone,
                  ),
                  hintText: '01200000000',
                  hintStyle: const TextStyle(
                    color: AppColors.white,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 10,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: AppColors.darkGray,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: AppColors.yellow,
                      width: 1,
                    ),
                  ),
                ),
              ),
            ),

            // Reset Password
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 30,
                      right: 10,
                      left: 10,
                      bottom: 15,
                    ),
                    child: Text(
                      "Reset Password",
                      style: AppStyles.regular20White,
                    ),
                  ),
                ],
              ),
            ),

            // Delete Account
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                      child: CustomElevatedButton(
                        backgroundColor: AppColors.red,
                        radius: 15,
                        verticalPadding: 15,
                        onPressed:  isLoading ? null : deleteAccount,

                        child: Text(
                          "Delete Account",
                          style: AppStyles.regular20DarkGray,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(
              height: 15,
            ),

            // Edit Profile
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                      child: CustomElevatedButton(
                        backgroundColor: AppColors.yellow,
                        radius: 15,
                        verticalPadding: 15,
                        horizontalPadding: 5,
                        onPressed: isLoading ? null
                            : updateProfile,
                        child: isLoading
                            ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            color: AppColors.darkGray,
                            strokeWidth: 2,
                          ),
                        )
                            : Text(
                          "Edit Profile",
                          style: AppStyles.regular20DarkGray,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}