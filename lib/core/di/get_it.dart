import 'package:association_appli/data/datasources/activity_local_datasources.dart';
import 'package:association_appli/data/datasources/app_database_helper.dart';
import 'package:association_appli/data/datasources/association_local_datasources.dart';
import 'package:association_appli/data/datasources/member_local_datasources.dart';
import 'package:association_appli/data/datasources/member_product_status_local_datasources.dart';
import 'package:association_appli/data/datasources/product_local_datasources.dart';
import 'package:association_appli/data/repositories/activity_repository_impl.dart';
import 'package:association_appli/data/repositories/association_repository_impl.dart';
import 'package:association_appli/data/repositories/member_product_status_repository_impl.dart';
import 'package:association_appli/data/repositories/member_repository_impl.dart';
import 'package:association_appli/data/repositories/product_repository_impl.dart';
import 'package:association_appli/data/services/call_phone_number_service_impl.dart';
import 'package:association_appli/data/services/pdf_generator_services_impl.dart';
import 'package:association_appli/domain/repositories/activity_repository.dart';
import 'package:association_appli/domain/repositories/association_repository.dart';
import 'package:association_appli/domain/repositories/member_product_status_repository.dart';
import 'package:association_appli/domain/repositories/member_repository.dart';
import 'package:association_appli/domain/repositories/product_repository.dart';
import 'package:association_appli/domain/services/call_phone_number_service.dart';
import 'package:association_appli/domain/services/pdf_generator_services.dart';
import 'package:association_appli/domain/usecases/activity_usecases/create_activity_usecase.dart';
import 'package:association_appli/domain/usecases/activity_usecases/delete_activity_usecase.dart';
import 'package:association_appli/domain/usecases/activity_usecases/get_all_acitvity_usecase.dart';
import 'package:association_appli/domain/usecases/association_usecases/create_association_usecase.dart';
import 'package:association_appli/domain/usecases/association_usecases/get_association_usecase.dart';
import 'package:association_appli/domain/usecases/member_product_status_usecase/get_member_product_status_by_product_id.dart';
import 'package:association_appli/domain/usecases/member_product_status_usecase/save_member_product_status.dart';
import 'package:association_appli/domain/usecases/member_product_status_usecase/update_payment_status.dart';
import 'package:association_appli/domain/usecases/member_usecases/create_member_usecase.dart';
import 'package:association_appli/domain/usecases/member_usecases/delete_member_usecase.dart';
import 'package:association_appli/domain/usecases/member_usecases/get_all_members_usecase.dart';
import 'package:association_appli/domain/usecases/member_usecases/get_member_by_id_usecase.dart';
import 'package:association_appli/domain/usecases/member_usecases/get_member_by_status_usecase.dart';
import 'package:association_appli/domain/usecases/member_usecases/search_member_usecase.dart';
import 'package:association_appli/domain/usecases/member_usecases/update_member_usecase.dart';
import 'package:association_appli/domain/usecases/product_usecase/create_product_usecase.dart';
import 'package:association_appli/domain/usecases/product_usecase/delete_product_usecase.dart';
import 'package:association_appli/domain/usecases/product_usecase/get_products_for_activity.dart';
import 'package:association_appli/domain/usecases/service_usecase/call_phone_number_service_usecase.dart';
import 'package:association_appli/domain/usecases/service_usecase/generate_member_pdf_usecase.dart';
import 'package:association_appli/domain/usecases/service_usecase/generate_members_pdf_by_category_usecase.dart';
import 'package:association_appli/presentation/providers/activity_provider.dart';
import 'package:association_appli/presentation/providers/association_provider.dart';
import 'package:association_appli/presentation/providers/call_number_phone_provider.dart';
import 'package:association_appli/presentation/providers/generate_pdf_providers.dart';
import 'package:association_appli/presentation/providers/member_providers.dart';
import 'package:association_appli/presentation/providers/product_provider.dart';
import 'package:association_appli/presentation/providers/single_member_provider.dart';
import 'package:association_appli/presentation/providers/theme_notifier.dart';
import 'package:get_it/get_it.dart';

//============================== Modifier le 10 dec 2025 ======================

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
  getIt.registerLazySingleton<AssociationLocalDatasources>(
    () => AssociationLocalDatasourcesImpl(),
  );
  getIt.registerLazySingleton<ActivityLocalDatasources>(
    () => ActivityLocalDatasourcesImpl(),
  );
  getIt.registerLazySingleton<ProductLocalDatasources>(
    () => ProductLocalDatasourcesImpl(),
  );
  getIt.registerLazySingleton<MemberProductStatusLocalDatasource>(
    () => MemberProductStatusLocalDatasourceImpl(),
  );
}

Future registerRepositories() async {
  getIt.registerLazySingleton<MemberRepository>(
    () => MemberRepositoryImpl(memberLocalDatasources: getIt()),
  );
  getIt.registerLazySingleton<AssociationRepository>(
    () => AssociationRepositoryImpl(localDatasources: getIt()),
  );
  getIt.registerLazySingleton<ActivityRepository>(
    () => ActivityRepositoryImpl(activityLocalDatasources: getIt()),
  );
  getIt.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(datasources: getIt()),
  );
  getIt.registerLazySingleton<MemberProductStatusRepository>(
    () => MemberProductStatusRepositoryImpl(),
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

  getIt.registerLazySingleton(
    () => CreateAssociationUsecase(repository: getIt()),
  );
  getIt.registerLazySingleton(() => GetAssociationUsecase(repository: getIt()));
  getIt.registerLazySingleton(
    () => GenerateMembersPdfUseCase(repository: getIt(), pdfGenerator: getIt()),
  );
  getIt.registerLazySingleton(
    () => GenerateMembersPdfByCategoryUsecase(
      repository: getIt(),
      pdfGenerator: getIt(),
    ),
  );

  getIt.registerLazySingleton(() => CreateActivityUsecase(repository: getIt()));
  getIt.registerLazySingleton(() => DeleteActivityUsecase(repository: getIt()));
  getIt.registerLazySingleton(() => GetAllAcitvityUsecase(repository: getIt()));

  getIt.registerLazySingleton(() => CreateProductUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => DeleteProductUsecase(repository: getIt()));
  getIt.registerLazySingleton(
    () => GetProductsForActivity(repository: getIt()),
  );

  getIt.registerLazySingleton(
    () => SaveMemberProductStatus(repository: getIt()),
  );
  getIt.registerLazySingleton(() => UpdatePaymentStatus(repository: getIt()));
  getIt.registerLazySingleton(
    () => GetMemberProductStatusByProductId(repository: getIt()),
  );
  getIt.registerLazySingleton(
    () => CallPhoneNumberServiceUsecase(callService: getIt()),
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
    () => AssociationProvider(
      createAssociationUsecase: getIt(),
      getAssociationUsecase: getIt(),
    ),
  );

  getIt.registerLazySingleton(
    () => GeneratePdfProviders(
      generateMembersPdfUsecase: getIt(),
      generateMembersPdfByCategoryUsecase: getIt(),
    ),
  );

  getIt.registerLazySingleton(
    () => CallNumberPhoneProvider(callPhoneNumberServiceUsecase: getIt()),
  );

  getIt.registerLazySingleton(() => ThemeNotifier());
  getIt.registerLazySingleton(
    () => ActivityProvider(
      getAllAcitvityUsecase: getIt(),
      createActivityUsecase: getIt(),
      deleteActivityUsecase: getIt(),
    ),
  );
  getIt.registerLazySingleton(
    () => ProductProvider(
      createProductUseCase: getIt(),
      deleteProductUsecase: getIt(),
      getProductsForActivity: getIt(),
    ),
  );
}

Future<void> registerService() async {
  getIt.registerLazySingleton<PdfGeneratorServices>(
    () => PdfGeneratorServicesImpl(),
  );
  getIt.registerLazySingleton<CallPhoneNumberService>(
    () => CallPhoneNumberServiceImpl(),
  );
}
