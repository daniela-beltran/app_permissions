import 'permission_identity.dart';
import 'permission_status.dart';

abstract interface class PermissionHandler {
  Stream<PermissionStatus> observe(PermissionIdentity id);

  Future<PermissionStatus> request(PermissionIdentity id);

  Future<PermissionStatus> currentState(PermissionIdentity id);

  Future<void> openSettings();

  void dispose();
}
