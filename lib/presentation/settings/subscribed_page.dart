import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:night_diary/helper/extensions/date_time.dart';
import 'package:night_diary/presentation/purchase/purchase_bloc.dart';

class SubscribedPage extends HookWidget {
  const SubscribedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SvgPicture.asset(
              "assets/icons/ic_arrow_left.svg",
            ),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "You are a Pro!",
              textAlign: TextAlign.center,
            ),
            SvgPicture.asset("assets/ic_logo.svg"),
            BlocBuilder<PurchaseBloc, PurchaseState>(
              builder: (context, state) {
                if (state is PurchaseLoaded && state.entitled) {
                  return Column(
                    children: [
                      Text(
                          "Purchase Date: ${DateTime.parse(state.info.originalPurchaseDate).formatDate(pattern: "MMMM dd, yyyy")}"),
                      if (state.info.expirationDate != null)
                        Text("Renewal Date: ${state.info.expirationDate}"),
                    ],
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
