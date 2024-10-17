import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../screens/main_page/bloc/mainpage_bloc.dart';
import '../../screens/main_page/bloc/mainpage_bloc_state.dart';

class SearchDetail extends StatefulWidget {
  const SearchDetail({super.key});

  @override
  State<SearchDetail> createState() => _SearchDetailState();
}

class _SearchDetailState extends State<SearchDetail> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: BlocBuilder<MainPageBloc, MainPageBlocState>(
            builder: (context, state) {
              if (state is LoadedScreenIndexMainPageBlocState) {
                return TextFormField(
                  onTap: () {
                    if (state.index == 0) {
                      context.read<MainPageBloc>().selectScreen(1);
                    }
                  },
                  onChanged: (value) {
                    print("bu value");

                    //
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.search,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    hintText: "Search Product",
                  ),
                );
              }
              return Container();
            },
          ),
        ),
      ],
    );
  }
}
