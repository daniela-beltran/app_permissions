import 'dart:async';
import 'package:permission_handler/permission_handler.dart' as ph;
import 'permission_identity.dart';
import 'permission_handler.dart';
import 'permission_status.dart';
import 'permission_mapping_extension.dart';

class PermissionHandlerImpl implements PermissionHandler {
  final _controller = StreamController<Map<PermissionIdentity, PermissionStatus>>.broadcast();
  final Map<PermissionIdentity, PermissionStatus> _cache = {};

  @override
  Stream<PermissionStatus> observe(PermissionIdentity id) {
    return _controller.stream
        .map((map) => map[id] ?? PermissionStatus.denied)
        .distinct();
  }

  @override
  Future<PermissionStatus> request(PermissionIdentity id) async {
    try {
      final result = await id.toNative.request();
      final status = _mapToDomain(result);
      _updateCache(id, status);
      return status;
    } catch (e) {
      _updateCache(id, PermissionStatus.denied);
      rethrow;
    }
  }

  @override
  Future<PermissionStatus> currentState(PermissionIdentity id) async {
    try {
      final result = await id.toNative.status;
      final status = _mapToDomain(result);
      _updateCache(id, status);
      return status;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> openSettings() => ph.openAppSettings();

  @override
  void dispose() {
    _controller.close();
  }

  void _updateCache(PermissionIdentity id, PermissionStatus status) {
    _cache[id] = status;
    _controller.add(Map.from(_cache));
  }

  PermissionStatus _mapToDomain(ph.PermissionStatus status) {
    return switch (status) {
      ph.PermissionStatus.granted => PermissionStatus.granted,
      ph.PermissionStatus.limited => PermissionStatus.granted,
      ph.PermissionStatus.permanentlyDenied => PermissionStatus.permanentlyDenied,
      ph.PermissionStatus.restricted => PermissionStatus.permanentlyDenied,
      _ => PermissionStatus.denied,
    };
  }
}
