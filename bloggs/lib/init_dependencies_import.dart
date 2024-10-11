import 'package:bloggs/src/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:bloggs/src/core/network/internet_connection.dart';
import 'package:bloggs/src/core/secrets/supabse_secrets.dart';
import 'package:bloggs/src/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:bloggs/src/features/auth/data/repository/auth_repository.dart';
import 'package:bloggs/src/features/auth/domain/repository/auth_respository.dart';
import 'package:bloggs/src/features/auth/domain/usecases/get_logged_in_user.dart';
import 'package:bloggs/src/features/auth/domain/usecases/signin_usecase.dart';
import 'package:bloggs/src/features/auth/domain/usecases/signup_usecase.dart';
import 'package:bloggs/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bloggs/src/features/blogs/data/datasources/blog_local_datasource.dart';
import 'package:bloggs/src/features/blogs/data/datasources/blog_remote_datasource.dart';
import 'package:bloggs/src/features/blogs/data/repositories/blog_repository_impl.dart';
import 'package:bloggs/src/features/blogs/domain/repositories/blog_repository.dart';
import 'package:bloggs/src/features/blogs/domain/usecases/get_all_blogs_usecase.dart';
import 'package:bloggs/src/features/blogs/domain/usecases/upload_blog_usecase.dart';
import 'package:bloggs/src/features/blogs/presentation/bloc/blog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


part 'init_dependencies.dart';