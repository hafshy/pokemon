import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pokemon/pokemon_detail/models/pokemon_detail_model.dart';
import 'package:pokemon/pokemon_detail/repository/pokemon_detail_repository.dart';

part 'pokemon_detail_event.dart';
part 'pokemon_detail_state.dart';

class PokemonDetailBloc extends Bloc<PokemonDetailEvent, PokemonDetailState> {
  PokemonDetailBloc() : super(PokemonDetailInitial()) {
    on<PokemonDetailInitialEvent>(fetchDetail);
  }

  PokemonDetailRepository pokemonService = PokemonDetailRepository();
  PokemonDetailModel? pokemonDetail;
  String name = "";
  String nextUrl = "https://pokeapi.co/api/v2/pokemon";
  bool isLoading = false;

  FutureOr<void> fetchDetail(
      PokemonDetailEvent event, Emitter<PokemonDetailState> emit) async {
    if (!isLoading) {
      isLoading = true;
      try {
        PokemonDetailModel? pokemonModel =
            await pokemonService.getPokemonDetail(
                event is PokemonDetailInitialEvent ? event.url : "");
        if (pokemonModel == null) {
          emit(ErrorState(message: "Failed to fetch the pokemons"));
        } else {
          pokemonDetail = pokemonModel;
          name = pokemonModel.name;
          emit(LoadedPokemonDetail(pokemon: pokemonModel));
        }
      } catch (e) {
        // yield ErrorState(message: "Failed to fetch the pokemons");
        emit(ErrorState(message: "Failed to fetch the pokemons"));
      }
      isLoading = false;
    }
  }
}
