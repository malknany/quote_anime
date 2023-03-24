part of 'myquote_cubit.dart';

@immutable
abstract class MyquoteState {}

class MyquoteInitial extends MyquoteState {}

class GetTenOfQuotes extends MyquoteState {
  final List<QuoteModel> quotes;
  GetTenOfQuotes(this.quotes);
}

class GetTenOfQuotesByCharacter extends MyquoteState {
  final List<QuoteModel> quotes;
  GetTenOfQuotesByCharacter(this.quotes);
}

class LoadingCharacter extends MyquoteState{}

class EmptyCharacter extends MyquoteState{}