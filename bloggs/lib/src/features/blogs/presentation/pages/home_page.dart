import 'package:bloggs/src/core/theme/theme_colors.dart';
import 'package:bloggs/src/core/utils/snack_bar.dart';
import 'package:bloggs/src/features/blogs/presentation/bloc/blog_bloc.dart';
import 'package:bloggs/src/features/blogs/presentation/widgets/blog_contaier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(GetAllBlogsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "All Blogs",
          style: TextStyle(
            fontFamily: "Poppins",
          ),
        ),
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            showSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is GetAllBlogsSuccess) {
            return ListView.builder(
              itemCount: (state).blogs.length,
              itemBuilder: (context, index) {
                final blog = state.blogs[index];
                return BlogContaier(
                  blog: blog,
                  color: index % 3 == 0
                      ? AppThemeColors.kContainer1
                      : index % 3 == 1
                          ? AppThemeColors.kContainer2
                          : AppThemeColors.kContainer3,
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/addBlog");
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.add),
      ),
    );
  }
}
