// @dart=2.9
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:text_to_audio/data/model/audio.dart';
import 'package:text_to_audio/data/model/login/login_success_response.dart';
import 'package:text_to_audio/data/model/text_chunk/text_chunk.dart';
import 'package:text_to_audio/data/model/user.dart';
import 'package:text_to_audio/data/model/user_text_audio.dart';
import 'package:text_to_audio/data/network/connection_checker.dart';
import 'package:text_to_audio/data/repository/audio_repository.dart';
import 'package:text_to_audio/data/repository/auth_repository.dart';
import 'package:text_to_audio/data/repository/user_text_audio_repository.dart';
import 'package:text_to_audio/data/repository/text_repository.dart';
import 'package:text_to_audio/data/repository/user_repository.dart';
import 'package:text_to_audio/data/source/api_header_provider.dart';
import 'package:text_to_audio/data/source/local/file_manager.dart';
import 'package:text_to_audio/data/source/local/text_chunk_local_source.dart';
import 'package:text_to_audio/data/source/local/user_local_source.dart';
import 'package:text_to_audio/data/source/local/user_text_audio_local_source.dart';
import 'package:text_to_audio/data/source/login_response_source.dart';
import 'package:text_to_audio/data/source/remote/google_token_source.dart';
import 'package:text_to_audio/data/source/remote/login_api.dart';
import 'package:text_to_audio/data/source/remote/signup_api.dart';
import 'package:text_to_audio/data/source/remote/text_chunk_api.dart';
import 'package:text_to_audio/data/source/remote/user_text_audio_api.dart';
import 'package:text_to_audio/domain/add_user_text_audio.dart';
import 'package:text_to_audio/domain/check_login_state.dart';
import 'package:text_to_audio/domain/clear_current_audio.dart';
import 'package:text_to_audio/domain/create_user.dart';
import 'package:text_to_audio/domain/delete_audio.dart';
import 'package:text_to_audio/domain/delete_user.dart';
import 'package:text_to_audio/domain/delete_user_text_audio_reset_status.dart';
import 'package:text_to_audio/domain/get_current_audio.dart';
import 'package:text_to_audio/domain/get_selected_text_chunk.dart';
import 'package:text_to_audio/domain/get_current_user.dart';
import 'package:text_to_audio/domain/get_new_text_chunk.dart';
import 'package:text_to_audio/domain/get_user_list.dart';
import 'package:text_to_audio/domain/get_user_text_audio_list.dart';
import 'package:text_to_audio/domain/get_user_to_update.dart';
import 'package:text_to_audio/domain/logout.dart';
import 'package:text_to_audio/domain/set_current_audio.dart';
import 'package:text_to_audio/domain/set_current_text.dart';
import 'package:text_to_audio/domain/set_current_user.dart';
import 'package:text_to_audio/domain/set_user_to_update.dart';
import 'package:text_to_audio/domain/login.dart';
import 'package:text_to_audio/domain/sign_up.dart';
import 'package:text_to_audio/domain/update_user.dart';
import 'package:text_to_audio/domain/upload_text_audio.dart';
import 'package:text_to_audio/presentation/bloc/auth/auth_cubit.dart';
import 'package:text_to_audio/presentation/bloc/current_audio_bloc/cubit/current_audio_cubit.dart';
import 'package:text_to_audio/presentation/bloc/current_user_bloc/cubit/current_user_cubit.dart';
import 'package:text_to_audio/presentation/bloc/current_user_text_audio/cubit/current_user_text_audio_cubit.dart';
import 'package:text_to_audio/presentation/bloc/delete_user/cubit/delete_user_cubit.dart';
import 'package:text_to_audio/presentation/bloc/get_user_to_update/cubit/get_user_to_update_cubit.dart';
import 'package:text_to_audio/presentation/bloc/session/session_cubit.dart';
import 'package:text_to_audio/presentation/bloc/set_user_to_update/cubit/set_user_to_update_cubit.dart';
import 'package:text_to_audio/presentation/bloc/sign_up_bloc/sign_up_cubit.dart';
import 'package:text_to_audio/presentation/bloc/text/cubit/selected_text_cubit.dart';
import 'package:text_to_audio/presentation/bloc/update_user/cubit/update_user_cubit.dart';
import 'package:text_to_audio/presentation/bloc/user_list/cubit/user_list_cubit.dart';
import 'package:text_to_audio/presentation/bloc/user_text_audio_list/cubit/user_text_audio_list_cubit.dart';

class Dependency {
  static final sl = GetIt.instance;
  Dependency._();
  static Future<void> init() async {
    //domain
    sl.registerLazySingleton(() => GetCurrentUserUC(sl()));
    sl.registerLazySingleton(() => SetCurrentUserUC(sl()));
    sl.registerLazySingleton(() => CreateUserUC(sl()));
    sl.registerLazySingleton(() => GetUserListUC(sl()));
    sl.registerLazySingleton(() => DeleteUserUC(sl()));
    sl.registerLazySingleton(() => GetUserToUpdateUC(sl()));
    sl.registerLazySingleton(() => SetUserToUpateUC(sl()));
    sl.registerLazySingleton(() => UpdateUserUC(sl()));

    sl.registerLazySingleton(() => GetSelectedTextChunkUC(sl()));
    sl.registerLazySingleton(() => GetNewTextChunkUC(sl()));
    sl.registerLazySingleton(() => SetCurrentTextUC(sl()));

    sl.registerLazySingleton(() => GetCurrentAudioUC(sl()));
    sl.registerLazySingleton(() => ClearCurrentAudioUC(sl()));
    sl.registerLazySingleton(() => DeleteAudioUC(sl()));
    sl.registerLazySingleton(() => GetUserTextAudioListUC(sl()));
    sl.registerLazySingleton(() => SetCurrentAudioUC(sl()));

    sl.registerLazySingleton(() => AddUserTextAudioUC(sl(), sl()));
    sl.registerLazySingleton(() => DeleteUserTextAudioResetStatusUC(sl()));
    sl.registerLazySingleton(() => UploadTextAudioUC(sl()));

    sl.registerLazySingleton(() => LoginUC(sl()));
    sl.registerLazySingleton(() => CheckLoginStateUC(sl()));
    sl.registerLazySingleton(() => SignUpUC(sl()));

    //repo
    sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(sl()));
    sl.registerLazySingleton<TextChunkRepository>(
        () => TextRepositoryImpl(sl(), sl(), sl()));
    sl.registerLazySingleton<UserTextAudioRepository>(
        () => UserTextAudioRepositoryImpl(sl(), sl(), sl()));
    sl.registerLazySingleton<AudioRepository>(() => AudioRepositoryImpl(sl()));
    sl.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(sl(), sl(), sl(), sl(), sl()));

    //data
    sl.registerLazySingleton<UserLocalSource>(() => UserLocalSourceImpl(sl()));
    sl.registerLazySingleton<TextChunkLocalSource>(
        () => TextChunkLocalSourceImpl(sl()));
    sl.registerLazySingleton<TextChunkApi>(() => TextChunkApiImpl(sl()));
    sl.registerLazySingleton<ConnectionChecker>(
        () => ConnectionCheckerImpl(sl()));
    sl.registerLazySingleton<UserTextAudioLocalSource>(
        () => UserTextAudioLocalSourceImpl(sl()));
    sl.registerLazySingleton<UserTextAudioApi>(
        () => UserTextAudioApiImpl(sl()));
    sl.registerLazySingleton<FileManager>(() => FileManagerImpl());
    sl.registerLazySingleton<GoogleLoginSource>(
        () => GoogleLoginSourceImpl(sl()));
    sl.registerLazySingleton<LoginApi>(() => LoginApiImpl(sl()));
    sl.registerLazySingleton<LoginResponseSource>(
        () => LoginResponseSourceImpl(sl()));
    sl.registerLazySingleton<SignUpApi>(() => SignUpApiImpl(sl()));
    sl.registerLazySingleton(() => LogoutUC(sl()));

    sl.registerLazySingleton<ApiHeaderProvider>(
        () => ApiHeaderProviderImpl(sl()));

    //3rd party
    sl.registerLazySingleton<DataConnectionChecker>(
      () => DataConnectionChecker(),
    );
    sl.registerLazySingleton<GoogleSignIn>(
      () => GoogleSignIn(
        scopes: [
          'email',
          'https://www.googleapis.com/auth/contacts.readonly',
          'https://www.googleapis.com/auth/userinfo.profile',
        ],
      ),
    );

    await Hive.initFlutter();
    // _userBox
    Hive.registerAdapter(UserAdapter());
    final Box<User> userBox = await Hive.openBox('users');
    sl.registerLazySingleton<Box<User>>(() => userBox);
    // _textChunkBox
    Hive.registerAdapter(TextChunkAdapter());
    final Box<TextChunk> textChunkBox = await Hive.openBox('text_chunks');
    sl.registerLazySingleton<Box<TextChunk>>(() => textChunkBox);
    // _textChunkBox
    Hive.registerAdapter(AudioAdapter());
    final Box<Audio> audioBox = await Hive.openBox('audios');
    sl.registerLazySingleton<Box<Audio>>(() => audioBox);
    //_userTextAudioBox
    Hive.registerAdapter(UserTextAudioAdapter());
    final Box<UserTextAudio> userTextAudioBox =
        await Hive.openBox('user_text_audios');
    sl.registerLazySingleton<Box<UserTextAudio>>(() => userTextAudioBox);
    //_loginResponseBox
    Hive.registerAdapter(LoginSuccessResponseAdapter());
    final Box<LoginSuccessResponse> loginSuccessResponseBox =
        await Hive.openBox('login_success_responses');
    sl.registerLazySingleton<Box<LoginSuccessResponse>>(
        () => loginSuccessResponseBox);
  }

  static final providers = <BlocProvider>[
    BlocProvider<CurrentUserCubit>(
      create: (_) => CurrentUserCubit(sl(), sl()),
    ),
    BlocProvider<SignUpCubit>(
      create: (_) => SignUpCubit(sl()),
    ),
    BlocProvider<UserListCubit>(
      create: (_) => UserListCubit(sl())..getUserList(),
    ),
    BlocProvider<DeleteUserCubit>(
      create: (_) => DeleteUserCubit(sl()),
    ),
    BlocProvider<SetUserToUpdateCubit>(
      create: (_) => SetUserToUpdateCubit(sl()),
    ),
    BlocProvider<GetUserToUpdateCubit>(
      create: (context) => GetUserToUpdateCubit(sl())..getUser(),
    ),
    BlocProvider<UpdateUserCubit>(
      create: (_) => UpdateUserCubit(sl()),
    ),
    BlocProvider<SelectedTextCubit>(
      create: (_) =>
          SelectedTextCubit(sl(), sl(), sl())..getSelectedTextChunk(),
    ),
    BlocProvider<CurrentUserTextAudioCubit>(
      create: (_) => CurrentUserTextAudioCubit(sl(), sl(), sl()),
    ),
    BlocProvider<UserTextAudioListCubit>(
      create: (_) =>
          UserTextAudioListCubit(sl(), sl(), sl())..getUserTextAudioList(),
    ),
    BlocProvider<CurrentAudioCubit>(
      create: (_) =>
          CurrentAudioCubit(sl(), sl(), sl(), sl())..getCurrentAudio(),
    ),
    BlocProvider<AuthCubit>(
      create: (_) => AuthCubit(sl(), sl()),
    ),
    BlocProvider<SessionCubit>(create: (_) => SessionCubit(sl())..getSession()),
  ];
}
