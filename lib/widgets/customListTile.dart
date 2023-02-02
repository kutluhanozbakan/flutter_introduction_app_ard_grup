// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_introduction_app_ard_grup/utils/themes.dart';

import '../utils/styles_themes.dart';
import 'customIconButtonSmall.dart';

class OcasListTile extends StatefulWidget {
  final IconData? icon;
  final String baslik;
  final String icerik;
  const OcasListTile(
      {Key? key, this.icon, this.baslik = "Başlık", this.icerik = "İçerik"})
      : super(key: key);

  @override
  State<OcasListTile> createState() => _OcasListTileState();
}

class _OcasListTileState extends State<OcasListTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: ListTile(
        leading: Icon(widget.icon ?? Icons.account_circle_rounded),
        title: Text(widget.baslik),
        trailing: Container(
          width: 100,
          child: Text(
            widget.icerik,
            maxLines: 3,
          ),
        ),
      ),
    );
  }
}

class OcasListTileHeader extends StatefulWidget {
  final String baslik;
  final List<Widget> icerik;
  final VoidCallback onPressed;
  final bool isButton;
  final IconData icon;
  final Color? buttonColor;

  const OcasListTileHeader({
    Key? key,
    required this.icerik,
    this.baslik = "kart başlığı giriniz",
    required this.onPressed,
    this.isButton = false,
    this.buttonColor,
    this.icon = Icons.add_rounded,
  }) : super(key: key);

  @override
  State<OcasListTileHeader> createState() => _OcasListTileHeaderState();
}

class _OcasListTileHeaderState extends State<OcasListTileHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: double.infinity),
      color: APPColors.Accent.grey,
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(7.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Card(
                  margin: EdgeInsets.only(top: 2, left: 1),
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 200,
                        bottom: MediaQuery.of(context).size.height / 200,
                        left: MediaQuery.of(context).size.width / 30,
                        right: MediaQuery.of(context).size.width / 30),
                    child: Text(
                      widget.baslik,
                      style: getSemiBoldTextStyle(color: Colors.white),
                    ),
                  )),
              widget.isButton
                  ? AppIconButtonSm(
                      onPressed: widget.onPressed,
                      icon: widget.icon,
                      backgroundColor:
                          widget.buttonColor ?? APPColors.Main.blue,
                    )
                  : Container()
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: widget.icerik),
        ),
      ]),
    );
  }
}

class OcasListTileWithAvatar extends StatelessWidget {
  final Color? iconColor;
  final IconData? icon;
  final String? transactionName,
      transactionType,
      transactionAmount,
      transactionIcon;
  final GestureTapCallback? onTap;
  final int? transactionAmountHeight;
  const OcasListTileWithAvatar({
    Key? key,
    this.iconColor,
    this.transactionName,
    this.transactionType,
    this.transactionAmount,
    this.transactionIcon,
    this.onTap,
    this.icon,
    this.transactionAmountHeight = 40,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        title: Text(transactionName!),
        subtitle: Stack(
          fit: StackFit.loose,
          children: [
            Text(transactionType!),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height /
                      transactionAmountHeight!),
              child: Text(
                transactionAmount!,
                style: TextStyle(fontSize: 13),
              ),
            )
          ],
        ),
        trailing: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 40,
                    right: MediaQuery.of(context).size.width / 40),
                child: Icon(icon),
              ),
            ],
          ),
        ),
        leading: CircleAvatar(
          radius: 25,
          child: Text(
            transactionIcon!,
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: iconColor,
        ),
        enabled: true,
        onTap: onTap,
      ),
    );
  }
}
