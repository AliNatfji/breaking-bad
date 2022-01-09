import 'package:breaking_bad/constants/string.dart';
import 'package:breaking_bad/presentation/screens/characters_details.dart';
import 'package:breaking_bad/presentation/screens/characters_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'business_logic/cubit/characters_cubit.dart';
import 'data/models/character.dart';
import 'data/respository/characters_repository.dart';
import 'data/web_services/characters_web_services.dart';

class AppRouter {
  late CharactersRepository charactersRepository;
  late CharactersCubit charactersCubit;

  AppRouter()
  {
    charactersRepository = CharactersRepository(CharactersWebServices());
    charactersCubit = CharactersCubit(charactersRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name)
    {
      case charactersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => charactersCubit,
            child: const CharactersScreen(),
          ),
        );

      case characterDetailsScreen:
        final character = settings.arguments as Character;

        return MaterialPageRoute(
            builder: (_) => BlocProvider(
          create: (BuildContext context) =>
              CharactersCubit(charactersRepository),
          child: CharacterDetailsScreen(
            character: character,
          ),
        ),
     );
    }
  }
}