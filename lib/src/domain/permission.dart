import 'permission_identity.dart';

final class Permission {
  const Permission({
    required this.id,
    this.name,
  });

  factory Permission.fromIdentity(PermissionIdentity identity) {
    return Permission(id: identity);
  }

  final PermissionIdentity id;
  final String? name;
  String get displayName => name ?? id.defaultLabel;

  @override
  bool operator ==(Object other) =>
      other is Permission && other.id == id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Permission($id)';
}
