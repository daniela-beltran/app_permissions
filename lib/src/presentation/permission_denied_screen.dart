part of 'permission_screen.dart';

class _PermissionDeniedScreen extends StatelessWidget {
  const _PermissionDeniedScreen({
    required this.permission,
    required this.onRetry,
    this.isPermanentlyDenied = false,
  });

  final Permission permission;
  final VoidCallback onRetry;
  final bool isPermanentlyDenied;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isPermanentlyDenied ? Icons.settings_outlined : Icons.lock_outline,
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(
              isPermanentlyDenied
                  ? 'Permission "${permission.displayName}" is blocked.\nPlease enable it in Settings.'
                  : 'Permission "${permission.displayName}" is required',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: onRetry,
              icon: Icon(isPermanentlyDenied ? Icons.open_in_new : Icons.lock_open),
              label: Text(isPermanentlyDenied ? 'Open Settings' : 'Grant Access'),
            ),
          ],
        ),
      ),
    );
  }
}
