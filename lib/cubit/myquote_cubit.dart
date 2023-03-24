import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/model/quote_model.dart';
import '../data/repo/quote_repo.dart';

part 'myquote_state.dart';

class MyquoteCubit extends Cubit<MyquoteState> {
  MyquoteCubit(this.quoteRepo) : super(MyquoteInitial());
  QuoteRepo quoteRepo;
  List<QuoteModel> quotes = [];
  List<QuoteModel> quotesByCharacter = [];
  void emitGetTenQuotes() {
    quoteRepo.getTenQuote().then((value) {
      emit(GetTenOfQuotes(value));
      quotes = value;
    });
    emit(MyquoteInitial());
  }

  void emitQuoteByCharacter(String title) {
    quoteRepo.getQuoteByCharacter(title).then((value) {
      emit(GetTenOfQuotesByCharacter(value));
      quotesByCharacter = value;
    });
  }

  void emitLoadingCharacter() {
    emit(LoadingCharacter());
  }

  void emitEmptyCharacter() {
    emit(EmptyCharacter());
  }
}
