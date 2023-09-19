part of 'pokemon_list_bloc.dart';

@immutable
sealed class PokemonListState {}

abstract class PokemonListActionState extends PokemonListState {}

final class PokemonListInitial extends PokemonListState {}

final class LoadedPokemons extends PokemonListState {
  final List<Pokemon> pokemonList;
  LoadedPokemons({required this.pokemonList});
  List<Object> get props => [pokemonList];
}

final class CompletedLoadPokemons extends PokemonListState {
  final List<Pokemon> pokemonList;
  CompletedLoadPokemons({required this.pokemonList});
  List<Object> get props => [pokemonList];
}

final class ErrorState extends PokemonListState {
  final String message;
  ErrorState({required this.message});
  List<Object> get props => [message];
}
