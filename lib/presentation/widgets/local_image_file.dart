import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class LocalImageFile extends StatefulWidget {
  final String imagePath;
  final double width;
  final double height;

  const LocalImageFile({
    super.key,
    required this.imagePath,
    this.width = 100,
    this.height = 100,
  });

  @override
  State<LocalImageFile> createState() => _LocalImageFileState();
}

class _LocalImageFileState extends State<LocalImageFile> {
  bool hasPermission = false;
  bool permissionRequested = false;

  @override
  void initState() {
    super.initState();
    _checkPermission();
  }

  Future<void> _checkPermission() async {
    final status = await Permission.storage.status;

    if (status.isGranted) {
      setState(() {
        hasPermission = true;
        permissionRequested = true;
      });
    } else {
      final result = await Permission.storage.request();
      setState(() {
        hasPermission = result.isGranted;
        permissionRequested = true;
      });

      if (result.isPermanentlyDenied) {
        // Si l'utilisateur a refusé pour toujours, ouvre les paramètres
        await openAppSettings();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!permissionRequested) {
      return const Center(child: CircularProgressIndicator());
    }

    if (!hasPermission) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.lock_outline, size: 40, color: Colors.grey),
            const SizedBox(height: 8),
            const Text(
              "Permission refusée",
              style: TextStyle(color: Colors.redAccent),
            ),
            TextButton(
              onPressed: _checkPermission,
              child: const Text("Réessayer"),
            ),
          ],
        ),
      );
    }

    // ✅ Si la permission est accordée, on affiche l’image
    return Image.file(
      File(widget.imagePath),
      width: widget.width,
      height: widget.height,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return const Icon(Icons.broken_image, color: Colors.grey);
      },
    );
  }
}
