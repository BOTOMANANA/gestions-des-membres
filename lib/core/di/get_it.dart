import 'package:association_appli/data/datasources/app_database_helper.dart';
import 'package:association_appli/data/datasources/member_local_datasources.dart';
import 'package:association_appli/data/datasources/user_local_datasources.dart';
import 'package:association_appli/data/repositories/member_repository_impl.dart';
import 'package:association_appli/data/repositories/user_repository_impl.dart';
import 'package:association_appli/data/services/pdf_generator_services_impl.dart';
import 'package:association_appli/domain/repositories/member_repository.dart';
import 'package:association_appli/domain/repositories/user_repository.dart';
import 'package:association_appli/domain/services/pdf_generator_services.dart';
import 'package:association_appli/domain/usecases/member_usecases/create_member_usecase.dart';
import 'package:association_appli/domain/usecases/member_usecases/delete_member_usecase.dart';
import 'package:association_appli/domain/usecases/member_usecases/get_all_members_usecase.dart';
import 'package:association_appli/domain/usecases/member_usecases/get_member_by_id_usecase.dart';
import 'package:association_appli/domain/usecases/member_usecases/get_member_by_status_usecase.dart';
import 'package:association_appli/domain/usecases/member_usecases/search_member_usecase.dart';
import 'package:association_appli/domain/usecases/member_usecases/update_member_usecase.dart';
import 'package:association_appli/domain/usecases/service_usecase/generate_member_pdf_usecase.dart';
import 'package:association_appli/domain/usecases/service_usecase/generate_members_pdf_by_category_usecase.dart';
import 'package:association_appli/domain/usecases/user_usecases/login_usecase.dart';
import 'package:association_appli/domain/usecases/user_usecases/signup_usecase.dart';
import 'package:association_appli/presentation/providers/generate_pdf_providers.dart';
import 'package:association_appli/presentation/providers/member_providers.dart';
import 'package:association_appli/presentation/providers/single_member_provider.dart';
import 'package:association_appli/presentation/providers/theme_provider.dart';
import 'package:association_appli/presentation/providers/user_providers.dart';
import 'package:get_it/get_it.dart';

var getIt = GetIt.instance;

Future setup() async {
  await registerDatabase();
  await registerLocalDatabaseSource();
  await registerRepositories();
  await registerService();
  await registerUsecases();
  await registerProvider();
}

Future registerDatabase() async {
  final dbHelper = AppDatabaseHelper.instance;
  getIt.registerSingleton<AppDatabaseHelper>(dbHelper);
}

Future registerLocalDatabaseSource() async {
  getIt.registerLazySingleton<MemberLocalDatasources>(
    () => MemberLocalDatasourcesImpl(),
  );
  getIt.registerLazySingleton<UserLocalDatasources>(
    () => UserLocalDatasourcesImpl(),
  );
}

Future registerRepositories() async {
  getIt.registerLazySingleton<MemberRepository>(
    () => MemberRepositoryImpl(memberLocalDatasources: getIt()),
  );
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(userLocalDatasources: getIt()),
  );
}

Future registerUsecases() async {
  getIt.registerLazySingleton(() => GetAllMembersUsecase(repository: getIt()));
  getIt.registerLazySingleton(() => GetMemberByIdUsecase(repository: getIt()));
  getIt.registerLazySingleton(() => CreateMemberUsecase(repository: getIt()));
  getIt.registerLazySingleton(() => UpdateMemberUsecase(repository: getIt()));
  getIt.registerLazySingleton(() => DeleteMemberUsecase(repository: getIt()));
  getIt.registerLazySingleton(() => SearchMemberUsecase(repository: getIt()));
  getIt.registerLazySingleton(
    () => GetMemberByStatusUsecase(repository: getIt()),
  );

  getIt.registerLazySingleton(() => SignupUsecase(repository: getIt()));
  getIt.registerLazySingleton(() => LoginUsecase(repository: getIt()));
  getIt.registerLazySingleton(
    () => GenerateMembersPdfUseCase(repository: getIt(), pdfGenerator: getIt()),
  );
  getIt.registerLazySingleton(
    () => GenerateMembersPdfByCategoryUsecase(
      repository: getIt(),
      pdfGenerator: getIt(),
    ),
  );
}

Future registerProvider() async {
  getIt.registerLazySingleton(
    () => MemberProviders(
      createMemberUsecase: getIt(),
      getAllMembersUsecase: getIt(),
      getMemberByStatusUsecase: getIt(),
      deleteMemberUsecase: getIt(),
      updateMemberUsecase: getIt(),
      searchMemberUsecase: getIt(),
    ),
  );
  getIt.registerLazySingleton(
    () => SingleMemberProvider(getMemberByIdUsecase: getIt()),
  );
  getIt.registerLazySingleton(
    () => UserProviders(loginUsecase: getIt(), signupUsecase: getIt()),
  );

  getIt.registerLazySingleton(
    () => GeneratePdfProviders(
      generateMembersPdfUsecase: getIt(),
      generateMembersPdfByCategoryUsecase: getIt(),
    ),
  );
  getIt.registerLazySingleton(() => ThemeProvider());
}

Future<void> registerService() async {
  getIt.registerLazySingleton<PdfGeneratorServices>(
    () => PdfGeneratorServicesImpl(),
  );
}
