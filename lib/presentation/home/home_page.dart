import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:night_diary/domain/models/answer.dart';
import 'package:night_diary/helper/extensions/date_time.dart';
import 'package:night_diary/helper/route_strings.dart';
import 'package:night_diary/presentation/home/bloc/entry_bloc.dart';
import 'package:night_diary/presentation/quote/bloc/quote_bloc.dart';

import '../../injection_container.dart';
import '../quote/bloc/quote_event.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<EntryBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<QuoteBloc>(),
        ),
      ],
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: double.maxFinite,
          width: double.maxFinite,
          child: Image.asset(
            "assets/background.png",
            fit: BoxFit.fill,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            centerTitle: false,
            title: const Text(
              "Welcome back!",
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w700,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  context.push(RouteStrings.settings);
                },
                icon: const Icon(
                  Icons.settings,
                ),
              ),
            ],
          ),
          body: SafeArea(
            bottom: false,
            child: _buildBody(context),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.read<QuoteBloc>().add(ResetQuote());
              context.read<QuoteBloc>().add(ResetCount());
              context.push(
                RouteStrings.addEntry,
                extra: {
                  "entryBloc": context.read<EntryBloc>(),
                  "quoteBloc": context.read<QuoteBloc>()
                },
              );
            },
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: BlocConsumer<EntryBloc, EntryState>(
              listener: (context, state) {
                if (state is EntryAdded) {
                  context.push(
                    RouteStrings.quote,
                    extra: {
                      "quoteBloc": context.read<QuoteBloc>(),
                      "entryBloc": context.read<EntryBloc>(),
                      "answer": state.answer,
                      "prompt": state.text,
                    },
                  );
                }
              },
              builder: (context, state) {
                if (state is EntryLoading) {
                  return const Center(
                      child: CircularProgressIndicator.adaptive());
                }
                if (state is EntryLoaded) {
                  if (state.entries.isNotEmpty) {
                    return ListView.builder(
                      itemCount: state.entries.length,
                      itemBuilder: (context, index) {
                        final item = state.entries[index];
                        return EntryItem(answer: item);
                      },
                    );
                  }
                  return const Center(
                    child: Text(
                      "No entries. Click + to add an entry",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  );
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class EntryItem extends StatelessWidget {
  final Answer answer;

  const EntryItem({required this.answer, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push(
          RouteStrings.entry,
          extra: {
            "quoteBloc": context.read<QuoteBloc>(),
            "entryBloc": context.read<EntryBloc>(),
            "answer": answer,
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Slidable(
          // Specify a key if the Slidable is dismissible.
          key: ValueKey(answer.id!),

          // The end action pane is the one at the right or the bottom side.
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {
                  context.read<EntryBloc>().add(DeleteEntry(answer.id!));
                },
                autoClose: true,
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
                borderRadius: const BorderRadius.all(Radius.circular(16.0)),
              ),
            ],
          ),

          // The child of the Slidable is what the user sees when the
          // component is not dragged.
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.0),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.grey.shade700.withOpacity(0.9),
                  Colors.grey.shade800.withOpacity(0.7),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  answer.createdAt
                      .formatDate(pattern: "MMM. dd, yyyy - H:mm a"),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Text(
                  "${answer.answer}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (answer.quote != null)
                  Column(
                    children: [
                      const SizedBox(
                        height: 16.0,
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '" ${answer.quote} "',
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700,
                            height: 1.3,
                          ),
                        ),
                      ),
                    ],
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
