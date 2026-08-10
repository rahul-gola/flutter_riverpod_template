import 'package:flutter/material.dart';
import 'package:flutter_riverpod_template/core/util/app_color.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({
    required this.title,
    required this.subtitle,
    this.date,
    this.color = AppColor.green900,
    this.onTap,
    this.onAction,
    this.imageUrl,
    super.key,
  });

  final String title;
  final String subtitle;

  /// Optional remote thumbnail. Downscaled at decode time via [cacheWidth] so
  /// full-resolution images are never held in memory (common OOM source on
  /// low-end Android devices when scrolling long lists).
  final String? imageUrl;
  final DateTime? date;
  final Color color;
  final VoidCallback? onTap;
  final VoidCallback? onAction;

  String get _formattedDate {
    if (date == null) return '';
    final d = date!;
    return '${d.day}/${d.month}/${d.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 0.6,
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.all(4),
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: Row(
            children: [
              _thumb(context),
              const SizedBox(width: 12),
              Expanded(child: _body()),
              const SizedBox(width: 8),
              IconButton(
                onPressed: onAction,
                icon: const Icon(Icons.more_vert, color: Colors.black54),
                splashRadius: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _thumb(BuildContext context) {
    final radius = BorderRadius.circular(12);
    final fallback = CircleAvatar(
      radius: 26,
      backgroundColor: color.withValues(alpha: .15),
      child: Text(
        title.isNotEmpty ? title[0].toUpperCase() : '-',
        style: TextStyle(color: color, fontWeight: FontWeight.w700),
      ),
    );

    if (imageUrl == null || imageUrl!.isEmpty) return fallback;

    return ClipRRect(
      borderRadius: radius,
      child: Image.network(
        imageUrl!,
        width: 52,
        height: 52,
        fit: BoxFit.cover,
        cacheWidth: 104,
        errorBuilder: (_, _, _) => fallback,
        loadingBuilder: (_, child, progress) {
          if (progress == null) return child;
          return const SizedBox(
            width: 52,
            height: 52,
            child: Center(
              child: SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        if (subtitle.isNotEmpty)
          Text(
            subtitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 13, color: Colors.black54),
          ),
        if (_formattedDate.isNotEmpty) ...[
          const SizedBox(height: 6),
          Text(
            _formattedDate,
            style: const TextStyle(fontSize: 12, color: Colors.black38),
          ),
        ],
      ],
    );
  }
}
