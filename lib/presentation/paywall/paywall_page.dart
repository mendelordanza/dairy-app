import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:collection/collection.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:night_diary/helper/date_helper.dart';
import 'package:purchases_flutter/models/offering_wrapper.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import '../../helper/colors.dart';
import '../widgets/custom_button.dart';

class PaywallPage extends HookWidget {
  final bool isFromOnboarding;
  final Offering offering;

  PaywallPage({this.isFromOnboarding = false, required this.offering});

  restorePurchase(BuildContext context) async {
    try {
      await Purchases.restorePurchases().then((value) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("You are now a Pro!")));
        Navigator.pop(context);
      }).onError((error, stackTrace) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("No previous purchase found.")));
      });
    } on PlatformException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message ?? "Error")));
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState(offering.availablePackages.indexWhere(
        (element) => element.packageType.name == PackageType.annual.name));
    final isLoading = useState(false);

    final annualPerMonth = offering.annual!.storeProduct.price / 12;
    final saving = ((offering.monthly!.storeProduct.price - annualPerMonth) /
            offering.monthly!.storeProduct.price) *
        100;
    final introductory = offering
        .availablePackages[selectedIndex.value].storeProduct.introductoryPrice;
    final period = DateHelper.getPeriod(
      value: introductory!.periodNumberOfUnits,
      unit: introductory.periodUnit,
    );

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.95,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          24.0,
          16.0,
          24.0,
          0.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.close),
                ],
              ),
            ),
            Column(
              children: [
                SvgPicture.asset(
                  "assets/ic_logo.svg",
                  height: 100.0,
                ),
                const Text(
                  "Unlock Unlimited Affirmations",
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w800,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                const Text(
                  "Generate unlimited personal, inspirational, and motivational affirmations whenever and wherever",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextButton(
                    onPressed: () {
                      isLoading.value = true;
                      restorePurchase(context);
                      isLoading.value = false;
                    },
                    child: const Text(
                      "Restore Purchase",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Column(
                      children: [
                        Column(
                          children: offering.availablePackages
                              .mapIndexed((index, item) {
                            return priceItem(
                              context,
                              item: item,
                              isSelected: index == selectedIndex.value,
                              onTap: () {
                                selectedIndex.value = index;
                                //selectedProduct.value = item.storeProduct;
                              },
                              saving: saving,
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(bottom: isFromOnboarding ? 0.0 : 24.0),
                    child: CustomButton(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      height: 60.0,
                      onPressed: () async {
                        isLoading.value = true;
                        if (selectedIndex.value != -1) {
                          final item = offering
                              .availablePackages[selectedIndex.value]
                              .storeProduct;
                          await Purchases.purchaseStoreProduct(item)
                              .then((value) {
                            isLoading.value = false;
                            Navigator.pop(context);
                          }).onError((error, stackTrace) {
                            isLoading.value = false;
                          });
                        } else {
                          isLoading.value = false;
                        }
                      },
                      child: isLoading.value
                          ? const Center(
                              child: CircularProgressIndicator.adaptive(
                                backgroundColor: Colors.white,
                              ),
                            )
                          : Text(
                              "Start your $period free trial",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),
                  if (isFromOnboarding)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24.0),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("I'll do it later"),
                      ),
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget featureItem({
    required Widget icon,
    required String title,
    required String desc,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          icon,
          const SizedBox(
            width: 13.0,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  desc,
                  style: const TextStyle(
                    fontSize: 13.0,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget priceItem(
    BuildContext context, {
    required Package item,
    required bool isSelected,
    required Function() onTap,
    required double saving,
  }) {
    final per =
        item.packageType.name == PackageType.annual.name ? "year" : "month";
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: isSelected ? Colors.black : Theme.of(context).cardColor,
            border: isSelected
                ? null
                : Border.all(
                    color: Colors.grey.shade200,
                  ),
          ),
          padding: const EdgeInsets.all(24.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Checkbox(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0))),
                // Rounded Checkbox
                value: isSelected,
                activeColor: secondaryColor,
                checkColor: Colors.black,
                onChanged: (inputValue) {
                  onTap();
                },
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            item.storeProduct.title
                                .replaceAll(RegExp('\\(.*?\\)'), ''),
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                              ),
                              children: [
                                TextSpan(
                                  text: "Get ${DateHelper.getPeriod(
                                    value: item.storeProduct.introductoryPrice!
                                        .periodNumberOfUnits,
                                    unit: item.storeProduct.introductoryPrice!
                                        .periodUnit,
                                  )} free, then ",
                                ),
                                TextSpan(
                                  text: "${item.storeProduct.priceString}/$per",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (item.packageType.name == PackageType.annual.name)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: secondaryColor,
                          ),
                          child: RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                fontFamily: "Montserrat",
                                color: Colors.black,
                              ),
                              children: [
                                const TextSpan(
                                  text: "Save ",
                                ),
                                TextSpan(
                                  text: "${saving.toStringAsFixed(2)}%",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
