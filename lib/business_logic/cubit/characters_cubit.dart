import 'package:bloc/bloc.dart';
import 'package:breaking_bad/data/models/character.dart';
import 'package:breaking_bad/data/models/quote.dart';
import 'package:breaking_bad/data/respository/characters_repository.dart';
import 'package:flutter/cupertino.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository charactersRepository;
  List<Character> characters = [];

  CharactersCubit(this.charactersRepository) : super(CharactersInitial());

  List<Character> getAllCharacters() {
    charactersRepository.getAllCharacters().then((characters) {
      emit(CharactersLoaded(characters));
      this.characters = characters;
    });

    return characters;
  }

void getQuotes(String charName) {
  charactersRepository.getCharacterQuotes(charName).then((quotes) {
    emit(QuotesLoaded(quotes));
  });
}
}

