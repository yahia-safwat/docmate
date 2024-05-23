import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return AppBar(
      toolbarHeight: 80,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Welcome',
            style: textTheme.bodyMedium,
          ),
          const SizedBox(height: 4.0),
          Text(
            'Massimo D',
            style: textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4.0),
          Row(
            children: [
              Icon(
                Icons.location_on,
                color: colorScheme.secondary,
              ),
              const SizedBox(width: 4.0),
              Text(
                'Dubai, UAE',
                style: textTheme.bodySmall!.copyWith(
                  color: colorScheme.secondary,
                ),
              ),
              const SizedBox(width: 4.0),
              Icon(
                Icons.expand_more,
                color: colorScheme.secondary,
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_outlined),
        ),
        const SizedBox(width: 8.0),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(64.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            decoration: InputDecoration(
              hintText: 'Search for doctors...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: Container(
                margin: const EdgeInsets.all(4.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: colorScheme.onSurfaceVariant,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Icon(
                  Icons.filter_alt_outlined,
                  color: colorScheme.surfaceVariant,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(144.0);
}
