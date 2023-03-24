import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/myquote_cubit.dart';
import '../../data/api_servies/quote_api.dart';
import '../../data/repo/quote_repo.dart';
import '../randome_qoute_by_charachter/view.dart';

class QuotesScreen extends StatefulWidget {
  const QuotesScreen({super.key});

  @override
  State<QuotesScreen> createState() => _QuotesScreenState();
}

class _QuotesScreenState extends State<QuotesScreen> {
  @override
  void initState() {
    BlocProvider.of<MyquoteCubit>(context).emitGetTenQuotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              //BlocProvider.of<MyquoteCubit>(context).emitGetTenQuotes();
              // anotherWay
              context.read<MyquoteCubit>().emitGetTenQuotes();
            },
            icon: const Icon(
              size: 35,
              Icons.refresh,
              color: Colors.teal,
            ),
          ),
        ],
        title: const Text('Quotes App',
            style: TextStyle(color: Colors.teal, fontSize: 20)),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
              child: Column(
            children: [
              OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.teal,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) =>
                                MyquoteCubit(QuoteRepo(ApiService())),
                            child: const RandomQuoteScreen(),
                          ),
                        ));
                  },
                  child: const Text(
                    'Qoute By Character',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )),
            ],
          )),
          Expanded(
            flex: 15,
            child: BlocBuilder<MyquoteCubit, MyquoteState>(
              builder: (context, state) {
                if (state is GetTenOfQuotes) {
                  final quote = BlocProvider.of<MyquoteCubit>(context).quotes;
                  return ListView.builder(
                    itemCount: quote.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => Container(
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "${index + 1}-  ${quote[index].quote.toString()}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            quote[index].character.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.teal,
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
