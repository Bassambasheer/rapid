import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rapidd_technologies/Utils/context_extension.dart';
import 'package:rapidd_technologies/riverpods/auth_pod.dart';
import 'package:rapidd_technologies/riverpods/profile_pod.dart';
import 'package:rapidd_technologies/screens/login_screen.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileNotifier = ref.watch(profileProvider);
    profileNotifier.getUserData();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        title: Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: GoogleFonts.inter().fontFamily,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: profileNotifier.data != null
            ? Column(
                children: [
                  Card(
                    clipBehavior: Clip.antiAlias,
                    shadowColor: HexColor('#dbdfe5'),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 5,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      padding: const EdgeInsets.all(12),
                      width: context.getWidth() * 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(children: [
                            CachedNetworkImage(
                              height: 100,
                              width: 100,
                              imageUrl:
                                  'https://media.istockphoto.com/id/587805156/vector/profile-picture-vector-illustration.jpg?s=1024x1024&w=is&k=20&c=N14PaYcMX9dfjIQx-gOrJcAUGyYRZ0Ohkbj5lH-GkQs=',
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15)),
                                ),
                              ),
                              placeholder: (context, url) => Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        'https://media.istockphoto.com/id/587805156/vector/profile-picture-vector-illustration.jpg?s=1024x1024&w=is&k=20&c=N14PaYcMX9dfjIQx-gOrJcAUGyYRZ0Ohkbj5lH-GkQs='),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const DecoratedBox(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        'https://media.istockphoto.com/id/587805156/vector/profile-picture-vector-illustration.jpg?s=1024x1024&w=is&k=20&c=N14PaYcMX9dfjIQx-gOrJcAUGyYRZ0Ohkbj5lH-GkQs='),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ]),
                          const SizedBox(
                            width: 20,
                          ),
                          Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 200,
                                      child: Text(
                                        profileNotifier.data!['name'] ?? '',
                                        maxLines: 2,
                                        style: TextStyle(
                                          fontFamily: GoogleFonts.inter(
                                                  fontWeight: FontWeight.w600)
                                              .fontFamily,
                                          fontSize: 22,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            profileNotifier.data!['email'] ??
                                                '',
                                            maxLines: 2,
                                            style: TextStyle(
                                              fontFamily: GoogleFonts.inter(
                                                      fontWeight:
                                                          FontWeight.w600)
                                                  .fontFamily,
                                              fontSize: 18,
                                              color: HexColor('#8a96a0'),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ProfileDetailsRow(
                    title: 'User Id',
                    value: profileNotifier.data!['uid'],
                  ),
                  ProfileDetailsRow(
                    title: 'Created At',
                    value: DateTime.fromMicrosecondsSinceEpoch(
                            int.parse(profileNotifier.data!['createdAt']))
                        .toString(),
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  Consumer(
                    builder: (context, ref, child) {
                      final authNotifier = ref.watch(authProvider);
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            authNotifier.userSignOut();
                            context.navigateToScreen(
                                child: LoginScreen(), isReplace: true);
                          },
                          child: Container(
                            width: 130,
                            height: 40,
                            padding: const EdgeInsets.only(
                                top: 6, left: 8, right: 12, bottom: 6),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.red,
                                )),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: Icon(
                                      Icons.logout,
                                      color: Colors.red,
                                      size: 16,
                                    )),
                                const SizedBox(width: 8),
                                Text(
                                  'Logout',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 14,
                                    fontFamily: GoogleFonts.roboto().fontFamily,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )
                ],
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}

class ProfileDetailsRow extends StatelessWidget {
  const ProfileDetailsRow(
      {super.key,
      required this.title,
      this.value,
      this.hasBorder = true,
      this.hasIcon = false,
      this.valueList,
      this.isFile = false});

  final String title;
  final bool hasIcon;
  final String? value;
  final List<String>? valueList;
  final bool hasBorder;
  final bool isFile;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        bottom: 6,
      ),
      width: context.getWidth() * 0.9,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      color: HexColor('#8e9aa6'),
                      fontSize: 12,
                      fontFamily: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                      ).fontFamily,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  value != null
                      ? Text(
                          value ?? '',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                            ).fontFamily,
                          ),
                        )
                      : valueList != null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: valueList!
                                  .map(
                                    (e) => Text(
                                      '- $e',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: GoogleFonts.inter(
                                          fontWeight: FontWeight.w500,
                                        ).fontFamily,
                                      ),
                                    ),
                                  )
                                  .toList(),
                            )
                          : Text(
                              '',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                ).fontFamily,
                              ),
                            ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          hasBorder
              ? Divider(
                  color: HexColor('#8e9aa6'),
                  thickness: 0.5,
                )
              : Container(),
        ],
      ),
    );
  }
}
