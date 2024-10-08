import 'package:door_care/app_view.dart';
import 'package:door_care/feature/auth/auth_bloc/auth_bloc.dart';
import 'package:door_care/feature/auth/data/service/local/auth_local_service.dart';
import 'package:door_care/feature/auth/data/service/remote/auth_remote_service.dart';
import 'package:door_care/feature/auth/data/repository/auth_repo.dart';
import 'package:door_care/feature/navigation_menu/bloc/bloc/navigation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'feature/bookings/bloc/cancel_a_pending_service_bloc/cancel_a_booked_pending_service_bloc.dart';
import 'feature/bookings/data/repository/cancel_a_booked_pending_service_repo.dart';
import 'feature/bookings/data/service/remote/cancel_a_booked_pending_service.dart';
import 'feature/service/bloc/enter_details_bloc/enter_details_bloc.dart';
import 'feature/service/data/repository/book_service_repo.dart';
import 'feature/service/data/service/remote/book_service_remote_service.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepo(
            AuthRemoteService(),
            AuthLocalService(),
          ),
        ),
        RepositoryProvider(
          create: (context) => BookServiceRepo(
            BookServiceRemoteService(),
            AuthLocalService(),
          ),
        ),
         RepositoryProvider(
          create: (context) => CancelABookedPendingServiceRepo(
            CancelABookedPendingService(),
            AuthLocalService(),
          ),
        ),
        
       
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                AuthBloc(context.read<AuthRepo>())..add(CheckUserEvent()),
          ),
          BlocProvider(
            create: (context) => NavigationBloc(),
          ),
          BlocProvider(
            create: (context) =>
                EnterDetailsBloc(context.read<BookServiceRepo>()),
          ),
          BlocProvider(
            create: (context) =>
                CancelABookedPendingServiceBloc(context.read<CancelABookedPendingServiceRepo>()),
          ),
         
         
        ],
        child: const MyAppView(),
      ),
    );
  }
}
