part of 'pokemon_detail_bloc.dart';

@immutable
sealed class PokemonDetailEvent {}

class PokemonDetailInitialEvent extends PokemonDetailEvent {
  final String url;
  PokemonDetailInitialEvent(this.url);
  List<Object> get props => [url];
}
