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
          if (pokemonListBloc.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
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
                        return Container(
                          color: Colors.blue,
                          child: Center(
                            child:
                                Text(pokemonListBloc.pokemonList[index].name),
                          ),
                        );
                      }, childCount: pokemonListBloc.pokemonList.length),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10))
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
