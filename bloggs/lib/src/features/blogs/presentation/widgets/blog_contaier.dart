import 'package:bloggs/src/core/utils/reading_time.dart';
import 'package:bloggs/src/features/blogs/domain/entities/blog_entity.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BlogContaier extends StatelessWidget {
  final BlogEntity blog;
  final Color color;

  const BlogContaier({
    super.key,
    required this.blog,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/blogDetail',
          arguments: blog,
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        height: 24.h,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5.h,
                  child: ListView.builder(
                    itemCount: blog.categories.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final text = blog.categories[index];
                      return Container(
                        margin: const EdgeInsets.only(right: 5),
                        child: Chip(
                          label: Text(text),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 1.h),
                Text(
                  blog.title.length > 40
                      ? "${blog.title.substring(0, 30)}..."
                      : blog.title,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            Text(
              "${calculateReadingTime(blog.content)} min",
              style: const TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
