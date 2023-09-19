import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/pokemon_list/bloc/pokemon_list_bloc.dart';
import 'package:pokemon/pokemon_list/ui/pokemon_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => PokemonListBloc(),
        child: const PokemonListPage(),
      ),
      theme: ThemeData(useMaterial3: true),
    );
  }
}
