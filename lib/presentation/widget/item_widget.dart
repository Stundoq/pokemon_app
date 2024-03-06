import 'package:flutter/material.dart';

class ItemWidget extends StatelessWidget {
  final Function()? onTap;
  final Function()? favoriteButton;
  final String title;
  final String? subtitle;
  final bool? isActive;

  const ItemWidget({
    super.key,
    this.onTap,
    required this.title,
    this.subtitle,
    this.isActive,
    this.favoriteButton,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        title: Text(title),
        subtitle: Text(subtitle ?? ''),
        trailing: const Icon(Icons.arrow_forward_ios),
        leading: IconButton(
          onPressed: favoriteButton,
          icon: Icon(
            Icons.favorite,
            color: isActive ?? false ? Colors.pink : Colors.grey,
          ),
        ),
      ),
    );
  }
}
