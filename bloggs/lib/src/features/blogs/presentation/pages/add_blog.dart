import 'dart:io';

import 'package:bloggs/src/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:bloggs/src/core/common/widgets/custom_button.dart';
import 'package:bloggs/src/core/theme/theme_colors.dart';
import 'package:bloggs/src/core/utils/select_image.dart';
import 'package:bloggs/src/core/utils/snack_bar.dart';
import 'package:bloggs/src/features/blogs/presentation/bloc/blog_bloc.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AddBlog extends StatefulWidget {
  const AddBlog({super.key});

  @override
  State<AddBlog> createState() => _AddBlogState();
}

class _AddBlogState extends State<AddBlog> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final List<String> _selectedCategories = [];
  File? image;

  final List<String> categories = [
    "Education",
    "Sport",
    "Science",
    "Technology",
    "Politics"
  ];

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _contentController.dispose();
  }

  void _selectImage() async {
    final pickedImage = await selectImageFromGalery();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  void _onSubmitForm() {
    if (_selectedCategories.isEmpty || image == null) {
      showSnackBar(context, "Blog image and categories need to be selected");
      return;
    }
    if (_formKey.currentState!.validate()) {
      final posterId =
          (context.read<AppUserCubit>().state as UserLoggedIn).user.id;
      context.read<BlogBloc>().add(
            AddBlogEvent(
              posterId: posterId,
              title: _titleController.text.trim(),
              content: _contentController.text.trim(),
              image: image!,
              categories: _selectedCategories,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BlogBloc, BlogState>(
      listener: (context, state) {
        if (state is BlogFailure) {
          showSnackBar(context, state.message);
        }
        if (state is BlogSuccess) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/homePage',
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Add Blog"),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    InkWell(
                      onTap: _selectImage,
                      child: image != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.file(
                                image!,
                                width: double.infinity,
                                height: 17.h,
                                fit: BoxFit.cover,
                              ),
                            )
                          : DottedBorder(
                              strokeWidth: 0.3,
                              borderType: BorderType.RRect,
                              color: AppThemeColors.kWhiteColor,
                              dashPattern: const [20, 5],
                              radius: const Radius.circular(16),
                              child: SizedBox(
                                width: double.infinity,
                                height: 17.h,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(CupertinoIcons.camera),
                                    SizedBox(height: 1.5.h),
                                    const Text("Select an Image")
                                  ],
                                ),
                              ),
                            ),
                    ),
                    SizedBox(height: 3.h),
                    SizedBox(
                      height: 5.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (contex, index) {
                          final title = categories[index];
                          return Container(
                            margin: const EdgeInsets.only(right: 10),
                            child: GestureDetector(
                              onTap: () {
                                if (_selectedCategories.contains(title)) {
                                  _selectedCategories.remove(title);
                                } else {
                                  _selectedCategories.add(title);
                                }
                                setState(() {});
                              },
                              child: Chip(
                                label: Text(title),
                                backgroundColor: _selectedCategories
                                        .contains(title)
                                    ? AppThemeColors.kPrimaryButtonColor
                                    : AppThemeColors.kPrimaryBackgroundColor,
                                side: _selectedCategories.contains(title)
                                    ? null
                                    : const BorderSide(
                                        width: 0.3,
                                        color: AppThemeColors.kWhiteColor,
                                      ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 3.h),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: AppThemeColors.kPrimaryButtonColor,
                      controller: _titleController,
                      decoration: InputDecoration(
                        hintText: "Enter blog title",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Title is empty";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 2.h),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: AppThemeColors.kPrimaryButtonColor,
                      controller: _contentController,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: "Enter blog content",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "content is empty";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 3.h),
                    CustomButton(
                      width: 100.w,
                      text: state is BlogLoading ? "uploading" : "Add Blog",
                      onPressed: _onSubmitForm,
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
