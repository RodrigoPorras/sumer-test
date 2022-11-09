import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sumer_test/screens/home/home.dart';
import 'package:sumer_test/screens/home/widgets/search_bar.dart';
import 'package:sumer_test/screens/home/widgets/sumer_image.dart';
import 'package:sumer_test/utils/default_dialog.dart';

class HomeUI extends StatelessWidget {
  static const path = '/home';
  final controller = TextEditingController();

  HomeUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeBloc = context.read<HomeBloc>();
    homeBloc.add(StartedEvent());

    return SafeArea(
      child: Scaffold(
          body: BlocConsumer<HomeBloc, HomeState>(
        buildWhen: (previous, current) =>
            current is LoadingState || current is DataLoadedState,
        listener: (context, state) {
          if (state is ErrorState) {
            showDefaultDialog(
              context,
              title: 'Sorry, We cant get the GIFs!',
              message: 'Error: ${state.errorMessage}',
            );
          }
        },
        builder: (context, state) {
          if (state is DataLoadedState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SearchBar(
                  controller: controller,
                  onSubmitted: (text) {
                    homeBloc.add(SearchGifsWithQueryEvent(text));
                  },
                  onClear: () {
                    controller.text = '';
                    homeBloc.add(StartedEvent());
                  },
                ),
                state.gifList.isNotEmpty
                    ? Expanded(
                        child: NotificationListener<ScrollEndNotification>(
                          onNotification: (scrollEnd) {
                            if (scrollEnd.metrics.atEdge &&
                                scrollEnd.metrics.pixels != 0 &&
                                state is! SearchNextPageEvent) {
                              homeBloc.add(SearchNextPageEvent(
                                thereIsAQuery: controller.text.isNotEmpty,
                                currentQuery: controller.text,
                              ));
                            }
                            return true;
                          },
                          child: SingleChildScrollView(
                            child: StaggeredGrid.count(
                              crossAxisCount: 2,
                              mainAxisSpacing: 4,
                              crossAxisSpacing: 4,
                              children: state.gifList
                                  .map(
                                    (gif) => SumerImage(
                                      url: gif.images.original.url ?? '',
                                      height: double.parse(
                                          gif.images.original.height!),
                                      boxFit: BoxFit.cover,
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                      )
                    : Column(
                        children: const [
                          Icon(Icons.warning),
                          Text('No Gifs Found')
                        ],
                      )
              ],
            );
          }
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.grey,
          ));
        },
      )),
    );
  }
}
