import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:newsee/AppData/app_route_constants.dart';
import 'package:newsee/AppSamples/ReactiveForms/view/camera_view.dart';
import 'package:newsee/AppSamples/ReactiveForms/view/login-with-account.dart';

import 'package:newsee/AppSamples/ReactiveForms/view/loginpage_view.dart';
import 'package:newsee/AppSamples/ToolBarWidget/view/toolbar_view.dart';
import 'package:newsee/Model/login_request.dart';
import 'package:newsee/blocs/camera/camera.dart';
import 'package:newsee/blocs/camera/camera_bloc.dart';
import 'package:newsee/blocs/camera/camera_event.dart';
import 'package:newsee/blocs/login/login_bloc.dart';
import 'package:newsee/core/api/api_client.dart';
import 'package:newsee/feature/auth/data/datasource/auth_remote_datasource.dart';
import 'package:newsee/feature/auth/data/repository/auth_repository_impl.dart';
import 'package:newsee/feature/auth/domain/repository/auth_repository.dart';
import 'package:newsee/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:newsee/feature/lead_details/presentation/page/lead_details_view.dart';
import 'package:newsee/pages/home_page.dart';
import 'package:newsee/pages/newlead_page.dart';
import 'package:newsee/pages/not_found_error.page.dart';
import 'package:newsee/pages/profile_page.dart';

final AuthRemoteDatasource _authRemoteDatasource = AuthRemoteDatasource(
  dio: ApiClient().getDio(),
);
final AuthRepository = AuthRepositoryImpl(
  authRemoteDatasource: _authRemoteDatasource,
);
final routes = GoRouter(
  initialLocation: '/home',
  
  routes: <RouteBase>[
    GoRoute(
      path: AppRouteConstants.LOGIN_PAGE['path']!,
      name: AppRouteConstants.LOGIN_PAGE['name'],
      builder:
          (context, state) => Scaffold(
            body: BlocProvider(
              create: (_) => AuthBloc(authRepository: AuthRepository),
              child: LoginpageView(),
            ),
          ),
    ),
    GoRoute(
      path: AppRouteConstants.HOME_PAGE['path']!,
      name: AppRouteConstants.HOME_PAGE['name'],
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
      path: AppRouteConstants.NEWLEAD_PAGE['path']!,
      name: AppRouteConstants.NEWLEAD_PAGE['name'],
      // builder: (context, state) => NewLeadPage(),
      builder: (context, state) => LeadDetailsView(),
    ),
    
    GoRoute(
      path: AppRouteConstants.PROFILE_PAGE['path']!,
      name: AppRouteConstants.PROFILE_PAGE['name'],
      builder: (context, state) => 
        ProfilePage()
    ),
    GoRoute(
      path: AppRouteConstants.CAMERA_PAGE['path']!,
      name: AppRouteConstants.CAMERA_PAGE['name'],
      builder:
        (context, state) => Scaffold(
          body: BlocProvider(
            // create: (_) => CameraBloc()..add(CameraOpen()),
            create: (_) => GetIt.instance.get<CameraBloc>()..add(CameraOpen()),
            child: CameraView(),
          ),
        ),
    )
  ],
  redirect: (context, state) {
    print(state.fullPath);
    if (state.fullPath == '/') {
      return '/login';
    } else {
      return null;
    }
  },
  errorBuilder: (context, state) => NotFoundErrorPage(),
);
