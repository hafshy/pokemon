import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/pokemon_detail/bloc/pokemon_detail_bloc.dart';
import 'package:pokemon/pokemon_list/ui/pokemon_list_page.dart';

class PokemonDetailPage extends StatefulWidget {
  final String pokemonUrl;
  const PokemonDetailPage({super.key, required this.pokemonUrl});

  @override
  State<PokemonDetailPage> createState() => _PokemonDetailPageState();
}

class _PokemonDetailPageState extends State<PokemonDetailPage> {
  PokemonDetailBloc pokemonDetailBloc = PokemonDetailBloc();
  RegExp regex = RegExp(r'/(\d+)/$');

  String extractId(String url) {
    Match? match = regex.firstMatch(url);

    if (match != null) {
      String pokemonId = match.group(1)!;
      return pokemonId;
    } else {
      return "No ID found in the URL";
    }
  }

  @override
  void initState() {
    super.initState();
    pokemonDetailBloc.add(PokemonDetailInitialEvent(widget.pokemonUrl));
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer(
        bloc: pokemonDetailBloc,
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.redAccent,
            body: Stack(
              children: [
                Positioned(
                  top: 60,
                  left: 24,
                  child: Text(
                    pokemonDetailBloc.pokemonDetail != null
                        ? pokemonDetailBloc.pokemonDetail!.name.capitalize()
                        : "",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Positioned(
                  top: 68,
                  right: 32,
                  child: Text(
                    "#${extractId(widget.pokemonUrl)}",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Positioned(
                    bottom: 0,
                    child: Container(
                      width: width,
                      height: height * 0.7,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Height",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Weight",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Types",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text("Abilities",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold))
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        pokemonDetailBloc.pokemonDetail != null
                                            ? "${pokemonDetailBloc.pokemonDetail!.height} cm"
                                            : "",
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        pokemonDetailBloc.pokemonDetail != null
                                            ? "${pokemonDetailBloc.pokemonDetail!.weight} kg"
                                            : "",
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        pokemonDetailBloc.pokemonDetail != null
                                            ? pokemonDetailBloc
                                                .pokemonDetail!.types
                                                .map((e) =>
                                                    e.type.name.capitalize())
                                                .join(", ")
                                            : "",
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        pokemonDetailBloc.pokemonDetail != null
                                            ? pokemonDetailBloc
                                                .pokemonDetail!.abilities
                                                .map((e) =>
                                                    e.ability.name.capitalize())
                                                .join(", ")
                                            : "",
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    ],
                                  ),
                                ],
                              )
                            ],
                          )),
                    )),
                Positioned(
                    width: 240,
                    top: 80,
                    right: -40,
                    child: Opacity(
                      opacity: 0.5,
                      child: Image.asset(
                        "assets/pokeball.png",
                      ),
                    )),
                Positioned(
                    top: height * 0.25 - 100,
                    left: width * 0.5 - 100,
                    child: CachedNetworkImage(
                        height: 200,
                        fit: BoxFit.cover,
                        imageUrl:
                            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${extractId(widget.pokemonUrl)}.png")),
              ],
            ),
          );
        },
        listener: (context, state) {},
        listenWhen: (previous, current) => current is PokemonDetailActionState,
        buildWhen: (previous, current) => current is! PokemonDetailActionState,
      ),
    );
  }
}
