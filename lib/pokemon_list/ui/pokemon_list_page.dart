import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/pokemon_list/bloc/pokemon_list_bloc.dart';

class PokemonListPage extends StatefulWidget {
  const PokemonListPage({super.key});

  @override
  State<PokemonListPage> createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokemonListPage> {
  PokemonListBloc pokemonListBloc = PokemonListBloc();
  RegExp regex = RegExp(r'/(\d+)/$');

  String extractId(String url) {
    Match? match = regex.firstMatch(url);

    if (match != null) {
      String pokemonId = match.group(1)!;
      print(pokemonId);
      return pokemonId;
    } else {
      return "No ID found in the URL";
    }
  }

  @override
  void initState() {
    super.initState();
    pokemonListBloc.add(PokemonListInitialEvent());
    if (pokemonListBloc.isLoading) {
      print("INIT");
    } else {
      print("INIT2");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer(
        bloc: pokemonListBloc,
        builder: (context, state) {
          // if (pokemonListBloc.isLoading) {
          //   return const Center(
          //     child: CircularProgressIndicator(),
          //   );
          // }
          return CustomScrollView(
            slivers: [
              const SliverAppBar.large(
                title: Text("Pokedex"),
              ),
              (pokemonListBloc.isLoading)
                  ? const SliverFillRemaining(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : SliverGrid(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return Padding(
                          padding: index % 2 == 0
                              ? const EdgeInsets.only(left: 12)
                              : const EdgeInsets.only(right: 12),
                          child: Card(
                            child: InkWell(
                              onTap: () {
                                print("yuhu");
                              },
                              child: Stack(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Positioned(
                                      top: 10,
                                      left: 10,
                                      child: Text(
                                        pokemonListBloc.pokemonList[index].name
                                            .capitalize(),
                                        style: const TextStyle(fontSize: 20),
                                        overflow: TextOverflow.ellipsis,
                                      )),
                                  Positioned(
                                      bottom: 10,
                                      right: 10,
                                      child: CachedNetworkImage(
                                          imageUrl:
                                              "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${extractId(pokemonListBloc.pokemonList[index].url)}.png"))
                                ],
                              ),
                            ),
                          ),
                        );
                      }, childCount: pokemonListBloc.pokemonList.length),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10)),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Center(
                    child: pokemonListBloc.isLoading
                        ? CircularProgressIndicator()
                        : (state is LoadedPokemons)
                            ? TextButton(
                                onPressed: () {
                                  pokemonListBloc.add(PokemonListFetchEvent());
                                },
                                child: Text("Load More"))
                            : Container(),
                  ),
                ),
              )
            ],
          );
        },
        listener: (context, state) {},
        listenWhen: (previous, current) => current is PokemonListActionState,
        buildWhen: (previous, current) => current is! PokemonListActionState,
      ),
    );
  }
}

extension StringExtensions on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
