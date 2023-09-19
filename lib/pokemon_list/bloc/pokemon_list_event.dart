part of 'pokemon_list_bloc.dart';

@immutable
sealed class PokemonListEvent {}

class PokemonListInitialEvent extends PokemonListEvent {}

class PokemonListFetchEvent extends PokemonListEvent {}
