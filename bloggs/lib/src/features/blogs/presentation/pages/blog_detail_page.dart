import 'package:bloggs/src/core/utils/format_date.dart';
import 'package:bloggs/src/core/utils/reading_time.dart';
import 'package:bloggs/src/features/blogs/domain/entities/blog_entity.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:transparent_image/transparent_image.dart';

class BlogDetailPage extends StatelessWidget {
  const BlogDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final blog = ModalRoute.of(context)!.settings.arguments as BlogEntity;
    return Scaffold(
      appBar: AppBar(),
      body: Scrollbar(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 2.h),
              Text(
                blog.title,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 3.h),
              Text(
                "By ${blog.posterName}",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 1.h),
              Text(
                "${formatDate(blog.updatedAt)}.    ${calculateReadingTime(blog.content)}min",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 17.5.sp,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 2.h),
              ClipRRect(
                borderRadius: BorderRadius.circular(13),
                child: FadeInImage(
                  image: NetworkImage(blog.imageUrl),
                  placeholder: MemoryImage(kTransparentImage),
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                blog.content,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 16.sp,
                  color: Colors.white.withOpacity(0.6),
                  fontWeight: FontWeight.w500,
                  height: 2,
                ),
              ),
              SizedBox(height: 5.h),
            ],
          ),
        ),
      ),
    );
  }
}
