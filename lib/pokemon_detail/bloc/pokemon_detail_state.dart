part of 'pokemon_detail_bloc.dart';

@immutable
sealed class PokemonDetailState {}

abstract class PokemonDetailActionState extends PokemonDetailState {}

final class PokemonDetailInitial extends PokemonDetailState {}

final class LoadedPokemonDetail extends PokemonDetailState {
  final PokemonDetailModel pokemon;
  LoadedPokemonDetail({required this.pokemon});
  List<Object> get props => [pokemon];
}

final class ErrorState extends PokemonDetailState {
  final String message;
  ErrorState({required this.message});
  List<Object> get props => [message];
}
