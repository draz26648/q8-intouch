import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q8intouch_task/business_logic/users_cubit/users_cubit.dart';
import 'package:q8intouch_task/presentation/screens/add_players_screen.dart';

import 'bloc_observer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.grey[50],
    statusBarIconBrightness: Brightness.dark,
  ));
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UsersCubit(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Q8-intouch task',
        home: AddPlayersScreen(),
      ),
    );
  }
}
