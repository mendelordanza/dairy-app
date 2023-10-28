import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:social_share/social_share.dart';

import '../../config_reader.dart';

class ShareSheet extends StatelessWidget {
  final String imagePath;

  const ShareSheet({required this.imagePath, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        16.0,
        4.0,
        16.0,
        16.0,
      ),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Text(
              "Share",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Wrap(
              children: [
                shareItem(
                  onTap: () {
                    print("IG");
                    // SocialShare.shareInstagramStory(
                    //   appId: ConfigReader.getFacebookId(),
                    //   imagePath: imagePath,
                    // ).then((data) {
                    //   Navigator.pop(context);
                    // }).onError((error, stackTrace) {
                    //   print("$error");
                    // });
                  },
                  icon: SvgPicture.asset(
                    "assets/ic_ig.svg",
                    height: 40.0,
                  ),
                  title: "Instagram\nStories",
                ),
                shareItem(
                  onTap: () {
                    SocialShare.shareFacebookStory(
                      appId: ConfigReader.getFacebookId(),
                      imagePath: imagePath,
                    ).then((data) {
                      Navigator.pop(context);
                    }).onError((error, stackTrace) {
                      print("$error");
                    });
                  },
                  icon: Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      top: 8.0,
                      right: 8.0,
                    ),
                    child: SvgPicture.asset(
                      "assets/ic_fb.svg",
                      height: 30.0,
                      color: Colors.white,
                    ),
                  ),
                  title: "Facebook\nStories",
                ),
                shareItem(
                  onTap: () {
                    SocialShare.shareOptions(
                      "",
                      imagePath: imagePath,
                    ).then((data) {
                      Navigator.pop(context);
                    });
                  },
                  color: Colors.grey,
                  icon: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.more_horiz,
                      color: Colors.white,
                    ),
                  ),
                  title: "More",
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget shareItem({
    required Function() onTap,
    required Widget icon,
    Color? color = Colors.blue,
    required String title,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              child: icon,
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
