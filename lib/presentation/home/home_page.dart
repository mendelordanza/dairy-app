import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:night_diary/domain/models/answer.dart';
import 'package:night_diary/helper/extensions/date_time.dart';
import 'package:night_diary/helper/route_strings.dart';
import 'package:night_diary/presentation/home/bloc/entry_bloc.dart';
import 'package:night_diary/presentation/paywall/paywall_page.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../injection_container.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<EntryBloc>(),
      child: HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  showPaywall(BuildContext context) async {
    try {
      final offerings = await Purchases.getOfferings();
      if (context.mounted && offerings.current != null) {
        await showModalBottomSheet(
          isDismissible: true,
          isScrollControlled: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
          ),
          context: context,
          builder: (BuildContext context) {
            return StatefulBuilder(
                builder: (BuildContext context, StateSetter setModalState) {
              return PaywallPage(
                offering: offerings.current!,
              );
            });
          },
        );
      }
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: false,
        title: const Text(
          "Good evening, Ralph!",
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              //context.read<AuthBloc>().add(LogoutRequest());
              showPaywall(context);
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
          context.push(
            RouteStrings.addEntry,
            extra: context.read<EntryBloc>(),
          );
        },
        child: const Icon(Icons.edit),
      ),
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
                      "entryBloc": context.read<EntryBloc>(),
                      "answerId": state.answerId,
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
                  return ListView.builder(
                    itemCount: state.entries.length,
                    itemBuilder: (context, index) {
                      final item = state.entries[index];
                      return EntryItem(answer: item);
                    },
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
        context.push(RouteStrings.entry, extra: answer);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: Theme.of(context).cardColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                answer.createdAt.formatDate(pattern: "MMM. dd, yyyy - H:mm a"),
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
    );
  }
}
