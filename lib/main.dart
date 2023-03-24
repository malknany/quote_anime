import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quote_api_cis/cubit/my_quote_observe.dart';
import 'cubit/myquote_cubit.dart';
import 'data/api_servies/quote_api.dart';
import 'data/repo/quote_repo.dart';
import 'screens/randome_quote/view.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: BlocProvider(
        create: (BuildContext context) => MyquoteCubit(QuoteRepo(ApiService())),
        child: const QuotesScreen(),
      ),
    );
  }
}
