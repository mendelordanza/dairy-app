import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:night_diary/domain/models/answer.dart';
import 'package:night_diary/domain/models/diary_entry.dart';
import 'package:night_diary/helper/route_strings.dart';
import 'package:night_diary/presentation/auth/auth_bloc.dart';
import 'package:night_diary/presentation/home/bloc/entry_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Good evening, Ralph!",
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
          Expanded(
            child: BlocBuilder<EntryBloc, EntryState>(
              builder: (context, state) {
                if (state is EntryLoading) {
                  return const CircularProgressIndicator();
                }
                if (state is EntryLoaded) {
                  return ListView.builder(
                    itemCount: state.entries.length,
                    itemBuilder: (context, index) {
                      final item = state.entries[index];
                      return _entry(entry: item);
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

  Widget _entry({required DiaryEntry entry}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: entry.answers.map((e) => _entryItem(answer: e)).toList(),
      ),
    );
  }

  Widget _entryItem({required Answer answer}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text("${answer.question}"),
        Text("${answer.answer}"),
      ],
    );
  }
}
