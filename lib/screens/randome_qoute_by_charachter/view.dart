import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/myquote_cubit.dart';

class RandomQuoteScreen extends StatefulWidget {
  const RandomQuoteScreen({super.key});

  @override
  State<RandomQuoteScreen> createState() => _RandomQuoteScreenState();
}

class _RandomQuoteScreenState extends State<RandomQuoteScreen> {
  TextEditingController controllerText = TextEditingController();
  @override
  void initState() {
    BlocProvider.of<MyquoteCubit>(context).emitEmptyCharacter();
    super.initState();
  }

  bool isSearch = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.teal,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                BlocProvider.of<MyquoteCubit>(context).emitLoadingCharacter();
                BlocProvider.of<MyquoteCubit>(context)
                    .emitQuoteByCharacter(controllerText.text);
              });
            },
            icon: const Icon(
              size: 35,
              Icons.search,
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
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: controllerText,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: Colors.teal,
                      strokeAlign: BorderSide.strokeAlignOutside,
                    ),
                  ),
                  hintText: 'Search....',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 10,
            child: BlocBuilder<MyquoteCubit, MyquoteState>(
              builder: (context, state) {
                if (state is GetTenOfQuotesByCharacter) {
                  final quote =
                      BlocProvider.of<MyquoteCubit>(context).quotesByCharacter;
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
                              )),
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
                } else if (state is LoadingCharacter) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.teal),
                  );
                } else if (state is EmptyCharacter) {
                  return const SizedBox.shrink();
                } else {
                  return Container(
                    color: Colors.black,
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
