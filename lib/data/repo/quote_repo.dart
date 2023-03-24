import '../api_servies/quote_api.dart';
import '../model/quote_model.dart';

class QuoteRepo {
  final ApiService apiService;
  QuoteRepo(this.apiService);
  Future<List<QuoteModel>> getTenQuote() async {
    final response = await apiService.getTenQuote();
    return response.map((quote) => QuoteModel.fromJson(quote)).toList();
  }

  Future<List<QuoteModel>> getQuoteByCharacter(String character) async {
    final response = await apiService
        .getRandomTenQuoteByCharacter(queryParameters: {'name': character});
    return response.map((e) => QuoteModel.fromJson(e)).toList();
  }
}
