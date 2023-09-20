import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pokemon/pokemon_list/models/pokemon_list_model.dart';
import 'package:pokemon/pokemon_list/repository/pokemon_list_repository.dart';

part 'pokemon_list_event.dart';
part 'pokemon_list_state.dart';

class PokemonListBloc extends Bloc<PokemonListEvent, PokemonListState> {
  PokemonListBloc() : super(PokemonListInitial()) {
    on<PokemonListInitialEvent>(fetchFirst);
    on<PokemonListFetchEvent>(fetchNext);
  }

  PokemonListRepository pokemonService = PokemonListRepository();
  List<Pokemon> pokemonList = [];
  String nextUrl = "https://pokeapi.co/api/v2/pokemon";
  bool isLoading = false;

  FutureOr<void> fetchFirst(
      PokemonListInitialEvent event, Emitter<PokemonListState> emit) async {
    if (!isLoading) {
      isLoading = true;
      try {
        PokemonListModel? pokemonModel =
            await pokemonService.getPokemonList(nextUrl);
        if (pokemonModel == null) {
          emit(ErrorState(message: "Failed to fetch the pokemons"));
        } else {
          pokemonList.addAll(pokemonModel.results);
          nextUrl = pokemonModel.next ?? "";
          if (pokemonModel.next == null || pokemonModel.next == "") {
            emit(CompletedLoadPokemons(pokemonList: pokemonList));
            // yield CompletedLoadPokemons(pokemonList: pokemonList);
          } else {
            // yield LoadedPokemons(pokemonList: pokemonList);
            emit(LoadedPokemons(pokemonList: pokemonList));
          }
        }
      } catch (e) {
        // yield ErrorState(message: "Failed to fetch the pokemons");
        emit(ErrorState(message: "Failed to fetch the pokemons"));
      }
      isLoading = false;
    }
  }

  FutureOr<void> fetchNext(
      PokemonListFetchEvent event, Emitter<PokemonListState> emit) async {
    if (!isLoading) {
      isLoading = true;
      try {
        PokemonListModel? pokemonModel =
            await pokemonService.getPokemonList(nextUrl);
        if (pokemonModel == null) {
          emit(ErrorState(message: "Failed to fetch the pokemons"));
        } else {
          pokemonList.addAll(pokemonModel.results);
          nextUrl = pokemonModel.next ?? "";
          if (pokemonModel.next == null || pokemonModel.next == "") {
            emit(CompletedLoadPokemons(pokemonList: pokemonList));
            // yield CompletedLoadPokemons(pokemonList: pokemonList);
          } else {
            // yield LoadedPokemons(pokemonList: pokemonList);
            emit(LoadedPokemons(pokemonList: pokemonList));
          }
        }
      } catch (e) {
        // yield ErrorState(message: "Failed to fetch the pokemons");
        emit(ErrorState(message: "Failed to fetch the pokemons"));
      }
      isLoading = false;
    }
  }
}
