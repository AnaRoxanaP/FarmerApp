// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $FarmsTable extends Farms with TableInfo<$FarmsTable, Farm> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FarmsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 120),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _timezoneMeta =
      const VerificationMeta('timezone');
  @override
  late final GeneratedColumn<String> timezone = GeneratedColumn<String>(
      'timezone', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('Europe/Bucharest'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: DateTime.now);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: DateTime.now);
  static const VerificationMeta _syncStateMeta =
      const VerificationMeta('syncState');
  @override
  late final GeneratedColumn<String> syncState = GeneratedColumn<String>(
      'sync_state', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, timezone, createdAt, updatedAt, syncState];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'farms';
  @override
  VerificationContext validateIntegrity(Insertable<Farm> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('timezone')) {
      context.handle(_timezoneMeta,
          timezone.isAcceptableOrUnknown(data['timezone']!, _timezoneMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('sync_state')) {
      context.handle(_syncStateMeta,
          syncState.isAcceptableOrUnknown(data['sync_state']!, _syncStateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Farm map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Farm(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      timezone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}timezone'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      syncState: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_state'])!,
    );
  }

  @override
  $FarmsTable createAlias(String alias) {
    return $FarmsTable(attachedDatabase, alias);
  }
}

class Farm extends DataClass implements Insertable<Farm> {
  final String id;
  final String name;
  final String timezone;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String syncState;
  const Farm(
      {required this.id,
      required this.name,
      required this.timezone,
      required this.createdAt,
      required this.updatedAt,
      required this.syncState});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['timezone'] = Variable<String>(timezone);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sync_state'] = Variable<String>(syncState);
    return map;
  }

  FarmsCompanion toCompanion(bool nullToAbsent) {
    return FarmsCompanion(
      id: Value(id),
      name: Value(name),
      timezone: Value(timezone),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncState: Value(syncState),
    );
  }

  factory Farm.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Farm(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      timezone: serializer.fromJson<String>(json['timezone']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncState: serializer.fromJson<String>(json['syncState']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'timezone': serializer.toJson<String>(timezone),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncState': serializer.toJson<String>(syncState),
    };
  }

  Farm copyWith(
          {String? id,
          String? name,
          String? timezone,
          DateTime? createdAt,
          DateTime? updatedAt,
          String? syncState}) =>
      Farm(
        id: id ?? this.id,
        name: name ?? this.name,
        timezone: timezone ?? this.timezone,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        syncState: syncState ?? this.syncState,
      );
  Farm copyWithCompanion(FarmsCompanion data) {
    return Farm(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      timezone: data.timezone.present ? data.timezone.value : this.timezone,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncState: data.syncState.present ? data.syncState.value : this.syncState,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Farm(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('timezone: $timezone, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncState: $syncState')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, timezone, createdAt, updatedAt, syncState);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Farm &&
          other.id == this.id &&
          other.name == this.name &&
          other.timezone == this.timezone &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncState == this.syncState);
}

class FarmsCompanion extends UpdateCompanion<Farm> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> timezone;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> syncState;
  final Value<int> rowid;
  const FarmsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.timezone = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncState = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FarmsCompanion.insert({
    required String id,
    required String name,
    this.timezone = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncState = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name);
  static Insertable<Farm> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? timezone,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? syncState,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (timezone != null) 'timezone': timezone,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncState != null) 'sync_state': syncState,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FarmsCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? timezone,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<String>? syncState,
      Value<int>? rowid}) {
    return FarmsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      timezone: timezone ?? this.timezone,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncState: syncState ?? this.syncState,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (timezone.present) {
      map['timezone'] = Variable<String>(timezone.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncState.present) {
      map['sync_state'] = Variable<String>(syncState.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FarmsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('timezone: $timezone, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncState: $syncState, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FarmMembersTable extends FarmMembers
    with TableInfo<$FarmMembersTable, FarmMember> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FarmMembersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _farmIdMeta = const VerificationMeta('farmId');
  @override
  late final GeneratedColumn<String> farmId = GeneratedColumn<String>(
      'farm_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES farms (id)'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
      'role', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: DateTime.now);
  @override
  List<GeneratedColumn> get $columns => [id, farmId, userId, role, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'farm_members';
  @override
  VerificationContext validateIntegrity(Insertable<FarmMember> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('farm_id')) {
      context.handle(_farmIdMeta,
          farmId.isAcceptableOrUnknown(data['farm_id']!, _farmIdMeta));
    } else if (isInserting) {
      context.missing(_farmIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
          _roleMeta, role.isAcceptableOrUnknown(data['role']!, _roleMeta));
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {farmId, userId},
      ];
  @override
  FarmMember map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FarmMember(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      farmId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}farm_id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      role: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}role'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $FarmMembersTable createAlias(String alias) {
    return $FarmMembersTable(attachedDatabase, alias);
  }
}

class FarmMember extends DataClass implements Insertable<FarmMember> {
  final String id;
  final String farmId;
  final String userId;
  final String role;
  final DateTime createdAt;
  const FarmMember(
      {required this.id,
      required this.farmId,
      required this.userId,
      required this.role,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['farm_id'] = Variable<String>(farmId);
    map['user_id'] = Variable<String>(userId);
    map['role'] = Variable<String>(role);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  FarmMembersCompanion toCompanion(bool nullToAbsent) {
    return FarmMembersCompanion(
      id: Value(id),
      farmId: Value(farmId),
      userId: Value(userId),
      role: Value(role),
      createdAt: Value(createdAt),
    );
  }

  factory FarmMember.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FarmMember(
      id: serializer.fromJson<String>(json['id']),
      farmId: serializer.fromJson<String>(json['farmId']),
      userId: serializer.fromJson<String>(json['userId']),
      role: serializer.fromJson<String>(json['role']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'farmId': serializer.toJson<String>(farmId),
      'userId': serializer.toJson<String>(userId),
      'role': serializer.toJson<String>(role),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  FarmMember copyWith(
          {String? id,
          String? farmId,
          String? userId,
          String? role,
          DateTime? createdAt}) =>
      FarmMember(
        id: id ?? this.id,
        farmId: farmId ?? this.farmId,
        userId: userId ?? this.userId,
        role: role ?? this.role,
        createdAt: createdAt ?? this.createdAt,
      );
  FarmMember copyWithCompanion(FarmMembersCompanion data) {
    return FarmMember(
      id: data.id.present ? data.id.value : this.id,
      farmId: data.farmId.present ? data.farmId.value : this.farmId,
      userId: data.userId.present ? data.userId.value : this.userId,
      role: data.role.present ? data.role.value : this.role,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FarmMember(')
          ..write('id: $id, ')
          ..write('farmId: $farmId, ')
          ..write('userId: $userId, ')
          ..write('role: $role, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, farmId, userId, role, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FarmMember &&
          other.id == this.id &&
          other.farmId == this.farmId &&
          other.userId == this.userId &&
          other.role == this.role &&
          other.createdAt == this.createdAt);
}

class FarmMembersCompanion extends UpdateCompanion<FarmMember> {
  final Value<String> id;
  final Value<String> farmId;
  final Value<String> userId;
  final Value<String> role;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const FarmMembersCompanion({
    this.id = const Value.absent(),
    this.farmId = const Value.absent(),
    this.userId = const Value.absent(),
    this.role = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FarmMembersCompanion.insert({
    required String id,
    required String farmId,
    required String userId,
    required String role,
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        farmId = Value(farmId),
        userId = Value(userId),
        role = Value(role);
  static Insertable<FarmMember> custom({
    Expression<String>? id,
    Expression<String>? farmId,
    Expression<String>? userId,
    Expression<String>? role,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (farmId != null) 'farm_id': farmId,
      if (userId != null) 'user_id': userId,
      if (role != null) 'role': role,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FarmMembersCompanion copyWith(
      {Value<String>? id,
      Value<String>? farmId,
      Value<String>? userId,
      Value<String>? role,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return FarmMembersCompanion(
      id: id ?? this.id,
      farmId: farmId ?? this.farmId,
      userId: userId ?? this.userId,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (farmId.present) {
      map['farm_id'] = Variable<String>(farmId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FarmMembersCompanion(')
          ..write('id: $id, ')
          ..write('farmId: $farmId, ')
          ..write('userId: $userId, ')
          ..write('role: $role, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AnimalsTable extends Animals with TableInfo<$AnimalsTable, Animal> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AnimalsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _farmIdMeta = const VerificationMeta('farmId');
  @override
  late final GeneratedColumn<String> farmId = GeneratedColumn<String>(
      'farm_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES farms (id)'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 120),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _internalNumberMeta =
      const VerificationMeta('internalNumber');
  @override
  late final GeneratedColumn<String> internalNumber = GeneratedColumn<String>(
      'internal_number', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sexMeta = const VerificationMeta('sex');
  @override
  late final GeneratedColumn<String> sex = GeneratedColumn<String>(
      'sex', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _breedMeta = const VerificationMeta('breed');
  @override
  late final GeneratedColumn<String> breed = GeneratedColumn<String>(
      'breed', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 80),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _earTagMeta = const VerificationMeta('earTag');
  @override
  late final GeneratedColumn<String> earTag = GeneratedColumn<String>(
      'ear_tag', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _markMeta = const VerificationMeta('mark');
  @override
  late final GeneratedColumn<String> mark = GeneratedColumn<String>(
      'mark', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _earMarksMeta =
      const VerificationMeta('earMarks');
  @override
  late final GeneratedColumn<String> earMarks = GeneratedColumn<String>(
      'ear_marks', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _birthDateMeta =
      const VerificationMeta('birthDate');
  @override
  late final GeneratedColumn<DateTime> birthDate = GeneratedColumn<DateTime>(
      'birth_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _damIdMeta = const VerificationMeta('damId');
  @override
  late final GeneratedColumn<String> damId = GeneratedColumn<String>(
      'dam_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES animals (id)'));
  static const VerificationMeta _sireIdMeta = const VerificationMeta('sireId');
  @override
  late final GeneratedColumn<String> sireId = GeneratedColumn<String>(
      'sire_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES animals (id)'));
  static const VerificationMeta _originMeta = const VerificationMeta('origin');
  @override
  late final GeneratedColumn<String> origin = GeneratedColumn<String>(
      'origin', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('born'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: DateTime.now);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: DateTime.now);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('active'));
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _syncStateMeta =
      const VerificationMeta('syncState');
  @override
  late final GeneratedColumn<String> syncState = GeneratedColumn<String>(
      'sync_state', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _createdByMeta =
      const VerificationMeta('createdBy');
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
      'created_by', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _updatedByMeta =
      const VerificationMeta('updatedBy');
  @override
  late final GeneratedColumn<String> updatedBy = GeneratedColumn<String>(
      'updated_by', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        farmId,
        name,
        internalNumber,
        sex,
        breed,
        earTag,
        mark,
        earMarks,
        birthDate,
        damId,
        sireId,
        origin,
        createdAt,
        updatedAt,
        status,
        deletedAt,
        syncState,
        createdBy,
        updatedBy
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'animals';
  @override
  VerificationContext validateIntegrity(Insertable<Animal> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('farm_id')) {
      context.handle(_farmIdMeta,
          farmId.isAcceptableOrUnknown(data['farm_id']!, _farmIdMeta));
    } else if (isInserting) {
      context.missing(_farmIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('internal_number')) {
      context.handle(
          _internalNumberMeta,
          internalNumber.isAcceptableOrUnknown(
              data['internal_number']!, _internalNumberMeta));
    }
    if (data.containsKey('sex')) {
      context.handle(
          _sexMeta, sex.isAcceptableOrUnknown(data['sex']!, _sexMeta));
    } else if (isInserting) {
      context.missing(_sexMeta);
    }
    if (data.containsKey('breed')) {
      context.handle(
          _breedMeta, breed.isAcceptableOrUnknown(data['breed']!, _breedMeta));
    } else if (isInserting) {
      context.missing(_breedMeta);
    }
    if (data.containsKey('ear_tag')) {
      context.handle(_earTagMeta,
          earTag.isAcceptableOrUnknown(data['ear_tag']!, _earTagMeta));
    } else if (isInserting) {
      context.missing(_earTagMeta);
    }
    if (data.containsKey('mark')) {
      context.handle(
          _markMeta, mark.isAcceptableOrUnknown(data['mark']!, _markMeta));
    }
    if (data.containsKey('ear_marks')) {
      context.handle(_earMarksMeta,
          earMarks.isAcceptableOrUnknown(data['ear_marks']!, _earMarksMeta));
    }
    if (data.containsKey('birth_date')) {
      context.handle(_birthDateMeta,
          birthDate.isAcceptableOrUnknown(data['birth_date']!, _birthDateMeta));
    }
    if (data.containsKey('dam_id')) {
      context.handle(
          _damIdMeta, damId.isAcceptableOrUnknown(data['dam_id']!, _damIdMeta));
    }
    if (data.containsKey('sire_id')) {
      context.handle(_sireIdMeta,
          sireId.isAcceptableOrUnknown(data['sire_id']!, _sireIdMeta));
    }
    if (data.containsKey('origin')) {
      context.handle(_originMeta,
          origin.isAcceptableOrUnknown(data['origin']!, _originMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    if (data.containsKey('sync_state')) {
      context.handle(_syncStateMeta,
          syncState.isAcceptableOrUnknown(data['sync_state']!, _syncStateMeta));
    }
    if (data.containsKey('created_by')) {
      context.handle(_createdByMeta,
          createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta));
    }
    if (data.containsKey('updated_by')) {
      context.handle(_updatedByMeta,
          updatedBy.isAcceptableOrUnknown(data['updated_by']!, _updatedByMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {farmId, internalNumber},
        {farmId, earTag},
      ];
  @override
  Animal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Animal(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      farmId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}farm_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      internalNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}internal_number']),
      sex: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sex'])!,
      breed: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}breed'])!,
      earTag: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}ear_tag'])!,
      mark: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}mark'])!,
      earMarks: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}ear_marks']),
      birthDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}birth_date']),
      damId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}dam_id']),
      sireId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sire_id']),
      origin: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}origin'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
      syncState: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_state'])!,
      createdBy: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_by']),
      updatedBy: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}updated_by']),
    );
  }

  @override
  $AnimalsTable createAlias(String alias) {
    return $AnimalsTable(attachedDatabase, alias);
  }
}

class Animal extends DataClass implements Insertable<Animal> {
  final String id;
  final String farmId;
  final String name;
  final String? internalNumber;
  final String sex;
  final String breed;
  final String earTag;
  final String mark;
  final String? earMarks;
  final DateTime? birthDate;
  final String? damId;
  final String? sireId;
  final String origin;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String status;
  final DateTime? deletedAt;
  final String syncState;
  final String? createdBy;
  final String? updatedBy;
  const Animal(
      {required this.id,
      required this.farmId,
      required this.name,
      this.internalNumber,
      required this.sex,
      required this.breed,
      required this.earTag,
      required this.mark,
      this.earMarks,
      this.birthDate,
      this.damId,
      this.sireId,
      required this.origin,
      required this.createdAt,
      required this.updatedAt,
      required this.status,
      this.deletedAt,
      required this.syncState,
      this.createdBy,
      this.updatedBy});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['farm_id'] = Variable<String>(farmId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || internalNumber != null) {
      map['internal_number'] = Variable<String>(internalNumber);
    }
    map['sex'] = Variable<String>(sex);
    map['breed'] = Variable<String>(breed);
    map['ear_tag'] = Variable<String>(earTag);
    map['mark'] = Variable<String>(mark);
    if (!nullToAbsent || earMarks != null) {
      map['ear_marks'] = Variable<String>(earMarks);
    }
    if (!nullToAbsent || birthDate != null) {
      map['birth_date'] = Variable<DateTime>(birthDate);
    }
    if (!nullToAbsent || damId != null) {
      map['dam_id'] = Variable<String>(damId);
    }
    if (!nullToAbsent || sireId != null) {
      map['sire_id'] = Variable<String>(sireId);
    }
    map['origin'] = Variable<String>(origin);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['sync_state'] = Variable<String>(syncState);
    if (!nullToAbsent || createdBy != null) {
      map['created_by'] = Variable<String>(createdBy);
    }
    if (!nullToAbsent || updatedBy != null) {
      map['updated_by'] = Variable<String>(updatedBy);
    }
    return map;
  }

  AnimalsCompanion toCompanion(bool nullToAbsent) {
    return AnimalsCompanion(
      id: Value(id),
      farmId: Value(farmId),
      name: Value(name),
      internalNumber: internalNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(internalNumber),
      sex: Value(sex),
      breed: Value(breed),
      earTag: Value(earTag),
      mark: Value(mark),
      earMarks: earMarks == null && nullToAbsent
          ? const Value.absent()
          : Value(earMarks),
      birthDate: birthDate == null && nullToAbsent
          ? const Value.absent()
          : Value(birthDate),
      damId:
          damId == null && nullToAbsent ? const Value.absent() : Value(damId),
      sireId:
          sireId == null && nullToAbsent ? const Value.absent() : Value(sireId),
      origin: Value(origin),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      status: Value(status),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      syncState: Value(syncState),
      createdBy: createdBy == null && nullToAbsent
          ? const Value.absent()
          : Value(createdBy),
      updatedBy: updatedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedBy),
    );
  }

  factory Animal.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Animal(
      id: serializer.fromJson<String>(json['id']),
      farmId: serializer.fromJson<String>(json['farmId']),
      name: serializer.fromJson<String>(json['name']),
      internalNumber: serializer.fromJson<String?>(json['internalNumber']),
      sex: serializer.fromJson<String>(json['sex']),
      breed: serializer.fromJson<String>(json['breed']),
      earTag: serializer.fromJson<String>(json['earTag']),
      mark: serializer.fromJson<String>(json['mark']),
      earMarks: serializer.fromJson<String?>(json['earMarks']),
      birthDate: serializer.fromJson<DateTime?>(json['birthDate']),
      damId: serializer.fromJson<String?>(json['damId']),
      sireId: serializer.fromJson<String?>(json['sireId']),
      origin: serializer.fromJson<String>(json['origin']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      status: serializer.fromJson<String>(json['status']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      syncState: serializer.fromJson<String>(json['syncState']),
      createdBy: serializer.fromJson<String?>(json['createdBy']),
      updatedBy: serializer.fromJson<String?>(json['updatedBy']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'farmId': serializer.toJson<String>(farmId),
      'name': serializer.toJson<String>(name),
      'internalNumber': serializer.toJson<String?>(internalNumber),
      'sex': serializer.toJson<String>(sex),
      'breed': serializer.toJson<String>(breed),
      'earTag': serializer.toJson<String>(earTag),
      'mark': serializer.toJson<String>(mark),
      'earMarks': serializer.toJson<String?>(earMarks),
      'birthDate': serializer.toJson<DateTime?>(birthDate),
      'damId': serializer.toJson<String?>(damId),
      'sireId': serializer.toJson<String?>(sireId),
      'origin': serializer.toJson<String>(origin),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'status': serializer.toJson<String>(status),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'syncState': serializer.toJson<String>(syncState),
      'createdBy': serializer.toJson<String?>(createdBy),
      'updatedBy': serializer.toJson<String?>(updatedBy),
    };
  }

  Animal copyWith(
          {String? id,
          String? farmId,
          String? name,
          Value<String?> internalNumber = const Value.absent(),
          String? sex,
          String? breed,
          String? earTag,
          String? mark,
          Value<String?> earMarks = const Value.absent(),
          Value<DateTime?> birthDate = const Value.absent(),
          Value<String?> damId = const Value.absent(),
          Value<String?> sireId = const Value.absent(),
          String? origin,
          DateTime? createdAt,
          DateTime? updatedAt,
          String? status,
          Value<DateTime?> deletedAt = const Value.absent(),
          String? syncState,
          Value<String?> createdBy = const Value.absent(),
          Value<String?> updatedBy = const Value.absent()}) =>
      Animal(
        id: id ?? this.id,
        farmId: farmId ?? this.farmId,
        name: name ?? this.name,
        internalNumber:
            internalNumber.present ? internalNumber.value : this.internalNumber,
        sex: sex ?? this.sex,
        breed: breed ?? this.breed,
        earTag: earTag ?? this.earTag,
        mark: mark ?? this.mark,
        earMarks: earMarks.present ? earMarks.value : this.earMarks,
        birthDate: birthDate.present ? birthDate.value : this.birthDate,
        damId: damId.present ? damId.value : this.damId,
        sireId: sireId.present ? sireId.value : this.sireId,
        origin: origin ?? this.origin,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        status: status ?? this.status,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
        syncState: syncState ?? this.syncState,
        createdBy: createdBy.present ? createdBy.value : this.createdBy,
        updatedBy: updatedBy.present ? updatedBy.value : this.updatedBy,
      );
  Animal copyWithCompanion(AnimalsCompanion data) {
    return Animal(
      id: data.id.present ? data.id.value : this.id,
      farmId: data.farmId.present ? data.farmId.value : this.farmId,
      name: data.name.present ? data.name.value : this.name,
      internalNumber: data.internalNumber.present
          ? data.internalNumber.value
          : this.internalNumber,
      sex: data.sex.present ? data.sex.value : this.sex,
      breed: data.breed.present ? data.breed.value : this.breed,
      earTag: data.earTag.present ? data.earTag.value : this.earTag,
      mark: data.mark.present ? data.mark.value : this.mark,
      earMarks: data.earMarks.present ? data.earMarks.value : this.earMarks,
      birthDate: data.birthDate.present ? data.birthDate.value : this.birthDate,
      damId: data.damId.present ? data.damId.value : this.damId,
      sireId: data.sireId.present ? data.sireId.value : this.sireId,
      origin: data.origin.present ? data.origin.value : this.origin,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      status: data.status.present ? data.status.value : this.status,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      syncState: data.syncState.present ? data.syncState.value : this.syncState,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      updatedBy: data.updatedBy.present ? data.updatedBy.value : this.updatedBy,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Animal(')
          ..write('id: $id, ')
          ..write('farmId: $farmId, ')
          ..write('name: $name, ')
          ..write('internalNumber: $internalNumber, ')
          ..write('sex: $sex, ')
          ..write('breed: $breed, ')
          ..write('earTag: $earTag, ')
          ..write('mark: $mark, ')
          ..write('earMarks: $earMarks, ')
          ..write('birthDate: $birthDate, ')
          ..write('damId: $damId, ')
          ..write('sireId: $sireId, ')
          ..write('origin: $origin, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('status: $status, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncState: $syncState, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedBy: $updatedBy')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      farmId,
      name,
      internalNumber,
      sex,
      breed,
      earTag,
      mark,
      earMarks,
      birthDate,
      damId,
      sireId,
      origin,
      createdAt,
      updatedAt,
      status,
      deletedAt,
      syncState,
      createdBy,
      updatedBy);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Animal &&
          other.id == this.id &&
          other.farmId == this.farmId &&
          other.name == this.name &&
          other.internalNumber == this.internalNumber &&
          other.sex == this.sex &&
          other.breed == this.breed &&
          other.earTag == this.earTag &&
          other.mark == this.mark &&
          other.earMarks == this.earMarks &&
          other.birthDate == this.birthDate &&
          other.damId == this.damId &&
          other.sireId == this.sireId &&
          other.origin == this.origin &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.status == this.status &&
          other.deletedAt == this.deletedAt &&
          other.syncState == this.syncState &&
          other.createdBy == this.createdBy &&
          other.updatedBy == this.updatedBy);
}

class AnimalsCompanion extends UpdateCompanion<Animal> {
  final Value<String> id;
  final Value<String> farmId;
  final Value<String> name;
  final Value<String?> internalNumber;
  final Value<String> sex;
  final Value<String> breed;
  final Value<String> earTag;
  final Value<String> mark;
  final Value<String?> earMarks;
  final Value<DateTime?> birthDate;
  final Value<String?> damId;
  final Value<String?> sireId;
  final Value<String> origin;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> status;
  final Value<DateTime?> deletedAt;
  final Value<String> syncState;
  final Value<String?> createdBy;
  final Value<String?> updatedBy;
  final Value<int> rowid;
  const AnimalsCompanion({
    this.id = const Value.absent(),
    this.farmId = const Value.absent(),
    this.name = const Value.absent(),
    this.internalNumber = const Value.absent(),
    this.sex = const Value.absent(),
    this.breed = const Value.absent(),
    this.earTag = const Value.absent(),
    this.mark = const Value.absent(),
    this.earMarks = const Value.absent(),
    this.birthDate = const Value.absent(),
    this.damId = const Value.absent(),
    this.sireId = const Value.absent(),
    this.origin = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.status = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.syncState = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AnimalsCompanion.insert({
    required String id,
    required String farmId,
    required String name,
    this.internalNumber = const Value.absent(),
    required String sex,
    required String breed,
    required String earTag,
    this.mark = const Value.absent(),
    this.earMarks = const Value.absent(),
    this.birthDate = const Value.absent(),
    this.damId = const Value.absent(),
    this.sireId = const Value.absent(),
    this.origin = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.status = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.syncState = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        farmId = Value(farmId),
        name = Value(name),
        sex = Value(sex),
        breed = Value(breed),
        earTag = Value(earTag);
  static Insertable<Animal> custom({
    Expression<String>? id,
    Expression<String>? farmId,
    Expression<String>? name,
    Expression<String>? internalNumber,
    Expression<String>? sex,
    Expression<String>? breed,
    Expression<String>? earTag,
    Expression<String>? mark,
    Expression<String>? earMarks,
    Expression<DateTime>? birthDate,
    Expression<String>? damId,
    Expression<String>? sireId,
    Expression<String>? origin,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? status,
    Expression<DateTime>? deletedAt,
    Expression<String>? syncState,
    Expression<String>? createdBy,
    Expression<String>? updatedBy,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (farmId != null) 'farm_id': farmId,
      if (name != null) 'name': name,
      if (internalNumber != null) 'internal_number': internalNumber,
      if (sex != null) 'sex': sex,
      if (breed != null) 'breed': breed,
      if (earTag != null) 'ear_tag': earTag,
      if (mark != null) 'mark': mark,
      if (earMarks != null) 'ear_marks': earMarks,
      if (birthDate != null) 'birth_date': birthDate,
      if (damId != null) 'dam_id': damId,
      if (sireId != null) 'sire_id': sireId,
      if (origin != null) 'origin': origin,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (status != null) 'status': status,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (syncState != null) 'sync_state': syncState,
      if (createdBy != null) 'created_by': createdBy,
      if (updatedBy != null) 'updated_by': updatedBy,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AnimalsCompanion copyWith(
      {Value<String>? id,
      Value<String>? farmId,
      Value<String>? name,
      Value<String?>? internalNumber,
      Value<String>? sex,
      Value<String>? breed,
      Value<String>? earTag,
      Value<String>? mark,
      Value<String?>? earMarks,
      Value<DateTime?>? birthDate,
      Value<String?>? damId,
      Value<String?>? sireId,
      Value<String>? origin,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<String>? status,
      Value<DateTime?>? deletedAt,
      Value<String>? syncState,
      Value<String?>? createdBy,
      Value<String?>? updatedBy,
      Value<int>? rowid}) {
    return AnimalsCompanion(
      id: id ?? this.id,
      farmId: farmId ?? this.farmId,
      name: name ?? this.name,
      internalNumber: internalNumber ?? this.internalNumber,
      sex: sex ?? this.sex,
      breed: breed ?? this.breed,
      earTag: earTag ?? this.earTag,
      mark: mark ?? this.mark,
      earMarks: earMarks ?? this.earMarks,
      birthDate: birthDate ?? this.birthDate,
      damId: damId ?? this.damId,
      sireId: sireId ?? this.sireId,
      origin: origin ?? this.origin,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      status: status ?? this.status,
      deletedAt: deletedAt ?? this.deletedAt,
      syncState: syncState ?? this.syncState,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (farmId.present) {
      map['farm_id'] = Variable<String>(farmId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (internalNumber.present) {
      map['internal_number'] = Variable<String>(internalNumber.value);
    }
    if (sex.present) {
      map['sex'] = Variable<String>(sex.value);
    }
    if (breed.present) {
      map['breed'] = Variable<String>(breed.value);
    }
    if (earTag.present) {
      map['ear_tag'] = Variable<String>(earTag.value);
    }
    if (mark.present) {
      map['mark'] = Variable<String>(mark.value);
    }
    if (earMarks.present) {
      map['ear_marks'] = Variable<String>(earMarks.value);
    }
    if (birthDate.present) {
      map['birth_date'] = Variable<DateTime>(birthDate.value);
    }
    if (damId.present) {
      map['dam_id'] = Variable<String>(damId.value);
    }
    if (sireId.present) {
      map['sire_id'] = Variable<String>(sireId.value);
    }
    if (origin.present) {
      map['origin'] = Variable<String>(origin.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (syncState.present) {
      map['sync_state'] = Variable<String>(syncState.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (updatedBy.present) {
      map['updated_by'] = Variable<String>(updatedBy.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AnimalsCompanion(')
          ..write('id: $id, ')
          ..write('farmId: $farmId, ')
          ..write('name: $name, ')
          ..write('internalNumber: $internalNumber, ')
          ..write('sex: $sex, ')
          ..write('breed: $breed, ')
          ..write('earTag: $earTag, ')
          ..write('mark: $mark, ')
          ..write('earMarks: $earMarks, ')
          ..write('birthDate: $birthDate, ')
          ..write('damId: $damId, ')
          ..write('sireId: $sireId, ')
          ..write('origin: $origin, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('status: $status, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncState: $syncState, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LambingsTable extends Lambings with TableInfo<$LambingsTable, Lambing> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LambingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _farmIdMeta = const VerificationMeta('farmId');
  @override
  late final GeneratedColumn<String> farmId = GeneratedColumn<String>(
      'farm_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES farms (id)'));
  static const VerificationMeta _damIdMeta = const VerificationMeta('damId');
  @override
  late final GeneratedColumn<String> damId = GeneratedColumn<String>(
      'dam_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES animals (id)'));
  static const VerificationMeta _sireIdMeta = const VerificationMeta('sireId');
  @override
  late final GeneratedColumn<String> sireId = GeneratedColumn<String>(
      'sire_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES animals (id)'));
  static const VerificationMeta _occurredAtMeta =
      const VerificationMeta('occurredAt');
  @override
  late final GeneratedColumn<DateTime> occurredAt = GeneratedColumn<DateTime>(
      'occurred_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _birthTypeMeta =
      const VerificationMeta('birthType');
  @override
  late final GeneratedColumn<String> birthType = GeneratedColumn<String>(
      'birth_type', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('unknown'));
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: DateTime.now);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: DateTime.now);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _syncStateMeta =
      const VerificationMeta('syncState');
  @override
  late final GeneratedColumn<String> syncState = GeneratedColumn<String>(
      'sync_state', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _createdByMeta =
      const VerificationMeta('createdBy');
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
      'created_by', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _updatedByMeta =
      const VerificationMeta('updatedBy');
  @override
  late final GeneratedColumn<String> updatedBy = GeneratedColumn<String>(
      'updated_by', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        farmId,
        damId,
        sireId,
        occurredAt,
        birthType,
        notes,
        createdAt,
        updatedAt,
        deletedAt,
        syncState,
        createdBy,
        updatedBy
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'lambings';
  @override
  VerificationContext validateIntegrity(Insertable<Lambing> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('farm_id')) {
      context.handle(_farmIdMeta,
          farmId.isAcceptableOrUnknown(data['farm_id']!, _farmIdMeta));
    } else if (isInserting) {
      context.missing(_farmIdMeta);
    }
    if (data.containsKey('dam_id')) {
      context.handle(
          _damIdMeta, damId.isAcceptableOrUnknown(data['dam_id']!, _damIdMeta));
    } else if (isInserting) {
      context.missing(_damIdMeta);
    }
    if (data.containsKey('sire_id')) {
      context.handle(_sireIdMeta,
          sireId.isAcceptableOrUnknown(data['sire_id']!, _sireIdMeta));
    }
    if (data.containsKey('occurred_at')) {
      context.handle(
          _occurredAtMeta,
          occurredAt.isAcceptableOrUnknown(
              data['occurred_at']!, _occurredAtMeta));
    } else if (isInserting) {
      context.missing(_occurredAtMeta);
    }
    if (data.containsKey('birth_type')) {
      context.handle(_birthTypeMeta,
          birthType.isAcceptableOrUnknown(data['birth_type']!, _birthTypeMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    if (data.containsKey('sync_state')) {
      context.handle(_syncStateMeta,
          syncState.isAcceptableOrUnknown(data['sync_state']!, _syncStateMeta));
    }
    if (data.containsKey('created_by')) {
      context.handle(_createdByMeta,
          createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta));
    }
    if (data.containsKey('updated_by')) {
      context.handle(_updatedByMeta,
          updatedBy.isAcceptableOrUnknown(data['updated_by']!, _updatedByMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Lambing map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Lambing(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      farmId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}farm_id'])!,
      damId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}dam_id'])!,
      sireId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sire_id']),
      occurredAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}occurred_at'])!,
      birthType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}birth_type'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
      syncState: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_state'])!,
      createdBy: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_by']),
      updatedBy: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}updated_by']),
    );
  }

  @override
  $LambingsTable createAlias(String alias) {
    return $LambingsTable(attachedDatabase, alias);
  }
}

class Lambing extends DataClass implements Insertable<Lambing> {
  final String id;
  final String farmId;
  final String damId;
  final String? sireId;
  final DateTime occurredAt;
  final String birthType;
  final String notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String syncState;
  final String? createdBy;
  final String? updatedBy;
  const Lambing(
      {required this.id,
      required this.farmId,
      required this.damId,
      this.sireId,
      required this.occurredAt,
      required this.birthType,
      required this.notes,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt,
      required this.syncState,
      this.createdBy,
      this.updatedBy});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['farm_id'] = Variable<String>(farmId);
    map['dam_id'] = Variable<String>(damId);
    if (!nullToAbsent || sireId != null) {
      map['sire_id'] = Variable<String>(sireId);
    }
    map['occurred_at'] = Variable<DateTime>(occurredAt);
    map['birth_type'] = Variable<String>(birthType);
    map['notes'] = Variable<String>(notes);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['sync_state'] = Variable<String>(syncState);
    if (!nullToAbsent || createdBy != null) {
      map['created_by'] = Variable<String>(createdBy);
    }
    if (!nullToAbsent || updatedBy != null) {
      map['updated_by'] = Variable<String>(updatedBy);
    }
    return map;
  }

  LambingsCompanion toCompanion(bool nullToAbsent) {
    return LambingsCompanion(
      id: Value(id),
      farmId: Value(farmId),
      damId: Value(damId),
      sireId:
          sireId == null && nullToAbsent ? const Value.absent() : Value(sireId),
      occurredAt: Value(occurredAt),
      birthType: Value(birthType),
      notes: Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      syncState: Value(syncState),
      createdBy: createdBy == null && nullToAbsent
          ? const Value.absent()
          : Value(createdBy),
      updatedBy: updatedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedBy),
    );
  }

  factory Lambing.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Lambing(
      id: serializer.fromJson<String>(json['id']),
      farmId: serializer.fromJson<String>(json['farmId']),
      damId: serializer.fromJson<String>(json['damId']),
      sireId: serializer.fromJson<String?>(json['sireId']),
      occurredAt: serializer.fromJson<DateTime>(json['occurredAt']),
      birthType: serializer.fromJson<String>(json['birthType']),
      notes: serializer.fromJson<String>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      syncState: serializer.fromJson<String>(json['syncState']),
      createdBy: serializer.fromJson<String?>(json['createdBy']),
      updatedBy: serializer.fromJson<String?>(json['updatedBy']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'farmId': serializer.toJson<String>(farmId),
      'damId': serializer.toJson<String>(damId),
      'sireId': serializer.toJson<String?>(sireId),
      'occurredAt': serializer.toJson<DateTime>(occurredAt),
      'birthType': serializer.toJson<String>(birthType),
      'notes': serializer.toJson<String>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'syncState': serializer.toJson<String>(syncState),
      'createdBy': serializer.toJson<String?>(createdBy),
      'updatedBy': serializer.toJson<String?>(updatedBy),
    };
  }

  Lambing copyWith(
          {String? id,
          String? farmId,
          String? damId,
          Value<String?> sireId = const Value.absent(),
          DateTime? occurredAt,
          String? birthType,
          String? notes,
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<DateTime?> deletedAt = const Value.absent(),
          String? syncState,
          Value<String?> createdBy = const Value.absent(),
          Value<String?> updatedBy = const Value.absent()}) =>
      Lambing(
        id: id ?? this.id,
        farmId: farmId ?? this.farmId,
        damId: damId ?? this.damId,
        sireId: sireId.present ? sireId.value : this.sireId,
        occurredAt: occurredAt ?? this.occurredAt,
        birthType: birthType ?? this.birthType,
        notes: notes ?? this.notes,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
        syncState: syncState ?? this.syncState,
        createdBy: createdBy.present ? createdBy.value : this.createdBy,
        updatedBy: updatedBy.present ? updatedBy.value : this.updatedBy,
      );
  Lambing copyWithCompanion(LambingsCompanion data) {
    return Lambing(
      id: data.id.present ? data.id.value : this.id,
      farmId: data.farmId.present ? data.farmId.value : this.farmId,
      damId: data.damId.present ? data.damId.value : this.damId,
      sireId: data.sireId.present ? data.sireId.value : this.sireId,
      occurredAt:
          data.occurredAt.present ? data.occurredAt.value : this.occurredAt,
      birthType: data.birthType.present ? data.birthType.value : this.birthType,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      syncState: data.syncState.present ? data.syncState.value : this.syncState,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      updatedBy: data.updatedBy.present ? data.updatedBy.value : this.updatedBy,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Lambing(')
          ..write('id: $id, ')
          ..write('farmId: $farmId, ')
          ..write('damId: $damId, ')
          ..write('sireId: $sireId, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('birthType: $birthType, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncState: $syncState, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedBy: $updatedBy')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      farmId,
      damId,
      sireId,
      occurredAt,
      birthType,
      notes,
      createdAt,
      updatedAt,
      deletedAt,
      syncState,
      createdBy,
      updatedBy);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Lambing &&
          other.id == this.id &&
          other.farmId == this.farmId &&
          other.damId == this.damId &&
          other.sireId == this.sireId &&
          other.occurredAt == this.occurredAt &&
          other.birthType == this.birthType &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.syncState == this.syncState &&
          other.createdBy == this.createdBy &&
          other.updatedBy == this.updatedBy);
}

class LambingsCompanion extends UpdateCompanion<Lambing> {
  final Value<String> id;
  final Value<String> farmId;
  final Value<String> damId;
  final Value<String?> sireId;
  final Value<DateTime> occurredAt;
  final Value<String> birthType;
  final Value<String> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> syncState;
  final Value<String?> createdBy;
  final Value<String?> updatedBy;
  final Value<int> rowid;
  const LambingsCompanion({
    this.id = const Value.absent(),
    this.farmId = const Value.absent(),
    this.damId = const Value.absent(),
    this.sireId = const Value.absent(),
    this.occurredAt = const Value.absent(),
    this.birthType = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.syncState = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LambingsCompanion.insert({
    required String id,
    required String farmId,
    required String damId,
    this.sireId = const Value.absent(),
    required DateTime occurredAt,
    this.birthType = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.syncState = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        farmId = Value(farmId),
        damId = Value(damId),
        occurredAt = Value(occurredAt);
  static Insertable<Lambing> custom({
    Expression<String>? id,
    Expression<String>? farmId,
    Expression<String>? damId,
    Expression<String>? sireId,
    Expression<DateTime>? occurredAt,
    Expression<String>? birthType,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? syncState,
    Expression<String>? createdBy,
    Expression<String>? updatedBy,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (farmId != null) 'farm_id': farmId,
      if (damId != null) 'dam_id': damId,
      if (sireId != null) 'sire_id': sireId,
      if (occurredAt != null) 'occurred_at': occurredAt,
      if (birthType != null) 'birth_type': birthType,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (syncState != null) 'sync_state': syncState,
      if (createdBy != null) 'created_by': createdBy,
      if (updatedBy != null) 'updated_by': updatedBy,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LambingsCompanion copyWith(
      {Value<String>? id,
      Value<String>? farmId,
      Value<String>? damId,
      Value<String?>? sireId,
      Value<DateTime>? occurredAt,
      Value<String>? birthType,
      Value<String>? notes,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<DateTime?>? deletedAt,
      Value<String>? syncState,
      Value<String?>? createdBy,
      Value<String?>? updatedBy,
      Value<int>? rowid}) {
    return LambingsCompanion(
      id: id ?? this.id,
      farmId: farmId ?? this.farmId,
      damId: damId ?? this.damId,
      sireId: sireId ?? this.sireId,
      occurredAt: occurredAt ?? this.occurredAt,
      birthType: birthType ?? this.birthType,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      syncState: syncState ?? this.syncState,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (farmId.present) {
      map['farm_id'] = Variable<String>(farmId.value);
    }
    if (damId.present) {
      map['dam_id'] = Variable<String>(damId.value);
    }
    if (sireId.present) {
      map['sire_id'] = Variable<String>(sireId.value);
    }
    if (occurredAt.present) {
      map['occurred_at'] = Variable<DateTime>(occurredAt.value);
    }
    if (birthType.present) {
      map['birth_type'] = Variable<String>(birthType.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (syncState.present) {
      map['sync_state'] = Variable<String>(syncState.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (updatedBy.present) {
      map['updated_by'] = Variable<String>(updatedBy.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LambingsCompanion(')
          ..write('id: $id, ')
          ..write('farmId: $farmId, ')
          ..write('damId: $damId, ')
          ..write('sireId: $sireId, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('birthType: $birthType, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncState: $syncState, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LambingLambsTable extends LambingLambs
    with TableInfo<$LambingLambsTable, LambingLamb> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LambingLambsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _farmIdMeta = const VerificationMeta('farmId');
  @override
  late final GeneratedColumn<String> farmId = GeneratedColumn<String>(
      'farm_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES farms (id)'));
  static const VerificationMeta _lambingIdMeta =
      const VerificationMeta('lambingId');
  @override
  late final GeneratedColumn<String> lambingId = GeneratedColumn<String>(
      'lambing_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES lambings (id)'));
  static const VerificationMeta _animalIdMeta =
      const VerificationMeta('animalId');
  @override
  late final GeneratedColumn<String> animalId = GeneratedColumn<String>(
      'animal_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES animals (id)'));
  static const VerificationMeta _birthWeightKgMeta =
      const VerificationMeta('birthWeightKg');
  @override
  late final GeneratedColumn<double> birthWeightKg = GeneratedColumn<double>(
      'birth_weight_kg', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: DateTime.now);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: DateTime.now);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _syncStateMeta =
      const VerificationMeta('syncState');
  @override
  late final GeneratedColumn<String> syncState = GeneratedColumn<String>(
      'sync_state', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        farmId,
        lambingId,
        animalId,
        birthWeightKg,
        notes,
        createdAt,
        updatedAt,
        deletedAt,
        syncState
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'lambing_lambs';
  @override
  VerificationContext validateIntegrity(Insertable<LambingLamb> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('farm_id')) {
      context.handle(_farmIdMeta,
          farmId.isAcceptableOrUnknown(data['farm_id']!, _farmIdMeta));
    } else if (isInserting) {
      context.missing(_farmIdMeta);
    }
    if (data.containsKey('lambing_id')) {
      context.handle(_lambingIdMeta,
          lambingId.isAcceptableOrUnknown(data['lambing_id']!, _lambingIdMeta));
    } else if (isInserting) {
      context.missing(_lambingIdMeta);
    }
    if (data.containsKey('animal_id')) {
      context.handle(_animalIdMeta,
          animalId.isAcceptableOrUnknown(data['animal_id']!, _animalIdMeta));
    } else if (isInserting) {
      context.missing(_animalIdMeta);
    }
    if (data.containsKey('birth_weight_kg')) {
      context.handle(
          _birthWeightKgMeta,
          birthWeightKg.isAcceptableOrUnknown(
              data['birth_weight_kg']!, _birthWeightKgMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    if (data.containsKey('sync_state')) {
      context.handle(_syncStateMeta,
          syncState.isAcceptableOrUnknown(data['sync_state']!, _syncStateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {lambingId, animalId},
      ];
  @override
  LambingLamb map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LambingLamb(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      farmId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}farm_id'])!,
      lambingId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}lambing_id'])!,
      animalId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}animal_id'])!,
      birthWeightKg: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}birth_weight_kg']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
      syncState: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_state'])!,
    );
  }

  @override
  $LambingLambsTable createAlias(String alias) {
    return $LambingLambsTable(attachedDatabase, alias);
  }
}

class LambingLamb extends DataClass implements Insertable<LambingLamb> {
  final String id;
  final String farmId;
  final String lambingId;
  final String animalId;
  final double? birthWeightKg;
  final String notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String syncState;
  const LambingLamb(
      {required this.id,
      required this.farmId,
      required this.lambingId,
      required this.animalId,
      this.birthWeightKg,
      required this.notes,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt,
      required this.syncState});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['farm_id'] = Variable<String>(farmId);
    map['lambing_id'] = Variable<String>(lambingId);
    map['animal_id'] = Variable<String>(animalId);
    if (!nullToAbsent || birthWeightKg != null) {
      map['birth_weight_kg'] = Variable<double>(birthWeightKg);
    }
    map['notes'] = Variable<String>(notes);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['sync_state'] = Variable<String>(syncState);
    return map;
  }

  LambingLambsCompanion toCompanion(bool nullToAbsent) {
    return LambingLambsCompanion(
      id: Value(id),
      farmId: Value(farmId),
      lambingId: Value(lambingId),
      animalId: Value(animalId),
      birthWeightKg: birthWeightKg == null && nullToAbsent
          ? const Value.absent()
          : Value(birthWeightKg),
      notes: Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      syncState: Value(syncState),
    );
  }

  factory LambingLamb.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LambingLamb(
      id: serializer.fromJson<String>(json['id']),
      farmId: serializer.fromJson<String>(json['farmId']),
      lambingId: serializer.fromJson<String>(json['lambingId']),
      animalId: serializer.fromJson<String>(json['animalId']),
      birthWeightKg: serializer.fromJson<double?>(json['birthWeightKg']),
      notes: serializer.fromJson<String>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      syncState: serializer.fromJson<String>(json['syncState']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'farmId': serializer.toJson<String>(farmId),
      'lambingId': serializer.toJson<String>(lambingId),
      'animalId': serializer.toJson<String>(animalId),
      'birthWeightKg': serializer.toJson<double?>(birthWeightKg),
      'notes': serializer.toJson<String>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'syncState': serializer.toJson<String>(syncState),
    };
  }

  LambingLamb copyWith(
          {String? id,
          String? farmId,
          String? lambingId,
          String? animalId,
          Value<double?> birthWeightKg = const Value.absent(),
          String? notes,
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<DateTime?> deletedAt = const Value.absent(),
          String? syncState}) =>
      LambingLamb(
        id: id ?? this.id,
        farmId: farmId ?? this.farmId,
        lambingId: lambingId ?? this.lambingId,
        animalId: animalId ?? this.animalId,
        birthWeightKg:
            birthWeightKg.present ? birthWeightKg.value : this.birthWeightKg,
        notes: notes ?? this.notes,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
        syncState: syncState ?? this.syncState,
      );
  LambingLamb copyWithCompanion(LambingLambsCompanion data) {
    return LambingLamb(
      id: data.id.present ? data.id.value : this.id,
      farmId: data.farmId.present ? data.farmId.value : this.farmId,
      lambingId: data.lambingId.present ? data.lambingId.value : this.lambingId,
      animalId: data.animalId.present ? data.animalId.value : this.animalId,
      birthWeightKg: data.birthWeightKg.present
          ? data.birthWeightKg.value
          : this.birthWeightKg,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      syncState: data.syncState.present ? data.syncState.value : this.syncState,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LambingLamb(')
          ..write('id: $id, ')
          ..write('farmId: $farmId, ')
          ..write('lambingId: $lambingId, ')
          ..write('animalId: $animalId, ')
          ..write('birthWeightKg: $birthWeightKg, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncState: $syncState')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, farmId, lambingId, animalId,
      birthWeightKg, notes, createdAt, updatedAt, deletedAt, syncState);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LambingLamb &&
          other.id == this.id &&
          other.farmId == this.farmId &&
          other.lambingId == this.lambingId &&
          other.animalId == this.animalId &&
          other.birthWeightKg == this.birthWeightKg &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.syncState == this.syncState);
}

class LambingLambsCompanion extends UpdateCompanion<LambingLamb> {
  final Value<String> id;
  final Value<String> farmId;
  final Value<String> lambingId;
  final Value<String> animalId;
  final Value<double?> birthWeightKg;
  final Value<String> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> syncState;
  final Value<int> rowid;
  const LambingLambsCompanion({
    this.id = const Value.absent(),
    this.farmId = const Value.absent(),
    this.lambingId = const Value.absent(),
    this.animalId = const Value.absent(),
    this.birthWeightKg = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.syncState = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LambingLambsCompanion.insert({
    required String id,
    required String farmId,
    required String lambingId,
    required String animalId,
    this.birthWeightKg = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.syncState = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        farmId = Value(farmId),
        lambingId = Value(lambingId),
        animalId = Value(animalId);
  static Insertable<LambingLamb> custom({
    Expression<String>? id,
    Expression<String>? farmId,
    Expression<String>? lambingId,
    Expression<String>? animalId,
    Expression<double>? birthWeightKg,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? syncState,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (farmId != null) 'farm_id': farmId,
      if (lambingId != null) 'lambing_id': lambingId,
      if (animalId != null) 'animal_id': animalId,
      if (birthWeightKg != null) 'birth_weight_kg': birthWeightKg,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (syncState != null) 'sync_state': syncState,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LambingLambsCompanion copyWith(
      {Value<String>? id,
      Value<String>? farmId,
      Value<String>? lambingId,
      Value<String>? animalId,
      Value<double?>? birthWeightKg,
      Value<String>? notes,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<DateTime?>? deletedAt,
      Value<String>? syncState,
      Value<int>? rowid}) {
    return LambingLambsCompanion(
      id: id ?? this.id,
      farmId: farmId ?? this.farmId,
      lambingId: lambingId ?? this.lambingId,
      animalId: animalId ?? this.animalId,
      birthWeightKg: birthWeightKg ?? this.birthWeightKg,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      syncState: syncState ?? this.syncState,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (farmId.present) {
      map['farm_id'] = Variable<String>(farmId.value);
    }
    if (lambingId.present) {
      map['lambing_id'] = Variable<String>(lambingId.value);
    }
    if (animalId.present) {
      map['animal_id'] = Variable<String>(animalId.value);
    }
    if (birthWeightKg.present) {
      map['birth_weight_kg'] = Variable<double>(birthWeightKg.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (syncState.present) {
      map['sync_state'] = Variable<String>(syncState.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LambingLambsCompanion(')
          ..write('id: $id, ')
          ..write('farmId: $farmId, ')
          ..write('lambingId: $lambingId, ')
          ..write('animalId: $animalId, ')
          ..write('birthWeightKg: $birthWeightKg, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncState: $syncState, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TreatmentsTable extends Treatments
    with TableInfo<$TreatmentsTable, Treatment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TreatmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _farmIdMeta = const VerificationMeta('farmId');
  @override
  late final GeneratedColumn<String> farmId = GeneratedColumn<String>(
      'farm_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES farms (id)'));
  static const VerificationMeta _animalIdMeta =
      const VerificationMeta('animalId');
  @override
  late final GeneratedColumn<String> animalId = GeneratedColumn<String>(
      'animal_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES animals (id)'));
  static const VerificationMeta _productNameMeta =
      const VerificationMeta('productName');
  @override
  late final GeneratedColumn<String> productName = GeneratedColumn<String>(
      'product_name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 160),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _activeIngredientMeta =
      const VerificationMeta('activeIngredient');
  @override
  late final GeneratedColumn<String> activeIngredient = GeneratedColumn<String>(
      'active_ingredient', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _doseValueMeta =
      const VerificationMeta('doseValue');
  @override
  late final GeneratedColumn<double> doseValue = GeneratedColumn<double>(
      'dose_value', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _doseUnitMeta =
      const VerificationMeta('doseUnit');
  @override
  late final GeneratedColumn<String> doseUnit = GeneratedColumn<String>(
      'dose_unit', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _administrationRouteMeta =
      const VerificationMeta('administrationRoute');
  @override
  late final GeneratedColumn<String> administrationRoute =
      GeneratedColumn<String>('administration_route', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _administeredAtMeta =
      const VerificationMeta('administeredAt');
  @override
  late final GeneratedColumn<DateTime> administeredAt =
      GeneratedColumn<DateTime>('administered_at', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _reasonMeta = const VerificationMeta('reason');
  @override
  late final GeneratedColumn<String> reason = GeneratedColumn<String>(
      'reason', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _administeredByMeta =
      const VerificationMeta('administeredBy');
  @override
  late final GeneratedColumn<String> administeredBy = GeneratedColumn<String>(
      'administered_by', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _withdrawalMeatDaysMeta =
      const VerificationMeta('withdrawalMeatDays');
  @override
  late final GeneratedColumn<int> withdrawalMeatDays = GeneratedColumn<int>(
      'withdrawal_meat_days', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _withdrawalMilkDaysMeta =
      const VerificationMeta('withdrawalMilkDays');
  @override
  late final GeneratedColumn<int> withdrawalMilkDays = GeneratedColumn<int>(
      'withdrawal_milk_days', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _followUpAtMeta =
      const VerificationMeta('followUpAt');
  @override
  late final GeneratedColumn<DateTime> followUpAt = GeneratedColumn<DateTime>(
      'follow_up_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: DateTime.now);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: DateTime.now);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _syncStateMeta =
      const VerificationMeta('syncState');
  @override
  late final GeneratedColumn<String> syncState = GeneratedColumn<String>(
      'sync_state', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _createdByMeta =
      const VerificationMeta('createdBy');
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
      'created_by', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _updatedByMeta =
      const VerificationMeta('updatedBy');
  @override
  late final GeneratedColumn<String> updatedBy = GeneratedColumn<String>(
      'updated_by', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        farmId,
        animalId,
        productName,
        activeIngredient,
        doseValue,
        doseUnit,
        administrationRoute,
        administeredAt,
        reason,
        notes,
        administeredBy,
        withdrawalMeatDays,
        withdrawalMilkDays,
        followUpAt,
        createdAt,
        updatedAt,
        deletedAt,
        syncState,
        createdBy,
        updatedBy
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'treatments';
  @override
  VerificationContext validateIntegrity(Insertable<Treatment> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('farm_id')) {
      context.handle(_farmIdMeta,
          farmId.isAcceptableOrUnknown(data['farm_id']!, _farmIdMeta));
    } else if (isInserting) {
      context.missing(_farmIdMeta);
    }
    if (data.containsKey('animal_id')) {
      context.handle(_animalIdMeta,
          animalId.isAcceptableOrUnknown(data['animal_id']!, _animalIdMeta));
    } else if (isInserting) {
      context.missing(_animalIdMeta);
    }
    if (data.containsKey('product_name')) {
      context.handle(
          _productNameMeta,
          productName.isAcceptableOrUnknown(
              data['product_name']!, _productNameMeta));
    } else if (isInserting) {
      context.missing(_productNameMeta);
    }
    if (data.containsKey('active_ingredient')) {
      context.handle(
          _activeIngredientMeta,
          activeIngredient.isAcceptableOrUnknown(
              data['active_ingredient']!, _activeIngredientMeta));
    }
    if (data.containsKey('dose_value')) {
      context.handle(_doseValueMeta,
          doseValue.isAcceptableOrUnknown(data['dose_value']!, _doseValueMeta));
    }
    if (data.containsKey('dose_unit')) {
      context.handle(_doseUnitMeta,
          doseUnit.isAcceptableOrUnknown(data['dose_unit']!, _doseUnitMeta));
    }
    if (data.containsKey('administration_route')) {
      context.handle(
          _administrationRouteMeta,
          administrationRoute.isAcceptableOrUnknown(
              data['administration_route']!, _administrationRouteMeta));
    }
    if (data.containsKey('administered_at')) {
      context.handle(
          _administeredAtMeta,
          administeredAt.isAcceptableOrUnknown(
              data['administered_at']!, _administeredAtMeta));
    } else if (isInserting) {
      context.missing(_administeredAtMeta);
    }
    if (data.containsKey('reason')) {
      context.handle(_reasonMeta,
          reason.isAcceptableOrUnknown(data['reason']!, _reasonMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('administered_by')) {
      context.handle(
          _administeredByMeta,
          administeredBy.isAcceptableOrUnknown(
              data['administered_by']!, _administeredByMeta));
    }
    if (data.containsKey('withdrawal_meat_days')) {
      context.handle(
          _withdrawalMeatDaysMeta,
          withdrawalMeatDays.isAcceptableOrUnknown(
              data['withdrawal_meat_days']!, _withdrawalMeatDaysMeta));
    }
    if (data.containsKey('withdrawal_milk_days')) {
      context.handle(
          _withdrawalMilkDaysMeta,
          withdrawalMilkDays.isAcceptableOrUnknown(
              data['withdrawal_milk_days']!, _withdrawalMilkDaysMeta));
    }
    if (data.containsKey('follow_up_at')) {
      context.handle(
          _followUpAtMeta,
          followUpAt.isAcceptableOrUnknown(
              data['follow_up_at']!, _followUpAtMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    if (data.containsKey('sync_state')) {
      context.handle(_syncStateMeta,
          syncState.isAcceptableOrUnknown(data['sync_state']!, _syncStateMeta));
    }
    if (data.containsKey('created_by')) {
      context.handle(_createdByMeta,
          createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta));
    }
    if (data.containsKey('updated_by')) {
      context.handle(_updatedByMeta,
          updatedBy.isAcceptableOrUnknown(data['updated_by']!, _updatedByMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Treatment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Treatment(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      farmId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}farm_id'])!,
      animalId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}animal_id'])!,
      productName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}product_name'])!,
      activeIngredient: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}active_ingredient']),
      doseValue: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}dose_value']),
      doseUnit: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}dose_unit']),
      administrationRoute: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}administration_route']),
      administeredAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}administered_at'])!,
      reason: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reason'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes'])!,
      administeredBy: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}administered_by']),
      withdrawalMeatDays: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}withdrawal_meat_days']),
      withdrawalMilkDays: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}withdrawal_milk_days']),
      followUpAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}follow_up_at']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
      syncState: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_state'])!,
      createdBy: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_by']),
      updatedBy: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}updated_by']),
    );
  }

  @override
  $TreatmentsTable createAlias(String alias) {
    return $TreatmentsTable(attachedDatabase, alias);
  }
}

class Treatment extends DataClass implements Insertable<Treatment> {
  final String id;
  final String farmId;
  final String animalId;
  final String productName;
  final String? activeIngredient;
  final double? doseValue;
  final String? doseUnit;
  final String? administrationRoute;
  final DateTime administeredAt;
  final String reason;
  final String notes;
  final String? administeredBy;
  final int? withdrawalMeatDays;
  final int? withdrawalMilkDays;
  final DateTime? followUpAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String syncState;
  final String? createdBy;
  final String? updatedBy;
  const Treatment(
      {required this.id,
      required this.farmId,
      required this.animalId,
      required this.productName,
      this.activeIngredient,
      this.doseValue,
      this.doseUnit,
      this.administrationRoute,
      required this.administeredAt,
      required this.reason,
      required this.notes,
      this.administeredBy,
      this.withdrawalMeatDays,
      this.withdrawalMilkDays,
      this.followUpAt,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt,
      required this.syncState,
      this.createdBy,
      this.updatedBy});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['farm_id'] = Variable<String>(farmId);
    map['animal_id'] = Variable<String>(animalId);
    map['product_name'] = Variable<String>(productName);
    if (!nullToAbsent || activeIngredient != null) {
      map['active_ingredient'] = Variable<String>(activeIngredient);
    }
    if (!nullToAbsent || doseValue != null) {
      map['dose_value'] = Variable<double>(doseValue);
    }
    if (!nullToAbsent || doseUnit != null) {
      map['dose_unit'] = Variable<String>(doseUnit);
    }
    if (!nullToAbsent || administrationRoute != null) {
      map['administration_route'] = Variable<String>(administrationRoute);
    }
    map['administered_at'] = Variable<DateTime>(administeredAt);
    map['reason'] = Variable<String>(reason);
    map['notes'] = Variable<String>(notes);
    if (!nullToAbsent || administeredBy != null) {
      map['administered_by'] = Variable<String>(administeredBy);
    }
    if (!nullToAbsent || withdrawalMeatDays != null) {
      map['withdrawal_meat_days'] = Variable<int>(withdrawalMeatDays);
    }
    if (!nullToAbsent || withdrawalMilkDays != null) {
      map['withdrawal_milk_days'] = Variable<int>(withdrawalMilkDays);
    }
    if (!nullToAbsent || followUpAt != null) {
      map['follow_up_at'] = Variable<DateTime>(followUpAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['sync_state'] = Variable<String>(syncState);
    if (!nullToAbsent || createdBy != null) {
      map['created_by'] = Variable<String>(createdBy);
    }
    if (!nullToAbsent || updatedBy != null) {
      map['updated_by'] = Variable<String>(updatedBy);
    }
    return map;
  }

  TreatmentsCompanion toCompanion(bool nullToAbsent) {
    return TreatmentsCompanion(
      id: Value(id),
      farmId: Value(farmId),
      animalId: Value(animalId),
      productName: Value(productName),
      activeIngredient: activeIngredient == null && nullToAbsent
          ? const Value.absent()
          : Value(activeIngredient),
      doseValue: doseValue == null && nullToAbsent
          ? const Value.absent()
          : Value(doseValue),
      doseUnit: doseUnit == null && nullToAbsent
          ? const Value.absent()
          : Value(doseUnit),
      administrationRoute: administrationRoute == null && nullToAbsent
          ? const Value.absent()
          : Value(administrationRoute),
      administeredAt: Value(administeredAt),
      reason: Value(reason),
      notes: Value(notes),
      administeredBy: administeredBy == null && nullToAbsent
          ? const Value.absent()
          : Value(administeredBy),
      withdrawalMeatDays: withdrawalMeatDays == null && nullToAbsent
          ? const Value.absent()
          : Value(withdrawalMeatDays),
      withdrawalMilkDays: withdrawalMilkDays == null && nullToAbsent
          ? const Value.absent()
          : Value(withdrawalMilkDays),
      followUpAt: followUpAt == null && nullToAbsent
          ? const Value.absent()
          : Value(followUpAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      syncState: Value(syncState),
      createdBy: createdBy == null && nullToAbsent
          ? const Value.absent()
          : Value(createdBy),
      updatedBy: updatedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedBy),
    );
  }

  factory Treatment.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Treatment(
      id: serializer.fromJson<String>(json['id']),
      farmId: serializer.fromJson<String>(json['farmId']),
      animalId: serializer.fromJson<String>(json['animalId']),
      productName: serializer.fromJson<String>(json['productName']),
      activeIngredient: serializer.fromJson<String?>(json['activeIngredient']),
      doseValue: serializer.fromJson<double?>(json['doseValue']),
      doseUnit: serializer.fromJson<String?>(json['doseUnit']),
      administrationRoute:
          serializer.fromJson<String?>(json['administrationRoute']),
      administeredAt: serializer.fromJson<DateTime>(json['administeredAt']),
      reason: serializer.fromJson<String>(json['reason']),
      notes: serializer.fromJson<String>(json['notes']),
      administeredBy: serializer.fromJson<String?>(json['administeredBy']),
      withdrawalMeatDays: serializer.fromJson<int?>(json['withdrawalMeatDays']),
      withdrawalMilkDays: serializer.fromJson<int?>(json['withdrawalMilkDays']),
      followUpAt: serializer.fromJson<DateTime?>(json['followUpAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      syncState: serializer.fromJson<String>(json['syncState']),
      createdBy: serializer.fromJson<String?>(json['createdBy']),
      updatedBy: serializer.fromJson<String?>(json['updatedBy']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'farmId': serializer.toJson<String>(farmId),
      'animalId': serializer.toJson<String>(animalId),
      'productName': serializer.toJson<String>(productName),
      'activeIngredient': serializer.toJson<String?>(activeIngredient),
      'doseValue': serializer.toJson<double?>(doseValue),
      'doseUnit': serializer.toJson<String?>(doseUnit),
      'administrationRoute': serializer.toJson<String?>(administrationRoute),
      'administeredAt': serializer.toJson<DateTime>(administeredAt),
      'reason': serializer.toJson<String>(reason),
      'notes': serializer.toJson<String>(notes),
      'administeredBy': serializer.toJson<String?>(administeredBy),
      'withdrawalMeatDays': serializer.toJson<int?>(withdrawalMeatDays),
      'withdrawalMilkDays': serializer.toJson<int?>(withdrawalMilkDays),
      'followUpAt': serializer.toJson<DateTime?>(followUpAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'syncState': serializer.toJson<String>(syncState),
      'createdBy': serializer.toJson<String?>(createdBy),
      'updatedBy': serializer.toJson<String?>(updatedBy),
    };
  }

  Treatment copyWith(
          {String? id,
          String? farmId,
          String? animalId,
          String? productName,
          Value<String?> activeIngredient = const Value.absent(),
          Value<double?> doseValue = const Value.absent(),
          Value<String?> doseUnit = const Value.absent(),
          Value<String?> administrationRoute = const Value.absent(),
          DateTime? administeredAt,
          String? reason,
          String? notes,
          Value<String?> administeredBy = const Value.absent(),
          Value<int?> withdrawalMeatDays = const Value.absent(),
          Value<int?> withdrawalMilkDays = const Value.absent(),
          Value<DateTime?> followUpAt = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<DateTime?> deletedAt = const Value.absent(),
          String? syncState,
          Value<String?> createdBy = const Value.absent(),
          Value<String?> updatedBy = const Value.absent()}) =>
      Treatment(
        id: id ?? this.id,
        farmId: farmId ?? this.farmId,
        animalId: animalId ?? this.animalId,
        productName: productName ?? this.productName,
        activeIngredient: activeIngredient.present
            ? activeIngredient.value
            : this.activeIngredient,
        doseValue: doseValue.present ? doseValue.value : this.doseValue,
        doseUnit: doseUnit.present ? doseUnit.value : this.doseUnit,
        administrationRoute: administrationRoute.present
            ? administrationRoute.value
            : this.administrationRoute,
        administeredAt: administeredAt ?? this.administeredAt,
        reason: reason ?? this.reason,
        notes: notes ?? this.notes,
        administeredBy:
            administeredBy.present ? administeredBy.value : this.administeredBy,
        withdrawalMeatDays: withdrawalMeatDays.present
            ? withdrawalMeatDays.value
            : this.withdrawalMeatDays,
        withdrawalMilkDays: withdrawalMilkDays.present
            ? withdrawalMilkDays.value
            : this.withdrawalMilkDays,
        followUpAt: followUpAt.present ? followUpAt.value : this.followUpAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
        syncState: syncState ?? this.syncState,
        createdBy: createdBy.present ? createdBy.value : this.createdBy,
        updatedBy: updatedBy.present ? updatedBy.value : this.updatedBy,
      );
  Treatment copyWithCompanion(TreatmentsCompanion data) {
    return Treatment(
      id: data.id.present ? data.id.value : this.id,
      farmId: data.farmId.present ? data.farmId.value : this.farmId,
      animalId: data.animalId.present ? data.animalId.value : this.animalId,
      productName:
          data.productName.present ? data.productName.value : this.productName,
      activeIngredient: data.activeIngredient.present
          ? data.activeIngredient.value
          : this.activeIngredient,
      doseValue: data.doseValue.present ? data.doseValue.value : this.doseValue,
      doseUnit: data.doseUnit.present ? data.doseUnit.value : this.doseUnit,
      administrationRoute: data.administrationRoute.present
          ? data.administrationRoute.value
          : this.administrationRoute,
      administeredAt: data.administeredAt.present
          ? data.administeredAt.value
          : this.administeredAt,
      reason: data.reason.present ? data.reason.value : this.reason,
      notes: data.notes.present ? data.notes.value : this.notes,
      administeredBy: data.administeredBy.present
          ? data.administeredBy.value
          : this.administeredBy,
      withdrawalMeatDays: data.withdrawalMeatDays.present
          ? data.withdrawalMeatDays.value
          : this.withdrawalMeatDays,
      withdrawalMilkDays: data.withdrawalMilkDays.present
          ? data.withdrawalMilkDays.value
          : this.withdrawalMilkDays,
      followUpAt:
          data.followUpAt.present ? data.followUpAt.value : this.followUpAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      syncState: data.syncState.present ? data.syncState.value : this.syncState,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      updatedBy: data.updatedBy.present ? data.updatedBy.value : this.updatedBy,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Treatment(')
          ..write('id: $id, ')
          ..write('farmId: $farmId, ')
          ..write('animalId: $animalId, ')
          ..write('productName: $productName, ')
          ..write('activeIngredient: $activeIngredient, ')
          ..write('doseValue: $doseValue, ')
          ..write('doseUnit: $doseUnit, ')
          ..write('administrationRoute: $administrationRoute, ')
          ..write('administeredAt: $administeredAt, ')
          ..write('reason: $reason, ')
          ..write('notes: $notes, ')
          ..write('administeredBy: $administeredBy, ')
          ..write('withdrawalMeatDays: $withdrawalMeatDays, ')
          ..write('withdrawalMilkDays: $withdrawalMilkDays, ')
          ..write('followUpAt: $followUpAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncState: $syncState, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedBy: $updatedBy')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        farmId,
        animalId,
        productName,
        activeIngredient,
        doseValue,
        doseUnit,
        administrationRoute,
        administeredAt,
        reason,
        notes,
        administeredBy,
        withdrawalMeatDays,
        withdrawalMilkDays,
        followUpAt,
        createdAt,
        updatedAt,
        deletedAt,
        syncState,
        createdBy,
        updatedBy
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Treatment &&
          other.id == this.id &&
          other.farmId == this.farmId &&
          other.animalId == this.animalId &&
          other.productName == this.productName &&
          other.activeIngredient == this.activeIngredient &&
          other.doseValue == this.doseValue &&
          other.doseUnit == this.doseUnit &&
          other.administrationRoute == this.administrationRoute &&
          other.administeredAt == this.administeredAt &&
          other.reason == this.reason &&
          other.notes == this.notes &&
          other.administeredBy == this.administeredBy &&
          other.withdrawalMeatDays == this.withdrawalMeatDays &&
          other.withdrawalMilkDays == this.withdrawalMilkDays &&
          other.followUpAt == this.followUpAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.syncState == this.syncState &&
          other.createdBy == this.createdBy &&
          other.updatedBy == this.updatedBy);
}

class TreatmentsCompanion extends UpdateCompanion<Treatment> {
  final Value<String> id;
  final Value<String> farmId;
  final Value<String> animalId;
  final Value<String> productName;
  final Value<String?> activeIngredient;
  final Value<double?> doseValue;
  final Value<String?> doseUnit;
  final Value<String?> administrationRoute;
  final Value<DateTime> administeredAt;
  final Value<String> reason;
  final Value<String> notes;
  final Value<String?> administeredBy;
  final Value<int?> withdrawalMeatDays;
  final Value<int?> withdrawalMilkDays;
  final Value<DateTime?> followUpAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> syncState;
  final Value<String?> createdBy;
  final Value<String?> updatedBy;
  final Value<int> rowid;
  const TreatmentsCompanion({
    this.id = const Value.absent(),
    this.farmId = const Value.absent(),
    this.animalId = const Value.absent(),
    this.productName = const Value.absent(),
    this.activeIngredient = const Value.absent(),
    this.doseValue = const Value.absent(),
    this.doseUnit = const Value.absent(),
    this.administrationRoute = const Value.absent(),
    this.administeredAt = const Value.absent(),
    this.reason = const Value.absent(),
    this.notes = const Value.absent(),
    this.administeredBy = const Value.absent(),
    this.withdrawalMeatDays = const Value.absent(),
    this.withdrawalMilkDays = const Value.absent(),
    this.followUpAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.syncState = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TreatmentsCompanion.insert({
    required String id,
    required String farmId,
    required String animalId,
    required String productName,
    this.activeIngredient = const Value.absent(),
    this.doseValue = const Value.absent(),
    this.doseUnit = const Value.absent(),
    this.administrationRoute = const Value.absent(),
    required DateTime administeredAt,
    this.reason = const Value.absent(),
    this.notes = const Value.absent(),
    this.administeredBy = const Value.absent(),
    this.withdrawalMeatDays = const Value.absent(),
    this.withdrawalMilkDays = const Value.absent(),
    this.followUpAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.syncState = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        farmId = Value(farmId),
        animalId = Value(animalId),
        productName = Value(productName),
        administeredAt = Value(administeredAt);
  static Insertable<Treatment> custom({
    Expression<String>? id,
    Expression<String>? farmId,
    Expression<String>? animalId,
    Expression<String>? productName,
    Expression<String>? activeIngredient,
    Expression<double>? doseValue,
    Expression<String>? doseUnit,
    Expression<String>? administrationRoute,
    Expression<DateTime>? administeredAt,
    Expression<String>? reason,
    Expression<String>? notes,
    Expression<String>? administeredBy,
    Expression<int>? withdrawalMeatDays,
    Expression<int>? withdrawalMilkDays,
    Expression<DateTime>? followUpAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? syncState,
    Expression<String>? createdBy,
    Expression<String>? updatedBy,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (farmId != null) 'farm_id': farmId,
      if (animalId != null) 'animal_id': animalId,
      if (productName != null) 'product_name': productName,
      if (activeIngredient != null) 'active_ingredient': activeIngredient,
      if (doseValue != null) 'dose_value': doseValue,
      if (doseUnit != null) 'dose_unit': doseUnit,
      if (administrationRoute != null)
        'administration_route': administrationRoute,
      if (administeredAt != null) 'administered_at': administeredAt,
      if (reason != null) 'reason': reason,
      if (notes != null) 'notes': notes,
      if (administeredBy != null) 'administered_by': administeredBy,
      if (withdrawalMeatDays != null)
        'withdrawal_meat_days': withdrawalMeatDays,
      if (withdrawalMilkDays != null)
        'withdrawal_milk_days': withdrawalMilkDays,
      if (followUpAt != null) 'follow_up_at': followUpAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (syncState != null) 'sync_state': syncState,
      if (createdBy != null) 'created_by': createdBy,
      if (updatedBy != null) 'updated_by': updatedBy,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TreatmentsCompanion copyWith(
      {Value<String>? id,
      Value<String>? farmId,
      Value<String>? animalId,
      Value<String>? productName,
      Value<String?>? activeIngredient,
      Value<double?>? doseValue,
      Value<String?>? doseUnit,
      Value<String?>? administrationRoute,
      Value<DateTime>? administeredAt,
      Value<String>? reason,
      Value<String>? notes,
      Value<String?>? administeredBy,
      Value<int?>? withdrawalMeatDays,
      Value<int?>? withdrawalMilkDays,
      Value<DateTime?>? followUpAt,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<DateTime?>? deletedAt,
      Value<String>? syncState,
      Value<String?>? createdBy,
      Value<String?>? updatedBy,
      Value<int>? rowid}) {
    return TreatmentsCompanion(
      id: id ?? this.id,
      farmId: farmId ?? this.farmId,
      animalId: animalId ?? this.animalId,
      productName: productName ?? this.productName,
      activeIngredient: activeIngredient ?? this.activeIngredient,
      doseValue: doseValue ?? this.doseValue,
      doseUnit: doseUnit ?? this.doseUnit,
      administrationRoute: administrationRoute ?? this.administrationRoute,
      administeredAt: administeredAt ?? this.administeredAt,
      reason: reason ?? this.reason,
      notes: notes ?? this.notes,
      administeredBy: administeredBy ?? this.administeredBy,
      withdrawalMeatDays: withdrawalMeatDays ?? this.withdrawalMeatDays,
      withdrawalMilkDays: withdrawalMilkDays ?? this.withdrawalMilkDays,
      followUpAt: followUpAt ?? this.followUpAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      syncState: syncState ?? this.syncState,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (farmId.present) {
      map['farm_id'] = Variable<String>(farmId.value);
    }
    if (animalId.present) {
      map['animal_id'] = Variable<String>(animalId.value);
    }
    if (productName.present) {
      map['product_name'] = Variable<String>(productName.value);
    }
    if (activeIngredient.present) {
      map['active_ingredient'] = Variable<String>(activeIngredient.value);
    }
    if (doseValue.present) {
      map['dose_value'] = Variable<double>(doseValue.value);
    }
    if (doseUnit.present) {
      map['dose_unit'] = Variable<String>(doseUnit.value);
    }
    if (administrationRoute.present) {
      map['administration_route'] = Variable<String>(administrationRoute.value);
    }
    if (administeredAt.present) {
      map['administered_at'] = Variable<DateTime>(administeredAt.value);
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (administeredBy.present) {
      map['administered_by'] = Variable<String>(administeredBy.value);
    }
    if (withdrawalMeatDays.present) {
      map['withdrawal_meat_days'] = Variable<int>(withdrawalMeatDays.value);
    }
    if (withdrawalMilkDays.present) {
      map['withdrawal_milk_days'] = Variable<int>(withdrawalMilkDays.value);
    }
    if (followUpAt.present) {
      map['follow_up_at'] = Variable<DateTime>(followUpAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (syncState.present) {
      map['sync_state'] = Variable<String>(syncState.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (updatedBy.present) {
      map['updated_by'] = Variable<String>(updatedBy.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TreatmentsCompanion(')
          ..write('id: $id, ')
          ..write('farmId: $farmId, ')
          ..write('animalId: $animalId, ')
          ..write('productName: $productName, ')
          ..write('activeIngredient: $activeIngredient, ')
          ..write('doseValue: $doseValue, ')
          ..write('doseUnit: $doseUnit, ')
          ..write('administrationRoute: $administrationRoute, ')
          ..write('administeredAt: $administeredAt, ')
          ..write('reason: $reason, ')
          ..write('notes: $notes, ')
          ..write('administeredBy: $administeredBy, ')
          ..write('withdrawalMeatDays: $withdrawalMeatDays, ')
          ..write('withdrawalMilkDays: $withdrawalMilkDays, ')
          ..write('followUpAt: $followUpAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncState: $syncState, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BreedingEventsTable extends BreedingEvents
    with TableInfo<$BreedingEventsTable, BreedingEvent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BreedingEventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _farmIdMeta = const VerificationMeta('farmId');
  @override
  late final GeneratedColumn<String> farmId = GeneratedColumn<String>(
      'farm_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES farms (id)'));
  static const VerificationMeta _damIdMeta = const VerificationMeta('damId');
  @override
  late final GeneratedColumn<String> damId = GeneratedColumn<String>(
      'dam_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES animals (id)'));
  static const VerificationMeta _sireIdMeta = const VerificationMeta('sireId');
  @override
  late final GeneratedColumn<String> sireId = GeneratedColumn<String>(
      'sire_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES animals (id)'));
  static const VerificationMeta _occurredAtMeta =
      const VerificationMeta('occurredAt');
  @override
  late final GeneratedColumn<DateTime> occurredAt = GeneratedColumn<DateTime>(
      'occurred_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _eventTypeMeta =
      const VerificationMeta('eventType');
  @override
  late final GeneratedColumn<String> eventType = GeneratedColumn<String>(
      'event_type', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('mating'));
  static const VerificationMeta _outcomeMeta =
      const VerificationMeta('outcome');
  @override
  late final GeneratedColumn<String> outcome = GeneratedColumn<String>(
      'outcome', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: DateTime.now);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: DateTime.now);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _syncStateMeta =
      const VerificationMeta('syncState');
  @override
  late final GeneratedColumn<String> syncState = GeneratedColumn<String>(
      'sync_state', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _createdByMeta =
      const VerificationMeta('createdBy');
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
      'created_by', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _updatedByMeta =
      const VerificationMeta('updatedBy');
  @override
  late final GeneratedColumn<String> updatedBy = GeneratedColumn<String>(
      'updated_by', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        farmId,
        damId,
        sireId,
        occurredAt,
        eventType,
        outcome,
        notes,
        createdAt,
        updatedAt,
        deletedAt,
        syncState,
        createdBy,
        updatedBy
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'breeding_events';
  @override
  VerificationContext validateIntegrity(Insertable<BreedingEvent> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('farm_id')) {
      context.handle(_farmIdMeta,
          farmId.isAcceptableOrUnknown(data['farm_id']!, _farmIdMeta));
    } else if (isInserting) {
      context.missing(_farmIdMeta);
    }
    if (data.containsKey('dam_id')) {
      context.handle(
          _damIdMeta, damId.isAcceptableOrUnknown(data['dam_id']!, _damIdMeta));
    } else if (isInserting) {
      context.missing(_damIdMeta);
    }
    if (data.containsKey('sire_id')) {
      context.handle(_sireIdMeta,
          sireId.isAcceptableOrUnknown(data['sire_id']!, _sireIdMeta));
    } else if (isInserting) {
      context.missing(_sireIdMeta);
    }
    if (data.containsKey('occurred_at')) {
      context.handle(
          _occurredAtMeta,
          occurredAt.isAcceptableOrUnknown(
              data['occurred_at']!, _occurredAtMeta));
    } else if (isInserting) {
      context.missing(_occurredAtMeta);
    }
    if (data.containsKey('event_type')) {
      context.handle(_eventTypeMeta,
          eventType.isAcceptableOrUnknown(data['event_type']!, _eventTypeMeta));
    }
    if (data.containsKey('outcome')) {
      context.handle(_outcomeMeta,
          outcome.isAcceptableOrUnknown(data['outcome']!, _outcomeMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    if (data.containsKey('sync_state')) {
      context.handle(_syncStateMeta,
          syncState.isAcceptableOrUnknown(data['sync_state']!, _syncStateMeta));
    }
    if (data.containsKey('created_by')) {
      context.handle(_createdByMeta,
          createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta));
    }
    if (data.containsKey('updated_by')) {
      context.handle(_updatedByMeta,
          updatedBy.isAcceptableOrUnknown(data['updated_by']!, _updatedByMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BreedingEvent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BreedingEvent(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      farmId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}farm_id'])!,
      damId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}dam_id'])!,
      sireId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sire_id'])!,
      occurredAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}occurred_at'])!,
      eventType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}event_type'])!,
      outcome: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}outcome']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
      syncState: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_state'])!,
      createdBy: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_by']),
      updatedBy: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}updated_by']),
    );
  }

  @override
  $BreedingEventsTable createAlias(String alias) {
    return $BreedingEventsTable(attachedDatabase, alias);
  }
}

class BreedingEvent extends DataClass implements Insertable<BreedingEvent> {
  final String id;
  final String farmId;
  final String damId;
  final String sireId;
  final DateTime occurredAt;
  final String eventType;
  final String? outcome;
  final String notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String syncState;
  final String? createdBy;
  final String? updatedBy;
  const BreedingEvent(
      {required this.id,
      required this.farmId,
      required this.damId,
      required this.sireId,
      required this.occurredAt,
      required this.eventType,
      this.outcome,
      required this.notes,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt,
      required this.syncState,
      this.createdBy,
      this.updatedBy});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['farm_id'] = Variable<String>(farmId);
    map['dam_id'] = Variable<String>(damId);
    map['sire_id'] = Variable<String>(sireId);
    map['occurred_at'] = Variable<DateTime>(occurredAt);
    map['event_type'] = Variable<String>(eventType);
    if (!nullToAbsent || outcome != null) {
      map['outcome'] = Variable<String>(outcome);
    }
    map['notes'] = Variable<String>(notes);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['sync_state'] = Variable<String>(syncState);
    if (!nullToAbsent || createdBy != null) {
      map['created_by'] = Variable<String>(createdBy);
    }
    if (!nullToAbsent || updatedBy != null) {
      map['updated_by'] = Variable<String>(updatedBy);
    }
    return map;
  }

  BreedingEventsCompanion toCompanion(bool nullToAbsent) {
    return BreedingEventsCompanion(
      id: Value(id),
      farmId: Value(farmId),
      damId: Value(damId),
      sireId: Value(sireId),
      occurredAt: Value(occurredAt),
      eventType: Value(eventType),
      outcome: outcome == null && nullToAbsent
          ? const Value.absent()
          : Value(outcome),
      notes: Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      syncState: Value(syncState),
      createdBy: createdBy == null && nullToAbsent
          ? const Value.absent()
          : Value(createdBy),
      updatedBy: updatedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedBy),
    );
  }

  factory BreedingEvent.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BreedingEvent(
      id: serializer.fromJson<String>(json['id']),
      farmId: serializer.fromJson<String>(json['farmId']),
      damId: serializer.fromJson<String>(json['damId']),
      sireId: serializer.fromJson<String>(json['sireId']),
      occurredAt: serializer.fromJson<DateTime>(json['occurredAt']),
      eventType: serializer.fromJson<String>(json['eventType']),
      outcome: serializer.fromJson<String?>(json['outcome']),
      notes: serializer.fromJson<String>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      syncState: serializer.fromJson<String>(json['syncState']),
      createdBy: serializer.fromJson<String?>(json['createdBy']),
      updatedBy: serializer.fromJson<String?>(json['updatedBy']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'farmId': serializer.toJson<String>(farmId),
      'damId': serializer.toJson<String>(damId),
      'sireId': serializer.toJson<String>(sireId),
      'occurredAt': serializer.toJson<DateTime>(occurredAt),
      'eventType': serializer.toJson<String>(eventType),
      'outcome': serializer.toJson<String?>(outcome),
      'notes': serializer.toJson<String>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'syncState': serializer.toJson<String>(syncState),
      'createdBy': serializer.toJson<String?>(createdBy),
      'updatedBy': serializer.toJson<String?>(updatedBy),
    };
  }

  BreedingEvent copyWith(
          {String? id,
          String? farmId,
          String? damId,
          String? sireId,
          DateTime? occurredAt,
          String? eventType,
          Value<String?> outcome = const Value.absent(),
          String? notes,
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<DateTime?> deletedAt = const Value.absent(),
          String? syncState,
          Value<String?> createdBy = const Value.absent(),
          Value<String?> updatedBy = const Value.absent()}) =>
      BreedingEvent(
        id: id ?? this.id,
        farmId: farmId ?? this.farmId,
        damId: damId ?? this.damId,
        sireId: sireId ?? this.sireId,
        occurredAt: occurredAt ?? this.occurredAt,
        eventType: eventType ?? this.eventType,
        outcome: outcome.present ? outcome.value : this.outcome,
        notes: notes ?? this.notes,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
        syncState: syncState ?? this.syncState,
        createdBy: createdBy.present ? createdBy.value : this.createdBy,
        updatedBy: updatedBy.present ? updatedBy.value : this.updatedBy,
      );
  BreedingEvent copyWithCompanion(BreedingEventsCompanion data) {
    return BreedingEvent(
      id: data.id.present ? data.id.value : this.id,
      farmId: data.farmId.present ? data.farmId.value : this.farmId,
      damId: data.damId.present ? data.damId.value : this.damId,
      sireId: data.sireId.present ? data.sireId.value : this.sireId,
      occurredAt:
          data.occurredAt.present ? data.occurredAt.value : this.occurredAt,
      eventType: data.eventType.present ? data.eventType.value : this.eventType,
      outcome: data.outcome.present ? data.outcome.value : this.outcome,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      syncState: data.syncState.present ? data.syncState.value : this.syncState,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      updatedBy: data.updatedBy.present ? data.updatedBy.value : this.updatedBy,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BreedingEvent(')
          ..write('id: $id, ')
          ..write('farmId: $farmId, ')
          ..write('damId: $damId, ')
          ..write('sireId: $sireId, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('eventType: $eventType, ')
          ..write('outcome: $outcome, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncState: $syncState, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedBy: $updatedBy')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      farmId,
      damId,
      sireId,
      occurredAt,
      eventType,
      outcome,
      notes,
      createdAt,
      updatedAt,
      deletedAt,
      syncState,
      createdBy,
      updatedBy);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BreedingEvent &&
          other.id == this.id &&
          other.farmId == this.farmId &&
          other.damId == this.damId &&
          other.sireId == this.sireId &&
          other.occurredAt == this.occurredAt &&
          other.eventType == this.eventType &&
          other.outcome == this.outcome &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.syncState == this.syncState &&
          other.createdBy == this.createdBy &&
          other.updatedBy == this.updatedBy);
}

class BreedingEventsCompanion extends UpdateCompanion<BreedingEvent> {
  final Value<String> id;
  final Value<String> farmId;
  final Value<String> damId;
  final Value<String> sireId;
  final Value<DateTime> occurredAt;
  final Value<String> eventType;
  final Value<String?> outcome;
  final Value<String> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> syncState;
  final Value<String?> createdBy;
  final Value<String?> updatedBy;
  final Value<int> rowid;
  const BreedingEventsCompanion({
    this.id = const Value.absent(),
    this.farmId = const Value.absent(),
    this.damId = const Value.absent(),
    this.sireId = const Value.absent(),
    this.occurredAt = const Value.absent(),
    this.eventType = const Value.absent(),
    this.outcome = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.syncState = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BreedingEventsCompanion.insert({
    required String id,
    required String farmId,
    required String damId,
    required String sireId,
    required DateTime occurredAt,
    this.eventType = const Value.absent(),
    this.outcome = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.syncState = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        farmId = Value(farmId),
        damId = Value(damId),
        sireId = Value(sireId),
        occurredAt = Value(occurredAt);
  static Insertable<BreedingEvent> custom({
    Expression<String>? id,
    Expression<String>? farmId,
    Expression<String>? damId,
    Expression<String>? sireId,
    Expression<DateTime>? occurredAt,
    Expression<String>? eventType,
    Expression<String>? outcome,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? syncState,
    Expression<String>? createdBy,
    Expression<String>? updatedBy,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (farmId != null) 'farm_id': farmId,
      if (damId != null) 'dam_id': damId,
      if (sireId != null) 'sire_id': sireId,
      if (occurredAt != null) 'occurred_at': occurredAt,
      if (eventType != null) 'event_type': eventType,
      if (outcome != null) 'outcome': outcome,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (syncState != null) 'sync_state': syncState,
      if (createdBy != null) 'created_by': createdBy,
      if (updatedBy != null) 'updated_by': updatedBy,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BreedingEventsCompanion copyWith(
      {Value<String>? id,
      Value<String>? farmId,
      Value<String>? damId,
      Value<String>? sireId,
      Value<DateTime>? occurredAt,
      Value<String>? eventType,
      Value<String?>? outcome,
      Value<String>? notes,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<DateTime?>? deletedAt,
      Value<String>? syncState,
      Value<String?>? createdBy,
      Value<String?>? updatedBy,
      Value<int>? rowid}) {
    return BreedingEventsCompanion(
      id: id ?? this.id,
      farmId: farmId ?? this.farmId,
      damId: damId ?? this.damId,
      sireId: sireId ?? this.sireId,
      occurredAt: occurredAt ?? this.occurredAt,
      eventType: eventType ?? this.eventType,
      outcome: outcome ?? this.outcome,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      syncState: syncState ?? this.syncState,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (farmId.present) {
      map['farm_id'] = Variable<String>(farmId.value);
    }
    if (damId.present) {
      map['dam_id'] = Variable<String>(damId.value);
    }
    if (sireId.present) {
      map['sire_id'] = Variable<String>(sireId.value);
    }
    if (occurredAt.present) {
      map['occurred_at'] = Variable<DateTime>(occurredAt.value);
    }
    if (eventType.present) {
      map['event_type'] = Variable<String>(eventType.value);
    }
    if (outcome.present) {
      map['outcome'] = Variable<String>(outcome.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (syncState.present) {
      map['sync_state'] = Variable<String>(syncState.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (updatedBy.present) {
      map['updated_by'] = Variable<String>(updatedBy.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BreedingEventsCompanion(')
          ..write('id: $id, ')
          ..write('farmId: $farmId, ')
          ..write('damId: $damId, ')
          ..write('sireId: $sireId, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('eventType: $eventType, ')
          ..write('outcome: $outcome, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncState: $syncState, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WeighingsTable extends Weighings
    with TableInfo<$WeighingsTable, Weighing> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WeighingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _farmIdMeta = const VerificationMeta('farmId');
  @override
  late final GeneratedColumn<String> farmId = GeneratedColumn<String>(
      'farm_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES farms (id)'));
  static const VerificationMeta _animalIdMeta =
      const VerificationMeta('animalId');
  @override
  late final GeneratedColumn<String> animalId = GeneratedColumn<String>(
      'animal_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES animals (id)'));
  static const VerificationMeta _measuredAtMeta =
      const VerificationMeta('measuredAt');
  @override
  late final GeneratedColumn<DateTime> measuredAt = GeneratedColumn<DateTime>(
      'measured_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _weightKgMeta =
      const VerificationMeta('weightKg');
  @override
  late final GeneratedColumn<double> weightKg = GeneratedColumn<double>(
      'weight_kg', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: DateTime.now);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: DateTime.now);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _syncStateMeta =
      const VerificationMeta('syncState');
  @override
  late final GeneratedColumn<String> syncState = GeneratedColumn<String>(
      'sync_state', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _createdByMeta =
      const VerificationMeta('createdBy');
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
      'created_by', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _updatedByMeta =
      const VerificationMeta('updatedBy');
  @override
  late final GeneratedColumn<String> updatedBy = GeneratedColumn<String>(
      'updated_by', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        farmId,
        animalId,
        measuredAt,
        weightKg,
        notes,
        createdAt,
        updatedAt,
        deletedAt,
        syncState,
        createdBy,
        updatedBy
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'weighings';
  @override
  VerificationContext validateIntegrity(Insertable<Weighing> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('farm_id')) {
      context.handle(_farmIdMeta,
          farmId.isAcceptableOrUnknown(data['farm_id']!, _farmIdMeta));
    } else if (isInserting) {
      context.missing(_farmIdMeta);
    }
    if (data.containsKey('animal_id')) {
      context.handle(_animalIdMeta,
          animalId.isAcceptableOrUnknown(data['animal_id']!, _animalIdMeta));
    } else if (isInserting) {
      context.missing(_animalIdMeta);
    }
    if (data.containsKey('measured_at')) {
      context.handle(
          _measuredAtMeta,
          measuredAt.isAcceptableOrUnknown(
              data['measured_at']!, _measuredAtMeta));
    } else if (isInserting) {
      context.missing(_measuredAtMeta);
    }
    if (data.containsKey('weight_kg')) {
      context.handle(_weightKgMeta,
          weightKg.isAcceptableOrUnknown(data['weight_kg']!, _weightKgMeta));
    } else if (isInserting) {
      context.missing(_weightKgMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    if (data.containsKey('sync_state')) {
      context.handle(_syncStateMeta,
          syncState.isAcceptableOrUnknown(data['sync_state']!, _syncStateMeta));
    }
    if (data.containsKey('created_by')) {
      context.handle(_createdByMeta,
          createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta));
    }
    if (data.containsKey('updated_by')) {
      context.handle(_updatedByMeta,
          updatedBy.isAcceptableOrUnknown(data['updated_by']!, _updatedByMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Weighing map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Weighing(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      farmId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}farm_id'])!,
      animalId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}animal_id'])!,
      measuredAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}measured_at'])!,
      weightKg: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}weight_kg'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
      syncState: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_state'])!,
      createdBy: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_by']),
      updatedBy: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}updated_by']),
    );
  }

  @override
  $WeighingsTable createAlias(String alias) {
    return $WeighingsTable(attachedDatabase, alias);
  }
}

class Weighing extends DataClass implements Insertable<Weighing> {
  final String id;
  final String farmId;
  final String animalId;
  final DateTime measuredAt;
  final double weightKg;
  final String notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String syncState;
  final String? createdBy;
  final String? updatedBy;
  const Weighing(
      {required this.id,
      required this.farmId,
      required this.animalId,
      required this.measuredAt,
      required this.weightKg,
      required this.notes,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt,
      required this.syncState,
      this.createdBy,
      this.updatedBy});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['farm_id'] = Variable<String>(farmId);
    map['animal_id'] = Variable<String>(animalId);
    map['measured_at'] = Variable<DateTime>(measuredAt);
    map['weight_kg'] = Variable<double>(weightKg);
    map['notes'] = Variable<String>(notes);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['sync_state'] = Variable<String>(syncState);
    if (!nullToAbsent || createdBy != null) {
      map['created_by'] = Variable<String>(createdBy);
    }
    if (!nullToAbsent || updatedBy != null) {
      map['updated_by'] = Variable<String>(updatedBy);
    }
    return map;
  }

  WeighingsCompanion toCompanion(bool nullToAbsent) {
    return WeighingsCompanion(
      id: Value(id),
      farmId: Value(farmId),
      animalId: Value(animalId),
      measuredAt: Value(measuredAt),
      weightKg: Value(weightKg),
      notes: Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      syncState: Value(syncState),
      createdBy: createdBy == null && nullToAbsent
          ? const Value.absent()
          : Value(createdBy),
      updatedBy: updatedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedBy),
    );
  }

  factory Weighing.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Weighing(
      id: serializer.fromJson<String>(json['id']),
      farmId: serializer.fromJson<String>(json['farmId']),
      animalId: serializer.fromJson<String>(json['animalId']),
      measuredAt: serializer.fromJson<DateTime>(json['measuredAt']),
      weightKg: serializer.fromJson<double>(json['weightKg']),
      notes: serializer.fromJson<String>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      syncState: serializer.fromJson<String>(json['syncState']),
      createdBy: serializer.fromJson<String?>(json['createdBy']),
      updatedBy: serializer.fromJson<String?>(json['updatedBy']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'farmId': serializer.toJson<String>(farmId),
      'animalId': serializer.toJson<String>(animalId),
      'measuredAt': serializer.toJson<DateTime>(measuredAt),
      'weightKg': serializer.toJson<double>(weightKg),
      'notes': serializer.toJson<String>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'syncState': serializer.toJson<String>(syncState),
      'createdBy': serializer.toJson<String?>(createdBy),
      'updatedBy': serializer.toJson<String?>(updatedBy),
    };
  }

  Weighing copyWith(
          {String? id,
          String? farmId,
          String? animalId,
          DateTime? measuredAt,
          double? weightKg,
          String? notes,
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<DateTime?> deletedAt = const Value.absent(),
          String? syncState,
          Value<String?> createdBy = const Value.absent(),
          Value<String?> updatedBy = const Value.absent()}) =>
      Weighing(
        id: id ?? this.id,
        farmId: farmId ?? this.farmId,
        animalId: animalId ?? this.animalId,
        measuredAt: measuredAt ?? this.measuredAt,
        weightKg: weightKg ?? this.weightKg,
        notes: notes ?? this.notes,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
        syncState: syncState ?? this.syncState,
        createdBy: createdBy.present ? createdBy.value : this.createdBy,
        updatedBy: updatedBy.present ? updatedBy.value : this.updatedBy,
      );
  Weighing copyWithCompanion(WeighingsCompanion data) {
    return Weighing(
      id: data.id.present ? data.id.value : this.id,
      farmId: data.farmId.present ? data.farmId.value : this.farmId,
      animalId: data.animalId.present ? data.animalId.value : this.animalId,
      measuredAt:
          data.measuredAt.present ? data.measuredAt.value : this.measuredAt,
      weightKg: data.weightKg.present ? data.weightKg.value : this.weightKg,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      syncState: data.syncState.present ? data.syncState.value : this.syncState,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      updatedBy: data.updatedBy.present ? data.updatedBy.value : this.updatedBy,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Weighing(')
          ..write('id: $id, ')
          ..write('farmId: $farmId, ')
          ..write('animalId: $animalId, ')
          ..write('measuredAt: $measuredAt, ')
          ..write('weightKg: $weightKg, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncState: $syncState, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedBy: $updatedBy')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, farmId, animalId, measuredAt, weightKg,
      notes, createdAt, updatedAt, deletedAt, syncState, createdBy, updatedBy);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Weighing &&
          other.id == this.id &&
          other.farmId == this.farmId &&
          other.animalId == this.animalId &&
          other.measuredAt == this.measuredAt &&
          other.weightKg == this.weightKg &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.syncState == this.syncState &&
          other.createdBy == this.createdBy &&
          other.updatedBy == this.updatedBy);
}

class WeighingsCompanion extends UpdateCompanion<Weighing> {
  final Value<String> id;
  final Value<String> farmId;
  final Value<String> animalId;
  final Value<DateTime> measuredAt;
  final Value<double> weightKg;
  final Value<String> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> syncState;
  final Value<String?> createdBy;
  final Value<String?> updatedBy;
  final Value<int> rowid;
  const WeighingsCompanion({
    this.id = const Value.absent(),
    this.farmId = const Value.absent(),
    this.animalId = const Value.absent(),
    this.measuredAt = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.syncState = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WeighingsCompanion.insert({
    required String id,
    required String farmId,
    required String animalId,
    required DateTime measuredAt,
    required double weightKg,
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.syncState = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        farmId = Value(farmId),
        animalId = Value(animalId),
        measuredAt = Value(measuredAt),
        weightKg = Value(weightKg);
  static Insertable<Weighing> custom({
    Expression<String>? id,
    Expression<String>? farmId,
    Expression<String>? animalId,
    Expression<DateTime>? measuredAt,
    Expression<double>? weightKg,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? syncState,
    Expression<String>? createdBy,
    Expression<String>? updatedBy,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (farmId != null) 'farm_id': farmId,
      if (animalId != null) 'animal_id': animalId,
      if (measuredAt != null) 'measured_at': measuredAt,
      if (weightKg != null) 'weight_kg': weightKg,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (syncState != null) 'sync_state': syncState,
      if (createdBy != null) 'created_by': createdBy,
      if (updatedBy != null) 'updated_by': updatedBy,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WeighingsCompanion copyWith(
      {Value<String>? id,
      Value<String>? farmId,
      Value<String>? animalId,
      Value<DateTime>? measuredAt,
      Value<double>? weightKg,
      Value<String>? notes,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<DateTime?>? deletedAt,
      Value<String>? syncState,
      Value<String?>? createdBy,
      Value<String?>? updatedBy,
      Value<int>? rowid}) {
    return WeighingsCompanion(
      id: id ?? this.id,
      farmId: farmId ?? this.farmId,
      animalId: animalId ?? this.animalId,
      measuredAt: measuredAt ?? this.measuredAt,
      weightKg: weightKg ?? this.weightKg,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      syncState: syncState ?? this.syncState,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (farmId.present) {
      map['farm_id'] = Variable<String>(farmId.value);
    }
    if (animalId.present) {
      map['animal_id'] = Variable<String>(animalId.value);
    }
    if (measuredAt.present) {
      map['measured_at'] = Variable<DateTime>(measuredAt.value);
    }
    if (weightKg.present) {
      map['weight_kg'] = Variable<double>(weightKg.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (syncState.present) {
      map['sync_state'] = Variable<String>(syncState.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (updatedBy.present) {
      map['updated_by'] = Variable<String>(updatedBy.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WeighingsCompanion(')
          ..write('id: $id, ')
          ..write('farmId: $farmId, ')
          ..write('animalId: $animalId, ')
          ..write('measuredAt: $measuredAt, ')
          ..write('weightKg: $weightKg, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncState: $syncState, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AnimalEventsTable extends AnimalEvents
    with TableInfo<$AnimalEventsTable, AnimalEvent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AnimalEventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _farmIdMeta = const VerificationMeta('farmId');
  @override
  late final GeneratedColumn<String> farmId = GeneratedColumn<String>(
      'farm_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES farms (id)'));
  static const VerificationMeta _animalIdMeta =
      const VerificationMeta('animalId');
  @override
  late final GeneratedColumn<String> animalId = GeneratedColumn<String>(
      'animal_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES animals (id)'));
  static const VerificationMeta _occurredAtMeta =
      const VerificationMeta('occurredAt');
  @override
  late final GeneratedColumn<DateTime> occurredAt = GeneratedColumn<DateTime>(
      'occurred_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _eventTypeMeta =
      const VerificationMeta('eventType');
  @override
  late final GeneratedColumn<String> eventType = GeneratedColumn<String>(
      'event_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: DateTime.now);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: DateTime.now);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _syncStateMeta =
      const VerificationMeta('syncState');
  @override
  late final GeneratedColumn<String> syncState = GeneratedColumn<String>(
      'sync_state', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _createdByMeta =
      const VerificationMeta('createdBy');
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
      'created_by', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _updatedByMeta =
      const VerificationMeta('updatedBy');
  @override
  late final GeneratedColumn<String> updatedBy = GeneratedColumn<String>(
      'updated_by', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        farmId,
        animalId,
        occurredAt,
        eventType,
        notes,
        createdAt,
        updatedAt,
        deletedAt,
        syncState,
        createdBy,
        updatedBy
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'animal_events';
  @override
  VerificationContext validateIntegrity(Insertable<AnimalEvent> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('farm_id')) {
      context.handle(_farmIdMeta,
          farmId.isAcceptableOrUnknown(data['farm_id']!, _farmIdMeta));
    } else if (isInserting) {
      context.missing(_farmIdMeta);
    }
    if (data.containsKey('animal_id')) {
      context.handle(_animalIdMeta,
          animalId.isAcceptableOrUnknown(data['animal_id']!, _animalIdMeta));
    } else if (isInserting) {
      context.missing(_animalIdMeta);
    }
    if (data.containsKey('occurred_at')) {
      context.handle(
          _occurredAtMeta,
          occurredAt.isAcceptableOrUnknown(
              data['occurred_at']!, _occurredAtMeta));
    } else if (isInserting) {
      context.missing(_occurredAtMeta);
    }
    if (data.containsKey('event_type')) {
      context.handle(_eventTypeMeta,
          eventType.isAcceptableOrUnknown(data['event_type']!, _eventTypeMeta));
    } else if (isInserting) {
      context.missing(_eventTypeMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    if (data.containsKey('sync_state')) {
      context.handle(_syncStateMeta,
          syncState.isAcceptableOrUnknown(data['sync_state']!, _syncStateMeta));
    }
    if (data.containsKey('created_by')) {
      context.handle(_createdByMeta,
          createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta));
    }
    if (data.containsKey('updated_by')) {
      context.handle(_updatedByMeta,
          updatedBy.isAcceptableOrUnknown(data['updated_by']!, _updatedByMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AnimalEvent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AnimalEvent(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      farmId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}farm_id'])!,
      animalId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}animal_id'])!,
      occurredAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}occurred_at'])!,
      eventType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}event_type'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
      syncState: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_state'])!,
      createdBy: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_by']),
      updatedBy: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}updated_by']),
    );
  }

  @override
  $AnimalEventsTable createAlias(String alias) {
    return $AnimalEventsTable(attachedDatabase, alias);
  }
}

class AnimalEvent extends DataClass implements Insertable<AnimalEvent> {
  final String id;
  final String farmId;
  final String animalId;
  final DateTime occurredAt;
  final String eventType;
  final String notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String syncState;
  final String? createdBy;
  final String? updatedBy;
  const AnimalEvent(
      {required this.id,
      required this.farmId,
      required this.animalId,
      required this.occurredAt,
      required this.eventType,
      required this.notes,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt,
      required this.syncState,
      this.createdBy,
      this.updatedBy});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['farm_id'] = Variable<String>(farmId);
    map['animal_id'] = Variable<String>(animalId);
    map['occurred_at'] = Variable<DateTime>(occurredAt);
    map['event_type'] = Variable<String>(eventType);
    map['notes'] = Variable<String>(notes);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['sync_state'] = Variable<String>(syncState);
    if (!nullToAbsent || createdBy != null) {
      map['created_by'] = Variable<String>(createdBy);
    }
    if (!nullToAbsent || updatedBy != null) {
      map['updated_by'] = Variable<String>(updatedBy);
    }
    return map;
  }

  AnimalEventsCompanion toCompanion(bool nullToAbsent) {
    return AnimalEventsCompanion(
      id: Value(id),
      farmId: Value(farmId),
      animalId: Value(animalId),
      occurredAt: Value(occurredAt),
      eventType: Value(eventType),
      notes: Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      syncState: Value(syncState),
      createdBy: createdBy == null && nullToAbsent
          ? const Value.absent()
          : Value(createdBy),
      updatedBy: updatedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedBy),
    );
  }

  factory AnimalEvent.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AnimalEvent(
      id: serializer.fromJson<String>(json['id']),
      farmId: serializer.fromJson<String>(json['farmId']),
      animalId: serializer.fromJson<String>(json['animalId']),
      occurredAt: serializer.fromJson<DateTime>(json['occurredAt']),
      eventType: serializer.fromJson<String>(json['eventType']),
      notes: serializer.fromJson<String>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      syncState: serializer.fromJson<String>(json['syncState']),
      createdBy: serializer.fromJson<String?>(json['createdBy']),
      updatedBy: serializer.fromJson<String?>(json['updatedBy']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'farmId': serializer.toJson<String>(farmId),
      'animalId': serializer.toJson<String>(animalId),
      'occurredAt': serializer.toJson<DateTime>(occurredAt),
      'eventType': serializer.toJson<String>(eventType),
      'notes': serializer.toJson<String>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'syncState': serializer.toJson<String>(syncState),
      'createdBy': serializer.toJson<String?>(createdBy),
      'updatedBy': serializer.toJson<String?>(updatedBy),
    };
  }

  AnimalEvent copyWith(
          {String? id,
          String? farmId,
          String? animalId,
          DateTime? occurredAt,
          String? eventType,
          String? notes,
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<DateTime?> deletedAt = const Value.absent(),
          String? syncState,
          Value<String?> createdBy = const Value.absent(),
          Value<String?> updatedBy = const Value.absent()}) =>
      AnimalEvent(
        id: id ?? this.id,
        farmId: farmId ?? this.farmId,
        animalId: animalId ?? this.animalId,
        occurredAt: occurredAt ?? this.occurredAt,
        eventType: eventType ?? this.eventType,
        notes: notes ?? this.notes,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
        syncState: syncState ?? this.syncState,
        createdBy: createdBy.present ? createdBy.value : this.createdBy,
        updatedBy: updatedBy.present ? updatedBy.value : this.updatedBy,
      );
  AnimalEvent copyWithCompanion(AnimalEventsCompanion data) {
    return AnimalEvent(
      id: data.id.present ? data.id.value : this.id,
      farmId: data.farmId.present ? data.farmId.value : this.farmId,
      animalId: data.animalId.present ? data.animalId.value : this.animalId,
      occurredAt:
          data.occurredAt.present ? data.occurredAt.value : this.occurredAt,
      eventType: data.eventType.present ? data.eventType.value : this.eventType,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      syncState: data.syncState.present ? data.syncState.value : this.syncState,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      updatedBy: data.updatedBy.present ? data.updatedBy.value : this.updatedBy,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AnimalEvent(')
          ..write('id: $id, ')
          ..write('farmId: $farmId, ')
          ..write('animalId: $animalId, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('eventType: $eventType, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncState: $syncState, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedBy: $updatedBy')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, farmId, animalId, occurredAt, eventType,
      notes, createdAt, updatedAt, deletedAt, syncState, createdBy, updatedBy);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AnimalEvent &&
          other.id == this.id &&
          other.farmId == this.farmId &&
          other.animalId == this.animalId &&
          other.occurredAt == this.occurredAt &&
          other.eventType == this.eventType &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.syncState == this.syncState &&
          other.createdBy == this.createdBy &&
          other.updatedBy == this.updatedBy);
}

class AnimalEventsCompanion extends UpdateCompanion<AnimalEvent> {
  final Value<String> id;
  final Value<String> farmId;
  final Value<String> animalId;
  final Value<DateTime> occurredAt;
  final Value<String> eventType;
  final Value<String> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> syncState;
  final Value<String?> createdBy;
  final Value<String?> updatedBy;
  final Value<int> rowid;
  const AnimalEventsCompanion({
    this.id = const Value.absent(),
    this.farmId = const Value.absent(),
    this.animalId = const Value.absent(),
    this.occurredAt = const Value.absent(),
    this.eventType = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.syncState = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AnimalEventsCompanion.insert({
    required String id,
    required String farmId,
    required String animalId,
    required DateTime occurredAt,
    required String eventType,
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.syncState = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        farmId = Value(farmId),
        animalId = Value(animalId),
        occurredAt = Value(occurredAt),
        eventType = Value(eventType);
  static Insertable<AnimalEvent> custom({
    Expression<String>? id,
    Expression<String>? farmId,
    Expression<String>? animalId,
    Expression<DateTime>? occurredAt,
    Expression<String>? eventType,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? syncState,
    Expression<String>? createdBy,
    Expression<String>? updatedBy,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (farmId != null) 'farm_id': farmId,
      if (animalId != null) 'animal_id': animalId,
      if (occurredAt != null) 'occurred_at': occurredAt,
      if (eventType != null) 'event_type': eventType,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (syncState != null) 'sync_state': syncState,
      if (createdBy != null) 'created_by': createdBy,
      if (updatedBy != null) 'updated_by': updatedBy,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AnimalEventsCompanion copyWith(
      {Value<String>? id,
      Value<String>? farmId,
      Value<String>? animalId,
      Value<DateTime>? occurredAt,
      Value<String>? eventType,
      Value<String>? notes,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<DateTime?>? deletedAt,
      Value<String>? syncState,
      Value<String?>? createdBy,
      Value<String?>? updatedBy,
      Value<int>? rowid}) {
    return AnimalEventsCompanion(
      id: id ?? this.id,
      farmId: farmId ?? this.farmId,
      animalId: animalId ?? this.animalId,
      occurredAt: occurredAt ?? this.occurredAt,
      eventType: eventType ?? this.eventType,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      syncState: syncState ?? this.syncState,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (farmId.present) {
      map['farm_id'] = Variable<String>(farmId.value);
    }
    if (animalId.present) {
      map['animal_id'] = Variable<String>(animalId.value);
    }
    if (occurredAt.present) {
      map['occurred_at'] = Variable<DateTime>(occurredAt.value);
    }
    if (eventType.present) {
      map['event_type'] = Variable<String>(eventType.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (syncState.present) {
      map['sync_state'] = Variable<String>(syncState.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (updatedBy.present) {
      map['updated_by'] = Variable<String>(updatedBy.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AnimalEventsCompanion(')
          ..write('id: $id, ')
          ..write('farmId: $farmId, ')
          ..write('animalId: $animalId, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('eventType: $eventType, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncState: $syncState, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncQueueTable extends SyncQueue
    with TableInfo<$SyncQueueTable, SyncQueueData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncQueueTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _farmIdMeta = const VerificationMeta('farmId');
  @override
  late final GeneratedColumn<String> farmId = GeneratedColumn<String>(
      'farm_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES farms (id)'));
  static const VerificationMeta _entityTypeMeta =
      const VerificationMeta('entityType');
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
      'entity_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _entityIdMeta =
      const VerificationMeta('entityId');
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
      'entity_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _operationMeta =
      const VerificationMeta('operation');
  @override
  late final GeneratedColumn<String> operation = GeneratedColumn<String>(
      'operation', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _payloadJsonMeta =
      const VerificationMeta('payloadJson');
  @override
  late final GeneratedColumn<String> payloadJson = GeneratedColumn<String>(
      'payload_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _attemptCountMeta =
      const VerificationMeta('attemptCount');
  @override
  late final GeneratedColumn<int> attemptCount = GeneratedColumn<int>(
      'attempt_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _nextAttemptAtMeta =
      const VerificationMeta('nextAttemptAt');
  @override
  late final GeneratedColumn<DateTime> nextAttemptAt =
      GeneratedColumn<DateTime>('next_attempt_at', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _lastErrorMeta =
      const VerificationMeta('lastError');
  @override
  late final GeneratedColumn<String> lastError = GeneratedColumn<String>(
      'last_error', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: DateTime.now);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        farmId,
        entityType,
        entityId,
        operation,
        payloadJson,
        attemptCount,
        nextAttemptAt,
        lastError,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_queue';
  @override
  VerificationContext validateIntegrity(Insertable<SyncQueueData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('farm_id')) {
      context.handle(_farmIdMeta,
          farmId.isAcceptableOrUnknown(data['farm_id']!, _farmIdMeta));
    } else if (isInserting) {
      context.missing(_farmIdMeta);
    }
    if (data.containsKey('entity_type')) {
      context.handle(
          _entityTypeMeta,
          entityType.isAcceptableOrUnknown(
              data['entity_type']!, _entityTypeMeta));
    } else if (isInserting) {
      context.missing(_entityTypeMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(_entityIdMeta,
          entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta));
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('operation')) {
      context.handle(_operationMeta,
          operation.isAcceptableOrUnknown(data['operation']!, _operationMeta));
    } else if (isInserting) {
      context.missing(_operationMeta);
    }
    if (data.containsKey('payload_json')) {
      context.handle(
          _payloadJsonMeta,
          payloadJson.isAcceptableOrUnknown(
              data['payload_json']!, _payloadJsonMeta));
    } else if (isInserting) {
      context.missing(_payloadJsonMeta);
    }
    if (data.containsKey('attempt_count')) {
      context.handle(
          _attemptCountMeta,
          attemptCount.isAcceptableOrUnknown(
              data['attempt_count']!, _attemptCountMeta));
    }
    if (data.containsKey('next_attempt_at')) {
      context.handle(
          _nextAttemptAtMeta,
          nextAttemptAt.isAcceptableOrUnknown(
              data['next_attempt_at']!, _nextAttemptAtMeta));
    }
    if (data.containsKey('last_error')) {
      context.handle(_lastErrorMeta,
          lastError.isAcceptableOrUnknown(data['last_error']!, _lastErrorMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncQueueData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncQueueData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      farmId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}farm_id'])!,
      entityType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entity_type'])!,
      entityId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entity_id'])!,
      operation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}operation'])!,
      payloadJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payload_json'])!,
      attemptCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}attempt_count'])!,
      nextAttemptAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}next_attempt_at']),
      lastError: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}last_error']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $SyncQueueTable createAlias(String alias) {
    return $SyncQueueTable(attachedDatabase, alias);
  }
}

class SyncQueueData extends DataClass implements Insertable<SyncQueueData> {
  final String id;
  final String farmId;
  final String entityType;
  final String entityId;
  final String operation;
  final String payloadJson;
  final int attemptCount;
  final DateTime? nextAttemptAt;
  final String? lastError;
  final DateTime createdAt;
  const SyncQueueData(
      {required this.id,
      required this.farmId,
      required this.entityType,
      required this.entityId,
      required this.operation,
      required this.payloadJson,
      required this.attemptCount,
      this.nextAttemptAt,
      this.lastError,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['farm_id'] = Variable<String>(farmId);
    map['entity_type'] = Variable<String>(entityType);
    map['entity_id'] = Variable<String>(entityId);
    map['operation'] = Variable<String>(operation);
    map['payload_json'] = Variable<String>(payloadJson);
    map['attempt_count'] = Variable<int>(attemptCount);
    if (!nullToAbsent || nextAttemptAt != null) {
      map['next_attempt_at'] = Variable<DateTime>(nextAttemptAt);
    }
    if (!nullToAbsent || lastError != null) {
      map['last_error'] = Variable<String>(lastError);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SyncQueueCompanion toCompanion(bool nullToAbsent) {
    return SyncQueueCompanion(
      id: Value(id),
      farmId: Value(farmId),
      entityType: Value(entityType),
      entityId: Value(entityId),
      operation: Value(operation),
      payloadJson: Value(payloadJson),
      attemptCount: Value(attemptCount),
      nextAttemptAt: nextAttemptAt == null && nullToAbsent
          ? const Value.absent()
          : Value(nextAttemptAt),
      lastError: lastError == null && nullToAbsent
          ? const Value.absent()
          : Value(lastError),
      createdAt: Value(createdAt),
    );
  }

  factory SyncQueueData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncQueueData(
      id: serializer.fromJson<String>(json['id']),
      farmId: serializer.fromJson<String>(json['farmId']),
      entityType: serializer.fromJson<String>(json['entityType']),
      entityId: serializer.fromJson<String>(json['entityId']),
      operation: serializer.fromJson<String>(json['operation']),
      payloadJson: serializer.fromJson<String>(json['payloadJson']),
      attemptCount: serializer.fromJson<int>(json['attemptCount']),
      nextAttemptAt: serializer.fromJson<DateTime?>(json['nextAttemptAt']),
      lastError: serializer.fromJson<String?>(json['lastError']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'farmId': serializer.toJson<String>(farmId),
      'entityType': serializer.toJson<String>(entityType),
      'entityId': serializer.toJson<String>(entityId),
      'operation': serializer.toJson<String>(operation),
      'payloadJson': serializer.toJson<String>(payloadJson),
      'attemptCount': serializer.toJson<int>(attemptCount),
      'nextAttemptAt': serializer.toJson<DateTime?>(nextAttemptAt),
      'lastError': serializer.toJson<String?>(lastError),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SyncQueueData copyWith(
          {String? id,
          String? farmId,
          String? entityType,
          String? entityId,
          String? operation,
          String? payloadJson,
          int? attemptCount,
          Value<DateTime?> nextAttemptAt = const Value.absent(),
          Value<String?> lastError = const Value.absent(),
          DateTime? createdAt}) =>
      SyncQueueData(
        id: id ?? this.id,
        farmId: farmId ?? this.farmId,
        entityType: entityType ?? this.entityType,
        entityId: entityId ?? this.entityId,
        operation: operation ?? this.operation,
        payloadJson: payloadJson ?? this.payloadJson,
        attemptCount: attemptCount ?? this.attemptCount,
        nextAttemptAt:
            nextAttemptAt.present ? nextAttemptAt.value : this.nextAttemptAt,
        lastError: lastError.present ? lastError.value : this.lastError,
        createdAt: createdAt ?? this.createdAt,
      );
  SyncQueueData copyWithCompanion(SyncQueueCompanion data) {
    return SyncQueueData(
      id: data.id.present ? data.id.value : this.id,
      farmId: data.farmId.present ? data.farmId.value : this.farmId,
      entityType:
          data.entityType.present ? data.entityType.value : this.entityType,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      operation: data.operation.present ? data.operation.value : this.operation,
      payloadJson:
          data.payloadJson.present ? data.payloadJson.value : this.payloadJson,
      attemptCount: data.attemptCount.present
          ? data.attemptCount.value
          : this.attemptCount,
      nextAttemptAt: data.nextAttemptAt.present
          ? data.nextAttemptAt.value
          : this.nextAttemptAt,
      lastError: data.lastError.present ? data.lastError.value : this.lastError,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueData(')
          ..write('id: $id, ')
          ..write('farmId: $farmId, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('operation: $operation, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('attemptCount: $attemptCount, ')
          ..write('nextAttemptAt: $nextAttemptAt, ')
          ..write('lastError: $lastError, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, farmId, entityType, entityId, operation,
      payloadJson, attemptCount, nextAttemptAt, lastError, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncQueueData &&
          other.id == this.id &&
          other.farmId == this.farmId &&
          other.entityType == this.entityType &&
          other.entityId == this.entityId &&
          other.operation == this.operation &&
          other.payloadJson == this.payloadJson &&
          other.attemptCount == this.attemptCount &&
          other.nextAttemptAt == this.nextAttemptAt &&
          other.lastError == this.lastError &&
          other.createdAt == this.createdAt);
}

class SyncQueueCompanion extends UpdateCompanion<SyncQueueData> {
  final Value<String> id;
  final Value<String> farmId;
  final Value<String> entityType;
  final Value<String> entityId;
  final Value<String> operation;
  final Value<String> payloadJson;
  final Value<int> attemptCount;
  final Value<DateTime?> nextAttemptAt;
  final Value<String?> lastError;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const SyncQueueCompanion({
    this.id = const Value.absent(),
    this.farmId = const Value.absent(),
    this.entityType = const Value.absent(),
    this.entityId = const Value.absent(),
    this.operation = const Value.absent(),
    this.payloadJson = const Value.absent(),
    this.attemptCount = const Value.absent(),
    this.nextAttemptAt = const Value.absent(),
    this.lastError = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncQueueCompanion.insert({
    required String id,
    required String farmId,
    required String entityType,
    required String entityId,
    required String operation,
    required String payloadJson,
    this.attemptCount = const Value.absent(),
    this.nextAttemptAt = const Value.absent(),
    this.lastError = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        farmId = Value(farmId),
        entityType = Value(entityType),
        entityId = Value(entityId),
        operation = Value(operation),
        payloadJson = Value(payloadJson);
  static Insertable<SyncQueueData> custom({
    Expression<String>? id,
    Expression<String>? farmId,
    Expression<String>? entityType,
    Expression<String>? entityId,
    Expression<String>? operation,
    Expression<String>? payloadJson,
    Expression<int>? attemptCount,
    Expression<DateTime>? nextAttemptAt,
    Expression<String>? lastError,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (farmId != null) 'farm_id': farmId,
      if (entityType != null) 'entity_type': entityType,
      if (entityId != null) 'entity_id': entityId,
      if (operation != null) 'operation': operation,
      if (payloadJson != null) 'payload_json': payloadJson,
      if (attemptCount != null) 'attempt_count': attemptCount,
      if (nextAttemptAt != null) 'next_attempt_at': nextAttemptAt,
      if (lastError != null) 'last_error': lastError,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncQueueCompanion copyWith(
      {Value<String>? id,
      Value<String>? farmId,
      Value<String>? entityType,
      Value<String>? entityId,
      Value<String>? operation,
      Value<String>? payloadJson,
      Value<int>? attemptCount,
      Value<DateTime?>? nextAttemptAt,
      Value<String?>? lastError,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return SyncQueueCompanion(
      id: id ?? this.id,
      farmId: farmId ?? this.farmId,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      operation: operation ?? this.operation,
      payloadJson: payloadJson ?? this.payloadJson,
      attemptCount: attemptCount ?? this.attemptCount,
      nextAttemptAt: nextAttemptAt ?? this.nextAttemptAt,
      lastError: lastError ?? this.lastError,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (farmId.present) {
      map['farm_id'] = Variable<String>(farmId.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<String>(entityId.value);
    }
    if (operation.present) {
      map['operation'] = Variable<String>(operation.value);
    }
    if (payloadJson.present) {
      map['payload_json'] = Variable<String>(payloadJson.value);
    }
    if (attemptCount.present) {
      map['attempt_count'] = Variable<int>(attemptCount.value);
    }
    if (nextAttemptAt.present) {
      map['next_attempt_at'] = Variable<DateTime>(nextAttemptAt.value);
    }
    if (lastError.present) {
      map['last_error'] = Variable<String>(lastError.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueCompanion(')
          ..write('id: $id, ')
          ..write('farmId: $farmId, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('operation: $operation, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('attemptCount: $attemptCount, ')
          ..write('nextAttemptAt: $nextAttemptAt, ')
          ..write('lastError: $lastError, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, AppSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
      'key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _settingValueMeta =
      const VerificationMeta('settingValue');
  @override
  late final GeneratedColumn<String> settingValue = GeneratedColumn<String>(
      'value', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [key, settingValue];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(Insertable<AppSetting> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
          _keyMeta, key.isAcceptableOrUnknown(data['key']!, _keyMeta));
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _settingValueMeta,
          settingValue.isAcceptableOrUnknown(
              data['value']!, _settingValueMeta));
    } else if (isInserting) {
      context.missing(_settingValueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  AppSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSetting(
      key: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}key'])!,
      settingValue: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value'])!,
    );
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }
}

class AppSetting extends DataClass implements Insertable<AppSetting> {
  final String key;
  final String settingValue;
  const AppSetting({required this.key, required this.settingValue});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(settingValue);
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(
      key: Value(key),
      settingValue: Value(settingValue),
    );
  }

  factory AppSetting.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSetting(
      key: serializer.fromJson<String>(json['key']),
      settingValue: serializer.fromJson<String>(json['settingValue']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'settingValue': serializer.toJson<String>(settingValue),
    };
  }

  AppSetting copyWith({String? key, String? settingValue}) => AppSetting(
        key: key ?? this.key,
        settingValue: settingValue ?? this.settingValue,
      );
  AppSetting copyWithCompanion(AppSettingsCompanion data) {
    return AppSetting(
      key: data.key.present ? data.key.value : this.key,
      settingValue: data.settingValue.present
          ? data.settingValue.value
          : this.settingValue,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSetting(')
          ..write('key: $key, ')
          ..write('settingValue: $settingValue')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, settingValue);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSetting &&
          other.key == this.key &&
          other.settingValue == this.settingValue);
}

class AppSettingsCompanion extends UpdateCompanion<AppSetting> {
  final Value<String> key;
  final Value<String> settingValue;
  final Value<int> rowid;
  const AppSettingsCompanion({
    this.key = const Value.absent(),
    this.settingValue = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    required String key,
    required String settingValue,
    this.rowid = const Value.absent(),
  })  : key = Value(key),
        settingValue = Value(settingValue);
  static Insertable<AppSetting> custom({
    Expression<String>? key,
    Expression<String>? settingValue,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (settingValue != null) 'value': settingValue,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppSettingsCompanion copyWith(
      {Value<String>? key, Value<String>? settingValue, Value<int>? rowid}) {
    return AppSettingsCompanion(
      key: key ?? this.key,
      settingValue: settingValue ?? this.settingValue,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (settingValue.present) {
      map['value'] = Variable<String>(settingValue.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('key: $key, ')
          ..write('settingValue: $settingValue, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $FarmsTable farms = $FarmsTable(this);
  late final $FarmMembersTable farmMembers = $FarmMembersTable(this);
  late final $AnimalsTable animals = $AnimalsTable(this);
  late final $LambingsTable lambings = $LambingsTable(this);
  late final $LambingLambsTable lambingLambs = $LambingLambsTable(this);
  late final $TreatmentsTable treatments = $TreatmentsTable(this);
  late final $BreedingEventsTable breedingEvents = $BreedingEventsTable(this);
  late final $WeighingsTable weighings = $WeighingsTable(this);
  late final $AnimalEventsTable animalEvents = $AnimalEventsTable(this);
  late final $SyncQueueTable syncQueue = $SyncQueueTable(this);
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        farms,
        farmMembers,
        animals,
        lambings,
        lambingLambs,
        treatments,
        breedingEvents,
        weighings,
        animalEvents,
        syncQueue,
        appSettings
      ];
}

typedef $$FarmsTableCreateCompanionBuilder = FarmsCompanion Function({
  required String id,
  required String name,
  Value<String> timezone,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<String> syncState,
  Value<int> rowid,
});
typedef $$FarmsTableUpdateCompanionBuilder = FarmsCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> timezone,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<String> syncState,
  Value<int> rowid,
});

final class $$FarmsTableReferences
    extends BaseReferences<_$AppDatabase, $FarmsTable, Farm> {
  $$FarmsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$FarmMembersTable, List<FarmMember>>
      _farmMembersRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.farmMembers,
              aliasName: 'farms__id__farm_members__farm_id');

  $$FarmMembersTableProcessedTableManager get farmMembersRefs {
    final manager = $$FarmMembersTableTableManager($_db, $_db.farmMembers)
        .filter((f) => f.farmId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_farmMembersRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$AnimalsTable, List<Animal>> _animalsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.animals,
          aliasName: 'farms__id__animals__farm_id');

  $$AnimalsTableProcessedTableManager get animalsRefs {
    final manager = $$AnimalsTableTableManager($_db, $_db.animals)
        .filter((f) => f.farmId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_animalsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$LambingsTable, List<Lambing>> _lambingsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.lambings,
          aliasName: 'farms__id__lambings__farm_id');

  $$LambingsTableProcessedTableManager get lambingsRefs {
    final manager = $$LambingsTableTableManager($_db, $_db.lambings)
        .filter((f) => f.farmId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_lambingsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$LambingLambsTable, List<LambingLamb>>
      _lambingLambsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.lambingLambs,
              aliasName: 'farms__id__lambing_lambs__farm_id');

  $$LambingLambsTableProcessedTableManager get lambingLambsRefs {
    final manager = $$LambingLambsTableTableManager($_db, $_db.lambingLambs)
        .filter((f) => f.farmId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_lambingLambsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$TreatmentsTable, List<Treatment>>
      _treatmentsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.treatments,
              aliasName: 'farms__id__treatments__farm_id');

  $$TreatmentsTableProcessedTableManager get treatmentsRefs {
    final manager = $$TreatmentsTableTableManager($_db, $_db.treatments)
        .filter((f) => f.farmId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_treatmentsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$BreedingEventsTable, List<BreedingEvent>>
      _breedingEventsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.breedingEvents,
              aliasName: 'farms__id__breeding_events__farm_id');

  $$BreedingEventsTableProcessedTableManager get breedingEventsRefs {
    final manager = $$BreedingEventsTableTableManager($_db, $_db.breedingEvents)
        .filter((f) => f.farmId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_breedingEventsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$WeighingsTable, List<Weighing>>
      _weighingsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.weighings,
              aliasName: 'farms__id__weighings__farm_id');

  $$WeighingsTableProcessedTableManager get weighingsRefs {
    final manager = $$WeighingsTableTableManager($_db, $_db.weighings)
        .filter((f) => f.farmId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_weighingsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$AnimalEventsTable, List<AnimalEvent>>
      _animalEventsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.animalEvents,
              aliasName: 'farms__id__animal_events__farm_id');

  $$AnimalEventsTableProcessedTableManager get animalEventsRefs {
    final manager = $$AnimalEventsTableTableManager($_db, $_db.animalEvents)
        .filter((f) => f.farmId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_animalEventsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$SyncQueueTable, List<SyncQueueData>>
      _syncQueueRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.syncQueue,
              aliasName: 'farms__id__sync_queue__farm_id');

  $$SyncQueueTableProcessedTableManager get syncQueueRefs {
    final manager = $$SyncQueueTableTableManager($_db, $_db.syncQueue)
        .filter((f) => f.farmId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_syncQueueRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$FarmsTableFilterComposer extends Composer<_$AppDatabase, $FarmsTable> {
  $$FarmsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get timezone => $composableBuilder(
      column: $table.timezone, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncState => $composableBuilder(
      column: $table.syncState, builder: (column) => ColumnFilters(column));

  Expression<bool> farmMembersRefs(
      Expression<bool> Function($$FarmMembersTableFilterComposer f) f) {
    final $$FarmMembersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.farmMembers,
        getReferencedColumn: (t) => t.farmId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FarmMembersTableFilterComposer(
              $db: $db,
              $table: $db.farmMembers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> animalsRefs(
      Expression<bool> Function($$AnimalsTableFilterComposer f) f) {
    final $$AnimalsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.animals,
        getReferencedColumn: (t) => t.farmId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AnimalsTableFilterComposer(
              $db: $db,
              $table: $db.animals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> lambingsRefs(
      Expression<bool> Function($$LambingsTableFilterComposer f) f) {
    final $$LambingsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.lambings,
        getReferencedColumn: (t) => t.farmId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LambingsTableFilterComposer(
              $db: $db,
              $table: $db.lambings,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> lambingLambsRefs(
      Expression<bool> Function($$LambingLambsTableFilterComposer f) f) {
    final $$LambingLambsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.lambingLambs,
        getReferencedColumn: (t) => t.farmId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LambingLambsTableFilterComposer(
              $db: $db,
              $table: $db.lambingLambs,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> treatmentsRefs(
      Expression<bool> Function($$TreatmentsTableFilterComposer f) f) {
    final $$TreatmentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.treatments,
        getReferencedColumn: (t) => t.farmId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TreatmentsTableFilterComposer(
              $db: $db,
              $table: $db.treatments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> breedingEventsRefs(
      Expression<bool> Function($$BreedingEventsTableFilterComposer f) f) {
    final $$BreedingEventsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.breedingEvents,
        getReferencedColumn: (t) => t.farmId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BreedingEventsTableFilterComposer(
              $db: $db,
              $table: $db.breedingEvents,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> weighingsRefs(
      Expression<bool> Function($$WeighingsTableFilterComposer f) f) {
    final $$WeighingsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.weighings,
        getReferencedColumn: (t) => t.farmId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WeighingsTableFilterComposer(
              $db: $db,
              $table: $db.weighings,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> animalEventsRefs(
      Expression<bool> Function($$AnimalEventsTableFilterComposer f) f) {
    final $$AnimalEventsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.animalEvents,
        getReferencedColumn: (t) => t.farmId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AnimalEventsTableFilterComposer(
              $db: $db,
              $table: $db.animalEvents,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> syncQueueRefs(
      Expression<bool> Function($$SyncQueueTableFilterComposer f) f) {
    final $$SyncQueueTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.syncQueue,
        getReferencedColumn: (t) => t.farmId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SyncQueueTableFilterComposer(
              $db: $db,
              $table: $db.syncQueue,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$FarmsTableOrderingComposer
    extends Composer<_$AppDatabase, $FarmsTable> {
  $$FarmsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get timezone => $composableBuilder(
      column: $table.timezone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncState => $composableBuilder(
      column: $table.syncState, builder: (column) => ColumnOrderings(column));
}

class $$FarmsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FarmsTable> {
  $$FarmsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get timezone =>
      $composableBuilder(column: $table.timezone, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get syncState =>
      $composableBuilder(column: $table.syncState, builder: (column) => column);

  Expression<T> farmMembersRefs<T extends Object>(
      Expression<T> Function($$FarmMembersTableAnnotationComposer a) f) {
    final $$FarmMembersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.farmMembers,
        getReferencedColumn: (t) => t.farmId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FarmMembersTableAnnotationComposer(
              $db: $db,
              $table: $db.farmMembers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> animalsRefs<T extends Object>(
      Expression<T> Function($$AnimalsTableAnnotationComposer a) f) {
    final $$AnimalsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.animals,
        getReferencedColumn: (t) => t.farmId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AnimalsTableAnnotationComposer(
              $db: $db,
              $table: $db.animals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> lambingsRefs<T extends Object>(
      Expression<T> Function($$LambingsTableAnnotationComposer a) f) {
    final $$LambingsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.lambings,
        getReferencedColumn: (t) => t.farmId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LambingsTableAnnotationComposer(
              $db: $db,
              $table: $db.lambings,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> lambingLambsRefs<T extends Object>(
      Expression<T> Function($$LambingLambsTableAnnotationComposer a) f) {
    final $$LambingLambsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.lambingLambs,
        getReferencedColumn: (t) => t.farmId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LambingLambsTableAnnotationComposer(
              $db: $db,
              $table: $db.lambingLambs,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> treatmentsRefs<T extends Object>(
      Expression<T> Function($$TreatmentsTableAnnotationComposer a) f) {
    final $$TreatmentsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.treatments,
        getReferencedColumn: (t) => t.farmId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TreatmentsTableAnnotationComposer(
              $db: $db,
              $table: $db.treatments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> breedingEventsRefs<T extends Object>(
      Expression<T> Function($$BreedingEventsTableAnnotationComposer a) f) {
    final $$BreedingEventsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.breedingEvents,
        getReferencedColumn: (t) => t.farmId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BreedingEventsTableAnnotationComposer(
              $db: $db,
              $table: $db.breedingEvents,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> weighingsRefs<T extends Object>(
      Expression<T> Function($$WeighingsTableAnnotationComposer a) f) {
    final $$WeighingsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.weighings,
        getReferencedColumn: (t) => t.farmId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WeighingsTableAnnotationComposer(
              $db: $db,
              $table: $db.weighings,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> animalEventsRefs<T extends Object>(
      Expression<T> Function($$AnimalEventsTableAnnotationComposer a) f) {
    final $$AnimalEventsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.animalEvents,
        getReferencedColumn: (t) => t.farmId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AnimalEventsTableAnnotationComposer(
              $db: $db,
              $table: $db.animalEvents,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> syncQueueRefs<T extends Object>(
      Expression<T> Function($$SyncQueueTableAnnotationComposer a) f) {
    final $$SyncQueueTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.syncQueue,
        getReferencedColumn: (t) => t.farmId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SyncQueueTableAnnotationComposer(
              $db: $db,
              $table: $db.syncQueue,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$FarmsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FarmsTable,
    Farm,
    $$FarmsTableFilterComposer,
    $$FarmsTableOrderingComposer,
    $$FarmsTableAnnotationComposer,
    $$FarmsTableCreateCompanionBuilder,
    $$FarmsTableUpdateCompanionBuilder,
    (Farm, $$FarmsTableReferences),
    Farm,
    PrefetchHooks Function(
        {bool farmMembersRefs,
        bool animalsRefs,
        bool lambingsRefs,
        bool lambingLambsRefs,
        bool treatmentsRefs,
        bool breedingEventsRefs,
        bool weighingsRefs,
        bool animalEventsRefs,
        bool syncQueueRefs})> {
  $$FarmsTableTableManager(_$AppDatabase db, $FarmsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FarmsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FarmsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FarmsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> timezone = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<String> syncState = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FarmsCompanion(
            id: id,
            name: name,
            timezone: timezone,
            createdAt: createdAt,
            updatedAt: updatedAt,
            syncState: syncState,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<String> timezone = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<String> syncState = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FarmsCompanion.insert(
            id: id,
            name: name,
            timezone: timezone,
            createdAt: createdAt,
            updatedAt: updatedAt,
            syncState: syncState,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$FarmsTable, Farm>(table),
                    $$FarmsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {farmMembersRefs = false,
              animalsRefs = false,
              lambingsRefs = false,
              lambingLambsRefs = false,
              treatmentsRefs = false,
              breedingEventsRefs = false,
              weighingsRefs = false,
              animalEventsRefs = false,
              syncQueueRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (farmMembersRefs) db.farmMembers,
                if (animalsRefs) db.animals,
                if (lambingsRefs) db.lambings,
                if (lambingLambsRefs) db.lambingLambs,
                if (treatmentsRefs) db.treatments,
                if (breedingEventsRefs) db.breedingEvents,
                if (weighingsRefs) db.weighings,
                if (animalEventsRefs) db.animalEvents,
                if (syncQueueRefs) db.syncQueue
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (farmMembersRefs)
                    await $_getPrefetchedData<Farm, $FarmsTable, FarmMember>(
                        currentTable: table,
                        referencedTable:
                            $$FarmsTableReferences._farmMembersRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$FarmsTableReferences(db, table, p0)
                                .farmMembersRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.farmId == item.id),
                        typedResults: items),
                  if (animalsRefs)
                    await $_getPrefetchedData<Farm, $FarmsTable, Animal>(
                        currentTable: table,
                        referencedTable:
                            $$FarmsTableReferences._animalsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$FarmsTableReferences(db, table, p0).animalsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.farmId == item.id),
                        typedResults: items),
                  if (lambingsRefs)
                    await $_getPrefetchedData<Farm, $FarmsTable, Lambing>(
                        currentTable: table,
                        referencedTable:
                            $$FarmsTableReferences._lambingsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$FarmsTableReferences(db, table, p0).lambingsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.farmId == item.id),
                        typedResults: items),
                  if (lambingLambsRefs)
                    await $_getPrefetchedData<Farm, $FarmsTable, LambingLamb>(
                        currentTable: table,
                        referencedTable:
                            $$FarmsTableReferences._lambingLambsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$FarmsTableReferences(db, table, p0)
                                .lambingLambsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.farmId == item.id),
                        typedResults: items),
                  if (treatmentsRefs)
                    await $_getPrefetchedData<Farm, $FarmsTable, Treatment>(
                        currentTable: table,
                        referencedTable:
                            $$FarmsTableReferences._treatmentsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$FarmsTableReferences(db, table, p0)
                                .treatmentsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.farmId == item.id),
                        typedResults: items),
                  if (breedingEventsRefs)
                    await $_getPrefetchedData<Farm, $FarmsTable, BreedingEvent>(
                        currentTable: table,
                        referencedTable:
                            $$FarmsTableReferences._breedingEventsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$FarmsTableReferences(db, table, p0)
                                .breedingEventsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.farmId == item.id),
                        typedResults: items),
                  if (weighingsRefs)
                    await $_getPrefetchedData<Farm, $FarmsTable, Weighing>(
                        currentTable: table,
                        referencedTable:
                            $$FarmsTableReferences._weighingsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$FarmsTableReferences(db, table, p0).weighingsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.farmId == item.id),
                        typedResults: items),
                  if (animalEventsRefs)
                    await $_getPrefetchedData<Farm, $FarmsTable, AnimalEvent>(
                        currentTable: table,
                        referencedTable:
                            $$FarmsTableReferences._animalEventsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$FarmsTableReferences(db, table, p0)
                                .animalEventsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.farmId == item.id),
                        typedResults: items),
                  if (syncQueueRefs)
                    await $_getPrefetchedData<Farm, $FarmsTable, SyncQueueData>(
                        currentTable: table,
                        referencedTable:
                            $$FarmsTableReferences._syncQueueRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$FarmsTableReferences(db, table, p0).syncQueueRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.farmId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$FarmsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FarmsTable,
    Farm,
    $$FarmsTableFilterComposer,
    $$FarmsTableOrderingComposer,
    $$FarmsTableAnnotationComposer,
    $$FarmsTableCreateCompanionBuilder,
    $$FarmsTableUpdateCompanionBuilder,
    (Farm, $$FarmsTableReferences),
    Farm,
    PrefetchHooks Function(
        {bool farmMembersRefs,
        bool animalsRefs,
        bool lambingsRefs,
        bool lambingLambsRefs,
        bool treatmentsRefs,
        bool breedingEventsRefs,
        bool weighingsRefs,
        bool animalEventsRefs,
        bool syncQueueRefs})>;
typedef $$FarmMembersTableCreateCompanionBuilder = FarmMembersCompanion
    Function({
  required String id,
  required String farmId,
  required String userId,
  required String role,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$FarmMembersTableUpdateCompanionBuilder = FarmMembersCompanion
    Function({
  Value<String> id,
  Value<String> farmId,
  Value<String> userId,
  Value<String> role,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$FarmMembersTableReferences
    extends BaseReferences<_$AppDatabase, $FarmMembersTable, FarmMember> {
  $$FarmMembersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $FarmsTable _farmIdTable(_$AppDatabase db) =>
      db.farms.createAlias('farm_members__farm_id__farms__id');

  $$FarmsTableProcessedTableManager get farmId {
    final $_column = $_itemColumn<String>('farm_id')!;

    final manager = $$FarmsTableTableManager($_db, $_db.farms)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_farmIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$FarmMembersTableFilterComposer
    extends Composer<_$AppDatabase, $FarmMembersTable> {
  $$FarmMembersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$FarmsTableFilterComposer get farmId {
    final $$FarmsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.farmId,
        referencedTable: $db.farms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FarmsTableFilterComposer(
              $db: $db,
              $table: $db.farms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FarmMembersTableOrderingComposer
    extends Composer<_$AppDatabase, $FarmMembersTable> {
  $$FarmMembersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$FarmsTableOrderingComposer get farmId {
    final $$FarmsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.farmId,
        referencedTable: $db.farms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FarmsTableOrderingComposer(
              $db: $db,
              $table: $db.farms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FarmMembersTableAnnotationComposer
    extends Composer<_$AppDatabase, $FarmMembersTable> {
  $$FarmMembersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$FarmsTableAnnotationComposer get farmId {
    final $$FarmsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.farmId,
        referencedTable: $db.farms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FarmsTableAnnotationComposer(
              $db: $db,
              $table: $db.farms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FarmMembersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FarmMembersTable,
    FarmMember,
    $$FarmMembersTableFilterComposer,
    $$FarmMembersTableOrderingComposer,
    $$FarmMembersTableAnnotationComposer,
    $$FarmMembersTableCreateCompanionBuilder,
    $$FarmMembersTableUpdateCompanionBuilder,
    (FarmMember, $$FarmMembersTableReferences),
    FarmMember,
    PrefetchHooks Function({bool farmId})> {
  $$FarmMembersTableTableManager(_$AppDatabase db, $FarmMembersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FarmMembersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FarmMembersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FarmMembersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> farmId = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<String> role = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FarmMembersCompanion(
            id: id,
            farmId: farmId,
            userId: userId,
            role: role,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String farmId,
            required String userId,
            required String role,
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FarmMembersCompanion.insert(
            id: id,
            farmId: farmId,
            userId: userId,
            role: role,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$FarmMembersTable, FarmMember>(table),
                    $$FarmMembersTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({farmId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (farmId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.farmId,
                    referencedTable:
                        $$FarmMembersTableReferences._farmIdTable(db),
                    referencedColumn:
                        $$FarmMembersTableReferences._farmIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$FarmMembersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FarmMembersTable,
    FarmMember,
    $$FarmMembersTableFilterComposer,
    $$FarmMembersTableOrderingComposer,
    $$FarmMembersTableAnnotationComposer,
    $$FarmMembersTableCreateCompanionBuilder,
    $$FarmMembersTableUpdateCompanionBuilder,
    (FarmMember, $$FarmMembersTableReferences),
    FarmMember,
    PrefetchHooks Function({bool farmId})>;
typedef $$AnimalsTableCreateCompanionBuilder = AnimalsCompanion Function({
  required String id,
  required String farmId,
  required String name,
  Value<String?> internalNumber,
  required String sex,
  required String breed,
  required String earTag,
  Value<String> mark,
  Value<String?> earMarks,
  Value<DateTime?> birthDate,
  Value<String?> damId,
  Value<String?> sireId,
  Value<String> origin,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<String> status,
  Value<DateTime?> deletedAt,
  Value<String> syncState,
  Value<String?> createdBy,
  Value<String?> updatedBy,
  Value<int> rowid,
});
typedef $$AnimalsTableUpdateCompanionBuilder = AnimalsCompanion Function({
  Value<String> id,
  Value<String> farmId,
  Value<String> name,
  Value<String?> internalNumber,
  Value<String> sex,
  Value<String> breed,
  Value<String> earTag,
  Value<String> mark,
  Value<String?> earMarks,
  Value<DateTime?> birthDate,
  Value<String?> damId,
  Value<String?> sireId,
  Value<String> origin,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<String> status,
  Value<DateTime?> deletedAt,
  Value<String> syncState,
  Value<String?> createdBy,
  Value<String?> updatedBy,
  Value<int> rowid,
});

final class $$AnimalsTableReferences
    extends BaseReferences<_$AppDatabase, $AnimalsTable, Animal> {
  $$AnimalsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $FarmsTable _farmIdTable(_$AppDatabase db) =>
      db.farms.createAlias('animals__farm_id__farms__id');

  $$FarmsTableProcessedTableManager get farmId {
    final $_column = $_itemColumn<String>('farm_id')!;

    final manager = $$FarmsTableTableManager($_db, $_db.farms)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_farmIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $AnimalsTable _damIdTable(_$AppDatabase db) =>
      db.animals.createAlias('animals__dam_id__animals__id');

  $$AnimalsTableProcessedTableManager? get damId {
    final $_column = $_itemColumn<String>('dam_id');
    if ($_column == null) return null;
    final manager = $$AnimalsTableTableManager($_db, $_db.animals)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_damIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $AnimalsTable _sireIdTable(_$AppDatabase db) =>
      db.animals.createAlias('animals__sire_id__animals__id');

  $$AnimalsTableProcessedTableManager? get sireId {
    final $_column = $_itemColumn<String>('sire_id');
    if ($_column == null) return null;
    final manager = $$AnimalsTableTableManager($_db, $_db.animals)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sireIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$LambingLambsTable, List<LambingLamb>>
      _lambingLambsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.lambingLambs,
              aliasName: 'animals__id__lambing_lambs__animal_id');

  $$LambingLambsTableProcessedTableManager get lambingLambsRefs {
    final manager = $$LambingLambsTableTableManager($_db, $_db.lambingLambs)
        .filter((f) => f.animalId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_lambingLambsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$TreatmentsTable, List<Treatment>>
      _treatmentsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.treatments,
              aliasName: 'animals__id__treatments__animal_id');

  $$TreatmentsTableProcessedTableManager get treatmentsRefs {
    final manager = $$TreatmentsTableTableManager($_db, $_db.treatments)
        .filter((f) => f.animalId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_treatmentsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$WeighingsTable, List<Weighing>>
      _weighingsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.weighings,
              aliasName: 'animals__id__weighings__animal_id');

  $$WeighingsTableProcessedTableManager get weighingsRefs {
    final manager = $$WeighingsTableTableManager($_db, $_db.weighings)
        .filter((f) => f.animalId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_weighingsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$AnimalEventsTable, List<AnimalEvent>>
      _animalEventsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.animalEvents,
              aliasName: 'animals__id__animal_events__animal_id');

  $$AnimalEventsTableProcessedTableManager get animalEventsRefs {
    final manager = $$AnimalEventsTableTableManager($_db, $_db.animalEvents)
        .filter((f) => f.animalId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_animalEventsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$AnimalsTableFilterComposer
    extends Composer<_$AppDatabase, $AnimalsTable> {
  $$AnimalsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get internalNumber => $composableBuilder(
      column: $table.internalNumber,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sex => $composableBuilder(
      column: $table.sex, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get breed => $composableBuilder(
      column: $table.breed, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get earTag => $composableBuilder(
      column: $table.earTag, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get mark => $composableBuilder(
      column: $table.mark, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get earMarks => $composableBuilder(
      column: $table.earMarks, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get birthDate => $composableBuilder(
      column: $table.birthDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get origin => $composableBuilder(
      column: $table.origin, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncState => $composableBuilder(
      column: $table.syncState, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdBy => $composableBuilder(
      column: $table.createdBy, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get updatedBy => $composableBuilder(
      column: $table.updatedBy, builder: (column) => ColumnFilters(column));

  $$FarmsTableFilterComposer get farmId {
    final $$FarmsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.farmId,
        referencedTable: $db.farms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FarmsTableFilterComposer(
              $db: $db,
              $table: $db.farms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AnimalsTableFilterComposer get damId {
    final $$AnimalsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.damId,
        referencedTable: $db.animals,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AnimalsTableFilterComposer(
              $db: $db,
              $table: $db.animals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AnimalsTableFilterComposer get sireId {
    final $$AnimalsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sireId,
        referencedTable: $db.animals,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AnimalsTableFilterComposer(
              $db: $db,
              $table: $db.animals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> lambingLambsRefs(
      Expression<bool> Function($$LambingLambsTableFilterComposer f) f) {
    final $$LambingLambsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.lambingLambs,
        getReferencedColumn: (t) => t.animalId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LambingLambsTableFilterComposer(
              $db: $db,
              $table: $db.lambingLambs,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> treatmentsRefs(
      Expression<bool> Function($$TreatmentsTableFilterComposer f) f) {
    final $$TreatmentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.treatments,
        getReferencedColumn: (t) => t.animalId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TreatmentsTableFilterComposer(
              $db: $db,
              $table: $db.treatments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> weighingsRefs(
      Expression<bool> Function($$WeighingsTableFilterComposer f) f) {
    final $$WeighingsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.weighings,
        getReferencedColumn: (t) => t.animalId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WeighingsTableFilterComposer(
              $db: $db,
              $table: $db.weighings,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> animalEventsRefs(
      Expression<bool> Function($$AnimalEventsTableFilterComposer f) f) {
    final $$AnimalEventsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.animalEvents,
        getReferencedColumn: (t) => t.animalId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AnimalEventsTableFilterComposer(
              $db: $db,
              $table: $db.animalEvents,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$AnimalsTableOrderingComposer
    extends Composer<_$AppDatabase, $AnimalsTable> {
  $$AnimalsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get internalNumber => $composableBuilder(
      column: $table.internalNumber,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sex => $composableBuilder(
      column: $table.sex, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get breed => $composableBuilder(
      column: $table.breed, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get earTag => $composableBuilder(
      column: $table.earTag, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get mark => $composableBuilder(
      column: $table.mark, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get earMarks => $composableBuilder(
      column: $table.earMarks, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get birthDate => $composableBuilder(
      column: $table.birthDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get origin => $composableBuilder(
      column: $table.origin, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncState => $composableBuilder(
      column: $table.syncState, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdBy => $composableBuilder(
      column: $table.createdBy, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get updatedBy => $composableBuilder(
      column: $table.updatedBy, builder: (column) => ColumnOrderings(column));

  $$FarmsTableOrderingComposer get farmId {
    final $$FarmsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.farmId,
        referencedTable: $db.farms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FarmsTableOrderingComposer(
              $db: $db,
              $table: $db.farms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AnimalsTableOrderingComposer get damId {
    final $$AnimalsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.damId,
        referencedTable: $db.animals,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AnimalsTableOrderingComposer(
              $db: $db,
              $table: $db.animals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AnimalsTableOrderingComposer get sireId {
    final $$AnimalsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sireId,
        referencedTable: $db.animals,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AnimalsTableOrderingComposer(
              $db: $db,
              $table: $db.animals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AnimalsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AnimalsTable> {
  $$AnimalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get internalNumber => $composableBuilder(
      column: $table.internalNumber, builder: (column) => column);

  GeneratedColumn<String> get sex =>
      $composableBuilder(column: $table.sex, builder: (column) => column);

  GeneratedColumn<String> get breed =>
      $composableBuilder(column: $table.breed, builder: (column) => column);

  GeneratedColumn<String> get earTag =>
      $composableBuilder(column: $table.earTag, builder: (column) => column);

  GeneratedColumn<String> get mark =>
      $composableBuilder(column: $table.mark, builder: (column) => column);

  GeneratedColumn<String> get earMarks =>
      $composableBuilder(column: $table.earMarks, builder: (column) => column);

  GeneratedColumn<DateTime> get birthDate =>
      $composableBuilder(column: $table.birthDate, builder: (column) => column);

  GeneratedColumn<String> get origin =>
      $composableBuilder(column: $table.origin, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get syncState =>
      $composableBuilder(column: $table.syncState, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<String> get updatedBy =>
      $composableBuilder(column: $table.updatedBy, builder: (column) => column);

  $$FarmsTableAnnotationComposer get farmId {
    final $$FarmsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.farmId,
        referencedTable: $db.farms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FarmsTableAnnotationComposer(
              $db: $db,
              $table: $db.farms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AnimalsTableAnnotationComposer get damId {
    final $$AnimalsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.damId,
        referencedTable: $db.animals,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AnimalsTableAnnotationComposer(
              $db: $db,
              $table: $db.animals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AnimalsTableAnnotationComposer get sireId {
    final $$AnimalsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sireId,
        referencedTable: $db.animals,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AnimalsTableAnnotationComposer(
              $db: $db,
              $table: $db.animals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> lambingLambsRefs<T extends Object>(
      Expression<T> Function($$LambingLambsTableAnnotationComposer a) f) {
    final $$LambingLambsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.lambingLambs,
        getReferencedColumn: (t) => t.animalId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LambingLambsTableAnnotationComposer(
              $db: $db,
              $table: $db.lambingLambs,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> treatmentsRefs<T extends Object>(
      Expression<T> Function($$TreatmentsTableAnnotationComposer a) f) {
    final $$TreatmentsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.treatments,
        getReferencedColumn: (t) => t.animalId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TreatmentsTableAnnotationComposer(
              $db: $db,
              $table: $db.treatments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> weighingsRefs<T extends Object>(
      Expression<T> Function($$WeighingsTableAnnotationComposer a) f) {
    final $$WeighingsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.weighings,
        getReferencedColumn: (t) => t.animalId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WeighingsTableAnnotationComposer(
              $db: $db,
              $table: $db.weighings,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> animalEventsRefs<T extends Object>(
      Expression<T> Function($$AnimalEventsTableAnnotationComposer a) f) {
    final $$AnimalEventsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.animalEvents,
        getReferencedColumn: (t) => t.animalId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AnimalEventsTableAnnotationComposer(
              $db: $db,
              $table: $db.animalEvents,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$AnimalsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AnimalsTable,
    Animal,
    $$AnimalsTableFilterComposer,
    $$AnimalsTableOrderingComposer,
    $$AnimalsTableAnnotationComposer,
    $$AnimalsTableCreateCompanionBuilder,
    $$AnimalsTableUpdateCompanionBuilder,
    (Animal, $$AnimalsTableReferences),
    Animal,
    PrefetchHooks Function(
        {bool farmId,
        bool damId,
        bool sireId,
        bool lambingLambsRefs,
        bool treatmentsRefs,
        bool weighingsRefs,
        bool animalEventsRefs})> {
  $$AnimalsTableTableManager(_$AppDatabase db, $AnimalsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AnimalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AnimalsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AnimalsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> farmId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> internalNumber = const Value.absent(),
            Value<String> sex = const Value.absent(),
            Value<String> breed = const Value.absent(),
            Value<String> earTag = const Value.absent(),
            Value<String> mark = const Value.absent(),
            Value<String?> earMarks = const Value.absent(),
            Value<DateTime?> birthDate = const Value.absent(),
            Value<String?> damId = const Value.absent(),
            Value<String?> sireId = const Value.absent(),
            Value<String> origin = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<String> syncState = const Value.absent(),
            Value<String?> createdBy = const Value.absent(),
            Value<String?> updatedBy = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AnimalsCompanion(
            id: id,
            farmId: farmId,
            name: name,
            internalNumber: internalNumber,
            sex: sex,
            breed: breed,
            earTag: earTag,
            mark: mark,
            earMarks: earMarks,
            birthDate: birthDate,
            damId: damId,
            sireId: sireId,
            origin: origin,
            createdAt: createdAt,
            updatedAt: updatedAt,
            status: status,
            deletedAt: deletedAt,
            syncState: syncState,
            createdBy: createdBy,
            updatedBy: updatedBy,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String farmId,
            required String name,
            Value<String?> internalNumber = const Value.absent(),
            required String sex,
            required String breed,
            required String earTag,
            Value<String> mark = const Value.absent(),
            Value<String?> earMarks = const Value.absent(),
            Value<DateTime?> birthDate = const Value.absent(),
            Value<String?> damId = const Value.absent(),
            Value<String?> sireId = const Value.absent(),
            Value<String> origin = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<String> syncState = const Value.absent(),
            Value<String?> createdBy = const Value.absent(),
            Value<String?> updatedBy = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AnimalsCompanion.insert(
            id: id,
            farmId: farmId,
            name: name,
            internalNumber: internalNumber,
            sex: sex,
            breed: breed,
            earTag: earTag,
            mark: mark,
            earMarks: earMarks,
            birthDate: birthDate,
            damId: damId,
            sireId: sireId,
            origin: origin,
            createdAt: createdAt,
            updatedAt: updatedAt,
            status: status,
            deletedAt: deletedAt,
            syncState: syncState,
            createdBy: createdBy,
            updatedBy: updatedBy,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$AnimalsTable, Animal>(table),
                    $$AnimalsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {farmId = false,
              damId = false,
              sireId = false,
              lambingLambsRefs = false,
              treatmentsRefs = false,
              weighingsRefs = false,
              animalEventsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (lambingLambsRefs) db.lambingLambs,
                if (treatmentsRefs) db.treatments,
                if (weighingsRefs) db.weighings,
                if (animalEventsRefs) db.animalEvents
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (farmId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.farmId,
                    referencedTable: $$AnimalsTableReferences._farmIdTable(db),
                    referencedColumn:
                        $$AnimalsTableReferences._farmIdTable(db).id,
                  ) as T;
                }
                if (damId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.damId,
                    referencedTable: $$AnimalsTableReferences._damIdTable(db),
                    referencedColumn:
                        $$AnimalsTableReferences._damIdTable(db).id,
                  ) as T;
                }
                if (sireId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.sireId,
                    referencedTable: $$AnimalsTableReferences._sireIdTable(db),
                    referencedColumn:
                        $$AnimalsTableReferences._sireIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (lambingLambsRefs)
                    await $_getPrefetchedData<Animal, $AnimalsTable,
                            LambingLamb>(
                        currentTable: table,
                        referencedTable:
                            $$AnimalsTableReferences._lambingLambsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$AnimalsTableReferences(db, table, p0)
                                .lambingLambsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.animalId == item.id),
                        typedResults: items),
                  if (treatmentsRefs)
                    await $_getPrefetchedData<Animal, $AnimalsTable, Treatment>(
                        currentTable: table,
                        referencedTable:
                            $$AnimalsTableReferences._treatmentsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$AnimalsTableReferences(db, table, p0)
                                .treatmentsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.animalId == item.id),
                        typedResults: items),
                  if (weighingsRefs)
                    await $_getPrefetchedData<Animal, $AnimalsTable, Weighing>(
                        currentTable: table,
                        referencedTable:
                            $$AnimalsTableReferences._weighingsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$AnimalsTableReferences(db, table, p0)
                                .weighingsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.animalId == item.id),
                        typedResults: items),
                  if (animalEventsRefs)
                    await $_getPrefetchedData<Animal, $AnimalsTable,
                            AnimalEvent>(
                        currentTable: table,
                        referencedTable:
                            $$AnimalsTableReferences._animalEventsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$AnimalsTableReferences(db, table, p0)
                                .animalEventsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.animalId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$AnimalsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AnimalsTable,
    Animal,
    $$AnimalsTableFilterComposer,
    $$AnimalsTableOrderingComposer,
    $$AnimalsTableAnnotationComposer,
    $$AnimalsTableCreateCompanionBuilder,
    $$AnimalsTableUpdateCompanionBuilder,
    (Animal, $$AnimalsTableReferences),
    Animal,
    PrefetchHooks Function(
        {bool farmId,
        bool damId,
        bool sireId,
        bool lambingLambsRefs,
        bool treatmentsRefs,
        bool weighingsRefs,
        bool animalEventsRefs})>;
typedef $$LambingsTableCreateCompanionBuilder = LambingsCompanion Function({
  required String id,
  required String farmId,
  required String damId,
  Value<String?> sireId,
  required DateTime occurredAt,
  Value<String> birthType,
  Value<String> notes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<String> syncState,
  Value<String?> createdBy,
  Value<String?> updatedBy,
  Value<int> rowid,
});
typedef $$LambingsTableUpdateCompanionBuilder = LambingsCompanion Function({
  Value<String> id,
  Value<String> farmId,
  Value<String> damId,
  Value<String?> sireId,
  Value<DateTime> occurredAt,
  Value<String> birthType,
  Value<String> notes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<String> syncState,
  Value<String?> createdBy,
  Value<String?> updatedBy,
  Value<int> rowid,
});

final class $$LambingsTableReferences
    extends BaseReferences<_$AppDatabase, $LambingsTable, Lambing> {
  $$LambingsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $FarmsTable _farmIdTable(_$AppDatabase db) =>
      db.farms.createAlias('lambings__farm_id__farms__id');

  $$FarmsTableProcessedTableManager get farmId {
    final $_column = $_itemColumn<String>('farm_id')!;

    final manager = $$FarmsTableTableManager($_db, $_db.farms)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_farmIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $AnimalsTable _damIdTable(_$AppDatabase db) =>
      db.animals.createAlias('lambings__dam_id__animals__id');

  $$AnimalsTableProcessedTableManager get damId {
    final $_column = $_itemColumn<String>('dam_id')!;

    final manager = $$AnimalsTableTableManager($_db, $_db.animals)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_damIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $AnimalsTable _sireIdTable(_$AppDatabase db) =>
      db.animals.createAlias('lambings__sire_id__animals__id');

  $$AnimalsTableProcessedTableManager? get sireId {
    final $_column = $_itemColumn<String>('sire_id');
    if ($_column == null) return null;
    final manager = $$AnimalsTableTableManager($_db, $_db.animals)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sireIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$LambingLambsTable, List<LambingLamb>>
      _lambingLambsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.lambingLambs,
              aliasName: 'lambings__id__lambing_lambs__lambing_id');

  $$LambingLambsTableProcessedTableManager get lambingLambsRefs {
    final manager = $$LambingLambsTableTableManager($_db, $_db.lambingLambs)
        .filter((f) => f.lambingId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_lambingLambsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$LambingsTableFilterComposer
    extends Composer<_$AppDatabase, $LambingsTable> {
  $$LambingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get occurredAt => $composableBuilder(
      column: $table.occurredAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get birthType => $composableBuilder(
      column: $table.birthType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncState => $composableBuilder(
      column: $table.syncState, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdBy => $composableBuilder(
      column: $table.createdBy, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get updatedBy => $composableBuilder(
      column: $table.updatedBy, builder: (column) => ColumnFilters(column));

  $$FarmsTableFilterComposer get farmId {
    final $$FarmsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.farmId,
        referencedTable: $db.farms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FarmsTableFilterComposer(
              $db: $db,
              $table: $db.farms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AnimalsTableFilterComposer get damId {
    final $$AnimalsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.damId,
        referencedTable: $db.animals,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AnimalsTableFilterComposer(
              $db: $db,
              $table: $db.animals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AnimalsTableFilterComposer get sireId {
    final $$AnimalsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sireId,
        referencedTable: $db.animals,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AnimalsTableFilterComposer(
              $db: $db,
              $table: $db.animals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> lambingLambsRefs(
      Expression<bool> Function($$LambingLambsTableFilterComposer f) f) {
    final $$LambingLambsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.lambingLambs,
        getReferencedColumn: (t) => t.lambingId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LambingLambsTableFilterComposer(
              $db: $db,
              $table: $db.lambingLambs,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$LambingsTableOrderingComposer
    extends Composer<_$AppDatabase, $LambingsTable> {
  $$LambingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get occurredAt => $composableBuilder(
      column: $table.occurredAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get birthType => $composableBuilder(
      column: $table.birthType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncState => $composableBuilder(
      column: $table.syncState, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdBy => $composableBuilder(
      column: $table.createdBy, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get updatedBy => $composableBuilder(
      column: $table.updatedBy, builder: (column) => ColumnOrderings(column));

  $$FarmsTableOrderingComposer get farmId {
    final $$FarmsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.farmId,
        referencedTable: $db.farms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FarmsTableOrderingComposer(
              $db: $db,
              $table: $db.farms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AnimalsTableOrderingComposer get damId {
    final $$AnimalsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.damId,
        referencedTable: $db.animals,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AnimalsTableOrderingComposer(
              $db: $db,
              $table: $db.animals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AnimalsTableOrderingComposer get sireId {
    final $$AnimalsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sireId,
        referencedTable: $db.animals,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AnimalsTableOrderingComposer(
              $db: $db,
              $table: $db.animals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LambingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LambingsTable> {
  $$LambingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get occurredAt => $composableBuilder(
      column: $table.occurredAt, builder: (column) => column);

  GeneratedColumn<String> get birthType =>
      $composableBuilder(column: $table.birthType, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get syncState =>
      $composableBuilder(column: $table.syncState, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<String> get updatedBy =>
      $composableBuilder(column: $table.updatedBy, builder: (column) => column);

  $$FarmsTableAnnotationComposer get farmId {
    final $$FarmsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.farmId,
        referencedTable: $db.farms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FarmsTableAnnotationComposer(
              $db: $db,
              $table: $db.farms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AnimalsTableAnnotationComposer get damId {
    final $$AnimalsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.damId,
        referencedTable: $db.animals,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AnimalsTableAnnotationComposer(
              $db: $db,
              $table: $db.animals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AnimalsTableAnnotationComposer get sireId {
    final $$AnimalsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sireId,
        referencedTable: $db.animals,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AnimalsTableAnnotationComposer(
              $db: $db,
              $table: $db.animals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> lambingLambsRefs<T extends Object>(
      Expression<T> Function($$LambingLambsTableAnnotationComposer a) f) {
    final $$LambingLambsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.lambingLambs,
        getReferencedColumn: (t) => t.lambingId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LambingLambsTableAnnotationComposer(
              $db: $db,
              $table: $db.lambingLambs,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$LambingsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LambingsTable,
    Lambing,
    $$LambingsTableFilterComposer,
    $$LambingsTableOrderingComposer,
    $$LambingsTableAnnotationComposer,
    $$LambingsTableCreateCompanionBuilder,
    $$LambingsTableUpdateCompanionBuilder,
    (Lambing, $$LambingsTableReferences),
    Lambing,
    PrefetchHooks Function(
        {bool farmId, bool damId, bool sireId, bool lambingLambsRefs})> {
  $$LambingsTableTableManager(_$AppDatabase db, $LambingsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LambingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LambingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LambingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> farmId = const Value.absent(),
            Value<String> damId = const Value.absent(),
            Value<String?> sireId = const Value.absent(),
            Value<DateTime> occurredAt = const Value.absent(),
            Value<String> birthType = const Value.absent(),
            Value<String> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<String> syncState = const Value.absent(),
            Value<String?> createdBy = const Value.absent(),
            Value<String?> updatedBy = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LambingsCompanion(
            id: id,
            farmId: farmId,
            damId: damId,
            sireId: sireId,
            occurredAt: occurredAt,
            birthType: birthType,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            syncState: syncState,
            createdBy: createdBy,
            updatedBy: updatedBy,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String farmId,
            required String damId,
            Value<String?> sireId = const Value.absent(),
            required DateTime occurredAt,
            Value<String> birthType = const Value.absent(),
            Value<String> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<String> syncState = const Value.absent(),
            Value<String?> createdBy = const Value.absent(),
            Value<String?> updatedBy = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LambingsCompanion.insert(
            id: id,
            farmId: farmId,
            damId: damId,
            sireId: sireId,
            occurredAt: occurredAt,
            birthType: birthType,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            syncState: syncState,
            createdBy: createdBy,
            updatedBy: updatedBy,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$LambingsTable, Lambing>(table),
                    $$LambingsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {farmId = false,
              damId = false,
              sireId = false,
              lambingLambsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (lambingLambsRefs) db.lambingLambs],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (farmId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.farmId,
                    referencedTable: $$LambingsTableReferences._farmIdTable(db),
                    referencedColumn:
                        $$LambingsTableReferences._farmIdTable(db).id,
                  ) as T;
                }
                if (damId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.damId,
                    referencedTable: $$LambingsTableReferences._damIdTable(db),
                    referencedColumn:
                        $$LambingsTableReferences._damIdTable(db).id,
                  ) as T;
                }
                if (sireId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.sireId,
                    referencedTable: $$LambingsTableReferences._sireIdTable(db),
                    referencedColumn:
                        $$LambingsTableReferences._sireIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (lambingLambsRefs)
                    await $_getPrefetchedData<Lambing, $LambingsTable,
                            LambingLamb>(
                        currentTable: table,
                        referencedTable: $$LambingsTableReferences
                            ._lambingLambsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$LambingsTableReferences(db, table, p0)
                                .lambingLambsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.lambingId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$LambingsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LambingsTable,
    Lambing,
    $$LambingsTableFilterComposer,
    $$LambingsTableOrderingComposer,
    $$LambingsTableAnnotationComposer,
    $$LambingsTableCreateCompanionBuilder,
    $$LambingsTableUpdateCompanionBuilder,
    (Lambing, $$LambingsTableReferences),
    Lambing,
    PrefetchHooks Function(
        {bool farmId, bool damId, bool sireId, bool lambingLambsRefs})>;
typedef $$LambingLambsTableCreateCompanionBuilder = LambingLambsCompanion
    Function({
  required String id,
  required String farmId,
  required String lambingId,
  required String animalId,
  Value<double?> birthWeightKg,
  Value<String> notes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<String> syncState,
  Value<int> rowid,
});
typedef $$LambingLambsTableUpdateCompanionBuilder = LambingLambsCompanion
    Function({
  Value<String> id,
  Value<String> farmId,
  Value<String> lambingId,
  Value<String> animalId,
  Value<double?> birthWeightKg,
  Value<String> notes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<String> syncState,
  Value<int> rowid,
});

final class $$LambingLambsTableReferences
    extends BaseReferences<_$AppDatabase, $LambingLambsTable, LambingLamb> {
  $$LambingLambsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $FarmsTable _farmIdTable(_$AppDatabase db) =>
      db.farms.createAlias('lambing_lambs__farm_id__farms__id');

  $$FarmsTableProcessedTableManager get farmId {
    final $_column = $_itemColumn<String>('farm_id')!;

    final manager = $$FarmsTableTableManager($_db, $_db.farms)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_farmIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $LambingsTable _lambingIdTable(_$AppDatabase db) =>
      db.lambings.createAlias('lambing_lambs__lambing_id__lambings__id');

  $$LambingsTableProcessedTableManager get lambingId {
    final $_column = $_itemColumn<String>('lambing_id')!;

    final manager = $$LambingsTableTableManager($_db, $_db.lambings)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_lambingIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $AnimalsTable _animalIdTable(_$AppDatabase db) =>
      db.animals.createAlias('lambing_lambs__animal_id__animals__id');

  $$AnimalsTableProcessedTableManager get animalId {
    final $_column = $_itemColumn<String>('animal_id')!;

    final manager = $$AnimalsTableTableManager($_db, $_db.animals)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_animalIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$LambingLambsTableFilterComposer
    extends Composer<_$AppDatabase, $LambingLambsTable> {
  $$LambingLambsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get birthWeightKg => $composableBuilder(
      column: $table.birthWeightKg, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncState => $composableBuilder(
      column: $table.syncState, builder: (column) => ColumnFilters(column));

  $$FarmsTableFilterComposer get farmId {
    final $$FarmsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.farmId,
        referencedTable: $db.farms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FarmsTableFilterComposer(
              $db: $db,
              $table: $db.farms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$LambingsTableFilterComposer get lambingId {
    final $$LambingsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.lambingId,
        referencedTable: $db.lambings,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LambingsTableFilterComposer(
              $db: $db,
              $table: $db.lambings,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AnimalsTableFilterComposer get animalId {
    final $$AnimalsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.animalId,
        referencedTable: $db.animals,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AnimalsTableFilterComposer(
              $db: $db,
              $table: $db.animals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LambingLambsTableOrderingComposer
    extends Composer<_$AppDatabase, $LambingLambsTable> {
  $$LambingLambsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get birthWeightKg => $composableBuilder(
      column: $table.birthWeightKg,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncState => $composableBuilder(
      column: $table.syncState, builder: (column) => ColumnOrderings(column));

  $$FarmsTableOrderingComposer get farmId {
    final $$FarmsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.farmId,
        referencedTable: $db.farms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FarmsTableOrderingComposer(
              $db: $db,
              $table: $db.farms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$LambingsTableOrderingComposer get lambingId {
    final $$LambingsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.lambingId,
        referencedTable: $db.lambings,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LambingsTableOrderingComposer(
              $db: $db,
              $table: $db.lambings,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AnimalsTableOrderingComposer get animalId {
    final $$AnimalsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.animalId,
        referencedTable: $db.animals,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AnimalsTableOrderingComposer(
              $db: $db,
              $table: $db.animals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LambingLambsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LambingLambsTable> {
  $$LambingLambsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get birthWeightKg => $composableBuilder(
      column: $table.birthWeightKg, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get syncState =>
      $composableBuilder(column: $table.syncState, builder: (column) => column);

  $$FarmsTableAnnotationComposer get farmId {
    final $$FarmsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.farmId,
        referencedTable: $db.farms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FarmsTableAnnotationComposer(
              $db: $db,
              $table: $db.farms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$LambingsTableAnnotationComposer get lambingId {
    final $$LambingsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.lambingId,
        referencedTable: $db.lambings,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LambingsTableAnnotationComposer(
              $db: $db,
              $table: $db.lambings,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AnimalsTableAnnotationComposer get animalId {
    final $$AnimalsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.animalId,
        referencedTable: $db.animals,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AnimalsTableAnnotationComposer(
              $db: $db,
              $table: $db.animals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LambingLambsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LambingLambsTable,
    LambingLamb,
    $$LambingLambsTableFilterComposer,
    $$LambingLambsTableOrderingComposer,
    $$LambingLambsTableAnnotationComposer,
    $$LambingLambsTableCreateCompanionBuilder,
    $$LambingLambsTableUpdateCompanionBuilder,
    (LambingLamb, $$LambingLambsTableReferences),
    LambingLamb,
    PrefetchHooks Function({bool farmId, bool lambingId, bool animalId})> {
  $$LambingLambsTableTableManager(_$AppDatabase db, $LambingLambsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LambingLambsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LambingLambsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LambingLambsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> farmId = const Value.absent(),
            Value<String> lambingId = const Value.absent(),
            Value<String> animalId = const Value.absent(),
            Value<double?> birthWeightKg = const Value.absent(),
            Value<String> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<String> syncState = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LambingLambsCompanion(
            id: id,
            farmId: farmId,
            lambingId: lambingId,
            animalId: animalId,
            birthWeightKg: birthWeightKg,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            syncState: syncState,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String farmId,
            required String lambingId,
            required String animalId,
            Value<double?> birthWeightKg = const Value.absent(),
            Value<String> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<String> syncState = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LambingLambsCompanion.insert(
            id: id,
            farmId: farmId,
            lambingId: lambingId,
            animalId: animalId,
            birthWeightKg: birthWeightKg,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            syncState: syncState,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$LambingLambsTable, LambingLamb>(table),
                    $$LambingLambsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {farmId = false, lambingId = false, animalId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (farmId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.farmId,
                    referencedTable:
                        $$LambingLambsTableReferences._farmIdTable(db),
                    referencedColumn:
                        $$LambingLambsTableReferences._farmIdTable(db).id,
                  ) as T;
                }
                if (lambingId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.lambingId,
                    referencedTable:
                        $$LambingLambsTableReferences._lambingIdTable(db),
                    referencedColumn:
                        $$LambingLambsTableReferences._lambingIdTable(db).id,
                  ) as T;
                }
                if (animalId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.animalId,
                    referencedTable:
                        $$LambingLambsTableReferences._animalIdTable(db),
                    referencedColumn:
                        $$LambingLambsTableReferences._animalIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$LambingLambsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LambingLambsTable,
    LambingLamb,
    $$LambingLambsTableFilterComposer,
    $$LambingLambsTableOrderingComposer,
    $$LambingLambsTableAnnotationComposer,
    $$LambingLambsTableCreateCompanionBuilder,
    $$LambingLambsTableUpdateCompanionBuilder,
    (LambingLamb, $$LambingLambsTableReferences),
    LambingLamb,
    PrefetchHooks Function({bool farmId, bool lambingId, bool animalId})>;
typedef $$TreatmentsTableCreateCompanionBuilder = TreatmentsCompanion Function({
  required String id,
  required String farmId,
  required String animalId,
  required String productName,
  Value<String?> activeIngredient,
  Value<double?> doseValue,
  Value<String?> doseUnit,
  Value<String?> administrationRoute,
  required DateTime administeredAt,
  Value<String> reason,
  Value<String> notes,
  Value<String?> administeredBy,
  Value<int?> withdrawalMeatDays,
  Value<int?> withdrawalMilkDays,
  Value<DateTime?> followUpAt,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<String> syncState,
  Value<String?> createdBy,
  Value<String?> updatedBy,
  Value<int> rowid,
});
typedef $$TreatmentsTableUpdateCompanionBuilder = TreatmentsCompanion Function({
  Value<String> id,
  Value<String> farmId,
  Value<String> animalId,
  Value<String> productName,
  Value<String?> activeIngredient,
  Value<double?> doseValue,
  Value<String?> doseUnit,
  Value<String?> administrationRoute,
  Value<DateTime> administeredAt,
  Value<String> reason,
  Value<String> notes,
  Value<String?> administeredBy,
  Value<int?> withdrawalMeatDays,
  Value<int?> withdrawalMilkDays,
  Value<DateTime?> followUpAt,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<String> syncState,
  Value<String?> createdBy,
  Value<String?> updatedBy,
  Value<int> rowid,
});

final class $$TreatmentsTableReferences
    extends BaseReferences<_$AppDatabase, $TreatmentsTable, Treatment> {
  $$TreatmentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $FarmsTable _farmIdTable(_$AppDatabase db) =>
      db.farms.createAlias('treatments__farm_id__farms__id');

  $$FarmsTableProcessedTableManager get farmId {
    final $_column = $_itemColumn<String>('farm_id')!;

    final manager = $$FarmsTableTableManager($_db, $_db.farms)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_farmIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $AnimalsTable _animalIdTable(_$AppDatabase db) =>
      db.animals.createAlias('treatments__animal_id__animals__id');

  $$AnimalsTableProcessedTableManager get animalId {
    final $_column = $_itemColumn<String>('animal_id')!;

    final manager = $$AnimalsTableTableManager($_db, $_db.animals)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_animalIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$TreatmentsTableFilterComposer
    extends Composer<_$AppDatabase, $TreatmentsTable> {
  $$TreatmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get productName => $composableBuilder(
      column: $table.productName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get activeIngredient => $composableBuilder(
      column: $table.activeIngredient,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get doseValue => $composableBuilder(
      column: $table.doseValue, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get doseUnit => $composableBuilder(
      column: $table.doseUnit, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get administrationRoute => $composableBuilder(
      column: $table.administrationRoute,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get administeredAt => $composableBuilder(
      column: $table.administeredAt,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reason => $composableBuilder(
      column: $table.reason, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get administeredBy => $composableBuilder(
      column: $table.administeredBy,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get withdrawalMeatDays => $composableBuilder(
      column: $table.withdrawalMeatDays,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get withdrawalMilkDays => $composableBuilder(
      column: $table.withdrawalMilkDays,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get followUpAt => $composableBuilder(
      column: $table.followUpAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncState => $composableBuilder(
      column: $table.syncState, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdBy => $composableBuilder(
      column: $table.createdBy, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get updatedBy => $composableBuilder(
      column: $table.updatedBy, builder: (column) => ColumnFilters(column));

  $$FarmsTableFilterComposer get farmId {
    final $$FarmsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.farmId,
        referencedTable: $db.farms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FarmsTableFilterComposer(
              $db: $db,
              $table: $db.farms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AnimalsTableFilterComposer get animalId {
    final $$AnimalsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.animalId,
        referencedTable: $db.animals,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AnimalsTableFilterComposer(
              $db: $db,
              $table: $db.animals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TreatmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $TreatmentsTable> {
  $$TreatmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get productName => $composableBuilder(
      column: $table.productName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get activeIngredient => $composableBuilder(
      column: $table.activeIngredient,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get doseValue => $composableBuilder(
      column: $table.doseValue, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get doseUnit => $composableBuilder(
      column: $table.doseUnit, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get administrationRoute => $composableBuilder(
      column: $table.administrationRoute,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get administeredAt => $composableBuilder(
      column: $table.administeredAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reason => $composableBuilder(
      column: $table.reason, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get administeredBy => $composableBuilder(
      column: $table.administeredBy,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get withdrawalMeatDays => $composableBuilder(
      column: $table.withdrawalMeatDays,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get withdrawalMilkDays => $composableBuilder(
      column: $table.withdrawalMilkDays,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get followUpAt => $composableBuilder(
      column: $table.followUpAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncState => $composableBuilder(
      column: $table.syncState, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdBy => $composableBuilder(
      column: $table.createdBy, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get updatedBy => $composableBuilder(
      column: $table.updatedBy, builder: (column) => ColumnOrderings(column));

  $$FarmsTableOrderingComposer get farmId {
    final $$FarmsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.farmId,
        referencedTable: $db.farms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FarmsTableOrderingComposer(
              $db: $db,
              $table: $db.farms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AnimalsTableOrderingComposer get animalId {
    final $$AnimalsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.animalId,
        referencedTable: $db.animals,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AnimalsTableOrderingComposer(
              $db: $db,
              $table: $db.animals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TreatmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TreatmentsTable> {
  $$TreatmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get productName => $composableBuilder(
      column: $table.productName, builder: (column) => column);

  GeneratedColumn<String> get activeIngredient => $composableBuilder(
      column: $table.activeIngredient, builder: (column) => column);

  GeneratedColumn<double> get doseValue =>
      $composableBuilder(column: $table.doseValue, builder: (column) => column);

  GeneratedColumn<String> get doseUnit =>
      $composableBuilder(column: $table.doseUnit, builder: (column) => column);

  GeneratedColumn<String> get administrationRoute => $composableBuilder(
      column: $table.administrationRoute, builder: (column) => column);

  GeneratedColumn<DateTime> get administeredAt => $composableBuilder(
      column: $table.administeredAt, builder: (column) => column);

  GeneratedColumn<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get administeredBy => $composableBuilder(
      column: $table.administeredBy, builder: (column) => column);

  GeneratedColumn<int> get withdrawalMeatDays => $composableBuilder(
      column: $table.withdrawalMeatDays, builder: (column) => column);

  GeneratedColumn<int> get withdrawalMilkDays => $composableBuilder(
      column: $table.withdrawalMilkDays, builder: (column) => column);

  GeneratedColumn<DateTime> get followUpAt => $composableBuilder(
      column: $table.followUpAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get syncState =>
      $composableBuilder(column: $table.syncState, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<String> get updatedBy =>
      $composableBuilder(column: $table.updatedBy, builder: (column) => column);

  $$FarmsTableAnnotationComposer get farmId {
    final $$FarmsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.farmId,
        referencedTable: $db.farms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FarmsTableAnnotationComposer(
              $db: $db,
              $table: $db.farms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AnimalsTableAnnotationComposer get animalId {
    final $$AnimalsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.animalId,
        referencedTable: $db.animals,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AnimalsTableAnnotationComposer(
              $db: $db,
              $table: $db.animals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TreatmentsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TreatmentsTable,
    Treatment,
    $$TreatmentsTableFilterComposer,
    $$TreatmentsTableOrderingComposer,
    $$TreatmentsTableAnnotationComposer,
    $$TreatmentsTableCreateCompanionBuilder,
    $$TreatmentsTableUpdateCompanionBuilder,
    (Treatment, $$TreatmentsTableReferences),
    Treatment,
    PrefetchHooks Function({bool farmId, bool animalId})> {
  $$TreatmentsTableTableManager(_$AppDatabase db, $TreatmentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TreatmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TreatmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TreatmentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> farmId = const Value.absent(),
            Value<String> animalId = const Value.absent(),
            Value<String> productName = const Value.absent(),
            Value<String?> activeIngredient = const Value.absent(),
            Value<double?> doseValue = const Value.absent(),
            Value<String?> doseUnit = const Value.absent(),
            Value<String?> administrationRoute = const Value.absent(),
            Value<DateTime> administeredAt = const Value.absent(),
            Value<String> reason = const Value.absent(),
            Value<String> notes = const Value.absent(),
            Value<String?> administeredBy = const Value.absent(),
            Value<int?> withdrawalMeatDays = const Value.absent(),
            Value<int?> withdrawalMilkDays = const Value.absent(),
            Value<DateTime?> followUpAt = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<String> syncState = const Value.absent(),
            Value<String?> createdBy = const Value.absent(),
            Value<String?> updatedBy = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TreatmentsCompanion(
            id: id,
            farmId: farmId,
            animalId: animalId,
            productName: productName,
            activeIngredient: activeIngredient,
            doseValue: doseValue,
            doseUnit: doseUnit,
            administrationRoute: administrationRoute,
            administeredAt: administeredAt,
            reason: reason,
            notes: notes,
            administeredBy: administeredBy,
            withdrawalMeatDays: withdrawalMeatDays,
            withdrawalMilkDays: withdrawalMilkDays,
            followUpAt: followUpAt,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            syncState: syncState,
            createdBy: createdBy,
            updatedBy: updatedBy,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String farmId,
            required String animalId,
            required String productName,
            Value<String?> activeIngredient = const Value.absent(),
            Value<double?> doseValue = const Value.absent(),
            Value<String?> doseUnit = const Value.absent(),
            Value<String?> administrationRoute = const Value.absent(),
            required DateTime administeredAt,
            Value<String> reason = const Value.absent(),
            Value<String> notes = const Value.absent(),
            Value<String?> administeredBy = const Value.absent(),
            Value<int?> withdrawalMeatDays = const Value.absent(),
            Value<int?> withdrawalMilkDays = const Value.absent(),
            Value<DateTime?> followUpAt = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<String> syncState = const Value.absent(),
            Value<String?> createdBy = const Value.absent(),
            Value<String?> updatedBy = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TreatmentsCompanion.insert(
            id: id,
            farmId: farmId,
            animalId: animalId,
            productName: productName,
            activeIngredient: activeIngredient,
            doseValue: doseValue,
            doseUnit: doseUnit,
            administrationRoute: administrationRoute,
            administeredAt: administeredAt,
            reason: reason,
            notes: notes,
            administeredBy: administeredBy,
            withdrawalMeatDays: withdrawalMeatDays,
            withdrawalMilkDays: withdrawalMilkDays,
            followUpAt: followUpAt,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            syncState: syncState,
            createdBy: createdBy,
            updatedBy: updatedBy,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$TreatmentsTable, Treatment>(table),
                    $$TreatmentsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({farmId = false, animalId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (farmId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.farmId,
                    referencedTable:
                        $$TreatmentsTableReferences._farmIdTable(db),
                    referencedColumn:
                        $$TreatmentsTableReferences._farmIdTable(db).id,
                  ) as T;
                }
                if (animalId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.animalId,
                    referencedTable:
                        $$TreatmentsTableReferences._animalIdTable(db),
                    referencedColumn:
                        $$TreatmentsTableReferences._animalIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$TreatmentsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TreatmentsTable,
    Treatment,
    $$TreatmentsTableFilterComposer,
    $$TreatmentsTableOrderingComposer,
    $$TreatmentsTableAnnotationComposer,
    $$TreatmentsTableCreateCompanionBuilder,
    $$TreatmentsTableUpdateCompanionBuilder,
    (Treatment, $$TreatmentsTableReferences),
    Treatment,
    PrefetchHooks Function({bool farmId, bool animalId})>;
typedef $$BreedingEventsTableCreateCompanionBuilder = BreedingEventsCompanion
    Function({
  required String id,
  required String farmId,
  required String damId,
  required String sireId,
  required DateTime occurredAt,
  Value<String> eventType,
  Value<String?> outcome,
  Value<String> notes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<String> syncState,
  Value<String?> createdBy,
  Value<String?> updatedBy,
  Value<int> rowid,
});
typedef $$BreedingEventsTableUpdateCompanionBuilder = BreedingEventsCompanion
    Function({
  Value<String> id,
  Value<String> farmId,
  Value<String> damId,
  Value<String> sireId,
  Value<DateTime> occurredAt,
  Value<String> eventType,
  Value<String?> outcome,
  Value<String> notes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<String> syncState,
  Value<String?> createdBy,
  Value<String?> updatedBy,
  Value<int> rowid,
});

final class $$BreedingEventsTableReferences
    extends BaseReferences<_$AppDatabase, $BreedingEventsTable, BreedingEvent> {
  $$BreedingEventsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $FarmsTable _farmIdTable(_$AppDatabase db) =>
      db.farms.createAlias('breeding_events__farm_id__farms__id');

  $$FarmsTableProcessedTableManager get farmId {
    final $_column = $_itemColumn<String>('farm_id')!;

    final manager = $$FarmsTableTableManager($_db, $_db.farms)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_farmIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $AnimalsTable _damIdTable(_$AppDatabase db) =>
      db.animals.createAlias('breeding_events__dam_id__animals__id');

  $$AnimalsTableProcessedTableManager get damId {
    final $_column = $_itemColumn<String>('dam_id')!;

    final manager = $$AnimalsTableTableManager($_db, $_db.animals)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_damIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $AnimalsTable _sireIdTable(_$AppDatabase db) =>
      db.animals.createAlias('breeding_events__sire_id__animals__id');

  $$AnimalsTableProcessedTableManager get sireId {
    final $_column = $_itemColumn<String>('sire_id')!;

    final manager = $$AnimalsTableTableManager($_db, $_db.animals)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sireIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$BreedingEventsTableFilterComposer
    extends Composer<_$AppDatabase, $BreedingEventsTable> {
  $$BreedingEventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get occurredAt => $composableBuilder(
      column: $table.occurredAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get eventType => $composableBuilder(
      column: $table.eventType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get outcome => $composableBuilder(
      column: $table.outcome, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncState => $composableBuilder(
      column: $table.syncState, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdBy => $composableBuilder(
      column: $table.createdBy, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get updatedBy => $composableBuilder(
      column: $table.updatedBy, builder: (column) => ColumnFilters(column));

  $$FarmsTableFilterComposer get farmId {
    final $$FarmsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.farmId,
        referencedTable: $db.farms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FarmsTableFilterComposer(
              $db: $db,
              $table: $db.farms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AnimalsTableFilterComposer get damId {
    final $$AnimalsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.damId,
        referencedTable: $db.animals,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AnimalsTableFilterComposer(
              $db: $db,
              $table: $db.animals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AnimalsTableFilterComposer get sireId {
    final $$AnimalsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sireId,
        referencedTable: $db.animals,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AnimalsTableFilterComposer(
              $db: $db,
              $table: $db.animals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BreedingEventsTableOrderingComposer
    extends Composer<_$AppDatabase, $BreedingEventsTable> {
  $$BreedingEventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get occurredAt => $composableBuilder(
      column: $table.occurredAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get eventType => $composableBuilder(
      column: $table.eventType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get outcome => $composableBuilder(
      column: $table.outcome, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncState => $composableBuilder(
      column: $table.syncState, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdBy => $composableBuilder(
      column: $table.createdBy, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get updatedBy => $composableBuilder(
      column: $table.updatedBy, builder: (column) => ColumnOrderings(column));

  $$FarmsTableOrderingComposer get farmId {
    final $$FarmsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.farmId,
        referencedTable: $db.farms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FarmsTableOrderingComposer(
              $db: $db,
              $table: $db.farms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AnimalsTableOrderingComposer get damId {
    final $$AnimalsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.damId,
        referencedTable: $db.animals,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AnimalsTableOrderingComposer(
              $db: $db,
              $table: $db.animals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AnimalsTableOrderingComposer get sireId {
    final $$AnimalsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sireId,
        referencedTable: $db.animals,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AnimalsTableOrderingComposer(
              $db: $db,
              $table: $db.animals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BreedingEventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BreedingEventsTable> {
  $$BreedingEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get occurredAt => $composableBuilder(
      column: $table.occurredAt, builder: (column) => column);

  GeneratedColumn<String> get eventType =>
      $composableBuilder(column: $table.eventType, builder: (column) => column);

  GeneratedColumn<String> get outcome =>
      $composableBuilder(column: $table.outcome, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get syncState =>
      $composableBuilder(column: $table.syncState, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<String> get updatedBy =>
      $composableBuilder(column: $table.updatedBy, builder: (column) => column);

  $$FarmsTableAnnotationComposer get farmId {
    final $$FarmsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.farmId,
        referencedTable: $db.farms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FarmsTableAnnotationComposer(
              $db: $db,
              $table: $db.farms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AnimalsTableAnnotationComposer get damId {
    final $$AnimalsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.damId,
        referencedTable: $db.animals,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AnimalsTableAnnotationComposer(
              $db: $db,
              $table: $db.animals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AnimalsTableAnnotationComposer get sireId {
    final $$AnimalsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sireId,
        referencedTable: $db.animals,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AnimalsTableAnnotationComposer(
              $db: $db,
              $table: $db.animals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BreedingEventsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BreedingEventsTable,
    BreedingEvent,
    $$BreedingEventsTableFilterComposer,
    $$BreedingEventsTableOrderingComposer,
    $$BreedingEventsTableAnnotationComposer,
    $$BreedingEventsTableCreateCompanionBuilder,
    $$BreedingEventsTableUpdateCompanionBuilder,
    (BreedingEvent, $$BreedingEventsTableReferences),
    BreedingEvent,
    PrefetchHooks Function({bool farmId, bool damId, bool sireId})> {
  $$BreedingEventsTableTableManager(
      _$AppDatabase db, $BreedingEventsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BreedingEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BreedingEventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BreedingEventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> farmId = const Value.absent(),
            Value<String> damId = const Value.absent(),
            Value<String> sireId = const Value.absent(),
            Value<DateTime> occurredAt = const Value.absent(),
            Value<String> eventType = const Value.absent(),
            Value<String?> outcome = const Value.absent(),
            Value<String> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<String> syncState = const Value.absent(),
            Value<String?> createdBy = const Value.absent(),
            Value<String?> updatedBy = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              BreedingEventsCompanion(
            id: id,
            farmId: farmId,
            damId: damId,
            sireId: sireId,
            occurredAt: occurredAt,
            eventType: eventType,
            outcome: outcome,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            syncState: syncState,
            createdBy: createdBy,
            updatedBy: updatedBy,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String farmId,
            required String damId,
            required String sireId,
            required DateTime occurredAt,
            Value<String> eventType = const Value.absent(),
            Value<String?> outcome = const Value.absent(),
            Value<String> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<String> syncState = const Value.absent(),
            Value<String?> createdBy = const Value.absent(),
            Value<String?> updatedBy = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              BreedingEventsCompanion.insert(
            id: id,
            farmId: farmId,
            damId: damId,
            sireId: sireId,
            occurredAt: occurredAt,
            eventType: eventType,
            outcome: outcome,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            syncState: syncState,
            createdBy: createdBy,
            updatedBy: updatedBy,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$BreedingEventsTable, BreedingEvent>(table),
                    $$BreedingEventsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {farmId = false, damId = false, sireId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (farmId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.farmId,
                    referencedTable:
                        $$BreedingEventsTableReferences._farmIdTable(db),
                    referencedColumn:
                        $$BreedingEventsTableReferences._farmIdTable(db).id,
                  ) as T;
                }
                if (damId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.damId,
                    referencedTable:
                        $$BreedingEventsTableReferences._damIdTable(db),
                    referencedColumn:
                        $$BreedingEventsTableReferences._damIdTable(db).id,
                  ) as T;
                }
                if (sireId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.sireId,
                    referencedTable:
                        $$BreedingEventsTableReferences._sireIdTable(db),
                    referencedColumn:
                        $$BreedingEventsTableReferences._sireIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$BreedingEventsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $BreedingEventsTable,
    BreedingEvent,
    $$BreedingEventsTableFilterComposer,
    $$BreedingEventsTableOrderingComposer,
    $$BreedingEventsTableAnnotationComposer,
    $$BreedingEventsTableCreateCompanionBuilder,
    $$BreedingEventsTableUpdateCompanionBuilder,
    (BreedingEvent, $$BreedingEventsTableReferences),
    BreedingEvent,
    PrefetchHooks Function({bool farmId, bool damId, bool sireId})>;
typedef $$WeighingsTableCreateCompanionBuilder = WeighingsCompanion Function({
  required String id,
  required String farmId,
  required String animalId,
  required DateTime measuredAt,
  required double weightKg,
  Value<String> notes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<String> syncState,
  Value<String?> createdBy,
  Value<String?> updatedBy,
  Value<int> rowid,
});
typedef $$WeighingsTableUpdateCompanionBuilder = WeighingsCompanion Function({
  Value<String> id,
  Value<String> farmId,
  Value<String> animalId,
  Value<DateTime> measuredAt,
  Value<double> weightKg,
  Value<String> notes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<String> syncState,
  Value<String?> createdBy,
  Value<String?> updatedBy,
  Value<int> rowid,
});

final class $$WeighingsTableReferences
    extends BaseReferences<_$AppDatabase, $WeighingsTable, Weighing> {
  $$WeighingsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $FarmsTable _farmIdTable(_$AppDatabase db) =>
      db.farms.createAlias('weighings__farm_id__farms__id');

  $$FarmsTableProcessedTableManager get farmId {
    final $_column = $_itemColumn<String>('farm_id')!;

    final manager = $$FarmsTableTableManager($_db, $_db.farms)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_farmIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $AnimalsTable _animalIdTable(_$AppDatabase db) =>
      db.animals.createAlias('weighings__animal_id__animals__id');

  $$AnimalsTableProcessedTableManager get animalId {
    final $_column = $_itemColumn<String>('animal_id')!;

    final manager = $$AnimalsTableTableManager($_db, $_db.animals)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_animalIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$WeighingsTableFilterComposer
    extends Composer<_$AppDatabase, $WeighingsTable> {
  $$WeighingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get measuredAt => $composableBuilder(
      column: $table.measuredAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get weightKg => $composableBuilder(
      column: $table.weightKg, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncState => $composableBuilder(
      column: $table.syncState, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdBy => $composableBuilder(
      column: $table.createdBy, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get updatedBy => $composableBuilder(
      column: $table.updatedBy, builder: (column) => ColumnFilters(column));

  $$FarmsTableFilterComposer get farmId {
    final $$FarmsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.farmId,
        referencedTable: $db.farms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FarmsTableFilterComposer(
              $db: $db,
              $table: $db.farms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AnimalsTableFilterComposer get animalId {
    final $$AnimalsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.animalId,
        referencedTable: $db.animals,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AnimalsTableFilterComposer(
              $db: $db,
              $table: $db.animals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WeighingsTableOrderingComposer
    extends Composer<_$AppDatabase, $WeighingsTable> {
  $$WeighingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get measuredAt => $composableBuilder(
      column: $table.measuredAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get weightKg => $composableBuilder(
      column: $table.weightKg, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncState => $composableBuilder(
      column: $table.syncState, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdBy => $composableBuilder(
      column: $table.createdBy, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get updatedBy => $composableBuilder(
      column: $table.updatedBy, builder: (column) => ColumnOrderings(column));

  $$FarmsTableOrderingComposer get farmId {
    final $$FarmsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.farmId,
        referencedTable: $db.farms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FarmsTableOrderingComposer(
              $db: $db,
              $table: $db.farms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AnimalsTableOrderingComposer get animalId {
    final $$AnimalsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.animalId,
        referencedTable: $db.animals,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AnimalsTableOrderingComposer(
              $db: $db,
              $table: $db.animals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WeighingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WeighingsTable> {
  $$WeighingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get measuredAt => $composableBuilder(
      column: $table.measuredAt, builder: (column) => column);

  GeneratedColumn<double> get weightKg =>
      $composableBuilder(column: $table.weightKg, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get syncState =>
      $composableBuilder(column: $table.syncState, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<String> get updatedBy =>
      $composableBuilder(column: $table.updatedBy, builder: (column) => column);

  $$FarmsTableAnnotationComposer get farmId {
    final $$FarmsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.farmId,
        referencedTable: $db.farms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FarmsTableAnnotationComposer(
              $db: $db,
              $table: $db.farms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AnimalsTableAnnotationComposer get animalId {
    final $$AnimalsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.animalId,
        referencedTable: $db.animals,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AnimalsTableAnnotationComposer(
              $db: $db,
              $table: $db.animals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WeighingsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WeighingsTable,
    Weighing,
    $$WeighingsTableFilterComposer,
    $$WeighingsTableOrderingComposer,
    $$WeighingsTableAnnotationComposer,
    $$WeighingsTableCreateCompanionBuilder,
    $$WeighingsTableUpdateCompanionBuilder,
    (Weighing, $$WeighingsTableReferences),
    Weighing,
    PrefetchHooks Function({bool farmId, bool animalId})> {
  $$WeighingsTableTableManager(_$AppDatabase db, $WeighingsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WeighingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WeighingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WeighingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> farmId = const Value.absent(),
            Value<String> animalId = const Value.absent(),
            Value<DateTime> measuredAt = const Value.absent(),
            Value<double> weightKg = const Value.absent(),
            Value<String> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<String> syncState = const Value.absent(),
            Value<String?> createdBy = const Value.absent(),
            Value<String?> updatedBy = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WeighingsCompanion(
            id: id,
            farmId: farmId,
            animalId: animalId,
            measuredAt: measuredAt,
            weightKg: weightKg,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            syncState: syncState,
            createdBy: createdBy,
            updatedBy: updatedBy,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String farmId,
            required String animalId,
            required DateTime measuredAt,
            required double weightKg,
            Value<String> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<String> syncState = const Value.absent(),
            Value<String?> createdBy = const Value.absent(),
            Value<String?> updatedBy = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WeighingsCompanion.insert(
            id: id,
            farmId: farmId,
            animalId: animalId,
            measuredAt: measuredAt,
            weightKg: weightKg,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            syncState: syncState,
            createdBy: createdBy,
            updatedBy: updatedBy,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$WeighingsTable, Weighing>(table),
                    $$WeighingsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({farmId = false, animalId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (farmId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.farmId,
                    referencedTable:
                        $$WeighingsTableReferences._farmIdTable(db),
                    referencedColumn:
                        $$WeighingsTableReferences._farmIdTable(db).id,
                  ) as T;
                }
                if (animalId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.animalId,
                    referencedTable:
                        $$WeighingsTableReferences._animalIdTable(db),
                    referencedColumn:
                        $$WeighingsTableReferences._animalIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$WeighingsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WeighingsTable,
    Weighing,
    $$WeighingsTableFilterComposer,
    $$WeighingsTableOrderingComposer,
    $$WeighingsTableAnnotationComposer,
    $$WeighingsTableCreateCompanionBuilder,
    $$WeighingsTableUpdateCompanionBuilder,
    (Weighing, $$WeighingsTableReferences),
    Weighing,
    PrefetchHooks Function({bool farmId, bool animalId})>;
typedef $$AnimalEventsTableCreateCompanionBuilder = AnimalEventsCompanion
    Function({
  required String id,
  required String farmId,
  required String animalId,
  required DateTime occurredAt,
  required String eventType,
  Value<String> notes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<String> syncState,
  Value<String?> createdBy,
  Value<String?> updatedBy,
  Value<int> rowid,
});
typedef $$AnimalEventsTableUpdateCompanionBuilder = AnimalEventsCompanion
    Function({
  Value<String> id,
  Value<String> farmId,
  Value<String> animalId,
  Value<DateTime> occurredAt,
  Value<String> eventType,
  Value<String> notes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<String> syncState,
  Value<String?> createdBy,
  Value<String?> updatedBy,
  Value<int> rowid,
});

final class $$AnimalEventsTableReferences
    extends BaseReferences<_$AppDatabase, $AnimalEventsTable, AnimalEvent> {
  $$AnimalEventsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $FarmsTable _farmIdTable(_$AppDatabase db) =>
      db.farms.createAlias('animal_events__farm_id__farms__id');

  $$FarmsTableProcessedTableManager get farmId {
    final $_column = $_itemColumn<String>('farm_id')!;

    final manager = $$FarmsTableTableManager($_db, $_db.farms)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_farmIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $AnimalsTable _animalIdTable(_$AppDatabase db) =>
      db.animals.createAlias('animal_events__animal_id__animals__id');

  $$AnimalsTableProcessedTableManager get animalId {
    final $_column = $_itemColumn<String>('animal_id')!;

    final manager = $$AnimalsTableTableManager($_db, $_db.animals)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_animalIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$AnimalEventsTableFilterComposer
    extends Composer<_$AppDatabase, $AnimalEventsTable> {
  $$AnimalEventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get occurredAt => $composableBuilder(
      column: $table.occurredAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get eventType => $composableBuilder(
      column: $table.eventType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncState => $composableBuilder(
      column: $table.syncState, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdBy => $composableBuilder(
      column: $table.createdBy, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get updatedBy => $composableBuilder(
      column: $table.updatedBy, builder: (column) => ColumnFilters(column));

  $$FarmsTableFilterComposer get farmId {
    final $$FarmsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.farmId,
        referencedTable: $db.farms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FarmsTableFilterComposer(
              $db: $db,
              $table: $db.farms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AnimalsTableFilterComposer get animalId {
    final $$AnimalsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.animalId,
        referencedTable: $db.animals,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AnimalsTableFilterComposer(
              $db: $db,
              $table: $db.animals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AnimalEventsTableOrderingComposer
    extends Composer<_$AppDatabase, $AnimalEventsTable> {
  $$AnimalEventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get occurredAt => $composableBuilder(
      column: $table.occurredAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get eventType => $composableBuilder(
      column: $table.eventType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncState => $composableBuilder(
      column: $table.syncState, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdBy => $composableBuilder(
      column: $table.createdBy, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get updatedBy => $composableBuilder(
      column: $table.updatedBy, builder: (column) => ColumnOrderings(column));

  $$FarmsTableOrderingComposer get farmId {
    final $$FarmsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.farmId,
        referencedTable: $db.farms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FarmsTableOrderingComposer(
              $db: $db,
              $table: $db.farms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AnimalsTableOrderingComposer get animalId {
    final $$AnimalsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.animalId,
        referencedTable: $db.animals,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AnimalsTableOrderingComposer(
              $db: $db,
              $table: $db.animals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AnimalEventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AnimalEventsTable> {
  $$AnimalEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get occurredAt => $composableBuilder(
      column: $table.occurredAt, builder: (column) => column);

  GeneratedColumn<String> get eventType =>
      $composableBuilder(column: $table.eventType, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get syncState =>
      $composableBuilder(column: $table.syncState, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<String> get updatedBy =>
      $composableBuilder(column: $table.updatedBy, builder: (column) => column);

  $$FarmsTableAnnotationComposer get farmId {
    final $$FarmsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.farmId,
        referencedTable: $db.farms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FarmsTableAnnotationComposer(
              $db: $db,
              $table: $db.farms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AnimalsTableAnnotationComposer get animalId {
    final $$AnimalsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.animalId,
        referencedTable: $db.animals,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AnimalsTableAnnotationComposer(
              $db: $db,
              $table: $db.animals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AnimalEventsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AnimalEventsTable,
    AnimalEvent,
    $$AnimalEventsTableFilterComposer,
    $$AnimalEventsTableOrderingComposer,
    $$AnimalEventsTableAnnotationComposer,
    $$AnimalEventsTableCreateCompanionBuilder,
    $$AnimalEventsTableUpdateCompanionBuilder,
    (AnimalEvent, $$AnimalEventsTableReferences),
    AnimalEvent,
    PrefetchHooks Function({bool farmId, bool animalId})> {
  $$AnimalEventsTableTableManager(_$AppDatabase db, $AnimalEventsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AnimalEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AnimalEventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AnimalEventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> farmId = const Value.absent(),
            Value<String> animalId = const Value.absent(),
            Value<DateTime> occurredAt = const Value.absent(),
            Value<String> eventType = const Value.absent(),
            Value<String> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<String> syncState = const Value.absent(),
            Value<String?> createdBy = const Value.absent(),
            Value<String?> updatedBy = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AnimalEventsCompanion(
            id: id,
            farmId: farmId,
            animalId: animalId,
            occurredAt: occurredAt,
            eventType: eventType,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            syncState: syncState,
            createdBy: createdBy,
            updatedBy: updatedBy,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String farmId,
            required String animalId,
            required DateTime occurredAt,
            required String eventType,
            Value<String> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<String> syncState = const Value.absent(),
            Value<String?> createdBy = const Value.absent(),
            Value<String?> updatedBy = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AnimalEventsCompanion.insert(
            id: id,
            farmId: farmId,
            animalId: animalId,
            occurredAt: occurredAt,
            eventType: eventType,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            syncState: syncState,
            createdBy: createdBy,
            updatedBy: updatedBy,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$AnimalEventsTable, AnimalEvent>(table),
                    $$AnimalEventsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({farmId = false, animalId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (farmId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.farmId,
                    referencedTable:
                        $$AnimalEventsTableReferences._farmIdTable(db),
                    referencedColumn:
                        $$AnimalEventsTableReferences._farmIdTable(db).id,
                  ) as T;
                }
                if (animalId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.animalId,
                    referencedTable:
                        $$AnimalEventsTableReferences._animalIdTable(db),
                    referencedColumn:
                        $$AnimalEventsTableReferences._animalIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$AnimalEventsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AnimalEventsTable,
    AnimalEvent,
    $$AnimalEventsTableFilterComposer,
    $$AnimalEventsTableOrderingComposer,
    $$AnimalEventsTableAnnotationComposer,
    $$AnimalEventsTableCreateCompanionBuilder,
    $$AnimalEventsTableUpdateCompanionBuilder,
    (AnimalEvent, $$AnimalEventsTableReferences),
    AnimalEvent,
    PrefetchHooks Function({bool farmId, bool animalId})>;
typedef $$SyncQueueTableCreateCompanionBuilder = SyncQueueCompanion Function({
  required String id,
  required String farmId,
  required String entityType,
  required String entityId,
  required String operation,
  required String payloadJson,
  Value<int> attemptCount,
  Value<DateTime?> nextAttemptAt,
  Value<String?> lastError,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$SyncQueueTableUpdateCompanionBuilder = SyncQueueCompanion Function({
  Value<String> id,
  Value<String> farmId,
  Value<String> entityType,
  Value<String> entityId,
  Value<String> operation,
  Value<String> payloadJson,
  Value<int> attemptCount,
  Value<DateTime?> nextAttemptAt,
  Value<String?> lastError,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$SyncQueueTableReferences
    extends BaseReferences<_$AppDatabase, $SyncQueueTable, SyncQueueData> {
  $$SyncQueueTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $FarmsTable _farmIdTable(_$AppDatabase db) =>
      db.farms.createAlias('sync_queue__farm_id__farms__id');

  $$FarmsTableProcessedTableManager get farmId {
    final $_column = $_itemColumn<String>('farm_id')!;

    final manager = $$FarmsTableTableManager($_db, $_db.farms)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_farmIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$SyncQueueTableFilterComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get entityType => $composableBuilder(
      column: $table.entityType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get entityId => $composableBuilder(
      column: $table.entityId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get operation => $composableBuilder(
      column: $table.operation, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get payloadJson => $composableBuilder(
      column: $table.payloadJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get attemptCount => $composableBuilder(
      column: $table.attemptCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get nextAttemptAt => $composableBuilder(
      column: $table.nextAttemptAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastError => $composableBuilder(
      column: $table.lastError, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$FarmsTableFilterComposer get farmId {
    final $$FarmsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.farmId,
        referencedTable: $db.farms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FarmsTableFilterComposer(
              $db: $db,
              $table: $db.farms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SyncQueueTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get entityType => $composableBuilder(
      column: $table.entityType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get entityId => $composableBuilder(
      column: $table.entityId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get operation => $composableBuilder(
      column: $table.operation, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get payloadJson => $composableBuilder(
      column: $table.payloadJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get attemptCount => $composableBuilder(
      column: $table.attemptCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get nextAttemptAt => $composableBuilder(
      column: $table.nextAttemptAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastError => $composableBuilder(
      column: $table.lastError, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$FarmsTableOrderingComposer get farmId {
    final $$FarmsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.farmId,
        referencedTable: $db.farms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FarmsTableOrderingComposer(
              $db: $db,
              $table: $db.farms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SyncQueueTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get entityType => $composableBuilder(
      column: $table.entityType, builder: (column) => column);

  GeneratedColumn<String> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<String> get operation =>
      $composableBuilder(column: $table.operation, builder: (column) => column);

  GeneratedColumn<String> get payloadJson => $composableBuilder(
      column: $table.payloadJson, builder: (column) => column);

  GeneratedColumn<int> get attemptCount => $composableBuilder(
      column: $table.attemptCount, builder: (column) => column);

  GeneratedColumn<DateTime> get nextAttemptAt => $composableBuilder(
      column: $table.nextAttemptAt, builder: (column) => column);

  GeneratedColumn<String> get lastError =>
      $composableBuilder(column: $table.lastError, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$FarmsTableAnnotationComposer get farmId {
    final $$FarmsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.farmId,
        referencedTable: $db.farms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FarmsTableAnnotationComposer(
              $db: $db,
              $table: $db.farms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SyncQueueTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SyncQueueTable,
    SyncQueueData,
    $$SyncQueueTableFilterComposer,
    $$SyncQueueTableOrderingComposer,
    $$SyncQueueTableAnnotationComposer,
    $$SyncQueueTableCreateCompanionBuilder,
    $$SyncQueueTableUpdateCompanionBuilder,
    (SyncQueueData, $$SyncQueueTableReferences),
    SyncQueueData,
    PrefetchHooks Function({bool farmId})> {
  $$SyncQueueTableTableManager(_$AppDatabase db, $SyncQueueTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncQueueTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncQueueTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncQueueTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> farmId = const Value.absent(),
            Value<String> entityType = const Value.absent(),
            Value<String> entityId = const Value.absent(),
            Value<String> operation = const Value.absent(),
            Value<String> payloadJson = const Value.absent(),
            Value<int> attemptCount = const Value.absent(),
            Value<DateTime?> nextAttemptAt = const Value.absent(),
            Value<String?> lastError = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SyncQueueCompanion(
            id: id,
            farmId: farmId,
            entityType: entityType,
            entityId: entityId,
            operation: operation,
            payloadJson: payloadJson,
            attemptCount: attemptCount,
            nextAttemptAt: nextAttemptAt,
            lastError: lastError,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String farmId,
            required String entityType,
            required String entityId,
            required String operation,
            required String payloadJson,
            Value<int> attemptCount = const Value.absent(),
            Value<DateTime?> nextAttemptAt = const Value.absent(),
            Value<String?> lastError = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SyncQueueCompanion.insert(
            id: id,
            farmId: farmId,
            entityType: entityType,
            entityId: entityId,
            operation: operation,
            payloadJson: payloadJson,
            attemptCount: attemptCount,
            nextAttemptAt: nextAttemptAt,
            lastError: lastError,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$SyncQueueTable, SyncQueueData>(table),
                    $$SyncQueueTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({farmId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (farmId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.farmId,
                    referencedTable:
                        $$SyncQueueTableReferences._farmIdTable(db),
                    referencedColumn:
                        $$SyncQueueTableReferences._farmIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$SyncQueueTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SyncQueueTable,
    SyncQueueData,
    $$SyncQueueTableFilterComposer,
    $$SyncQueueTableOrderingComposer,
    $$SyncQueueTableAnnotationComposer,
    $$SyncQueueTableCreateCompanionBuilder,
    $$SyncQueueTableUpdateCompanionBuilder,
    (SyncQueueData, $$SyncQueueTableReferences),
    SyncQueueData,
    PrefetchHooks Function({bool farmId})>;
typedef $$AppSettingsTableCreateCompanionBuilder = AppSettingsCompanion
    Function({
  required String key,
  required String settingValue,
  Value<int> rowid,
});
typedef $$AppSettingsTableUpdateCompanionBuilder = AppSettingsCompanion
    Function({
  Value<String> key,
  Value<String> settingValue,
  Value<int> rowid,
});

class $$AppSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get settingValue => $composableBuilder(
      column: $table.settingValue, builder: (column) => ColumnFilters(column));
}

class $$AppSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get settingValue => $composableBuilder(
      column: $table.settingValue,
      builder: (column) => ColumnOrderings(column));
}

class $$AppSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get settingValue => $composableBuilder(
      column: $table.settingValue, builder: (column) => column);
}

class $$AppSettingsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AppSettingsTable,
    AppSetting,
    $$AppSettingsTableFilterComposer,
    $$AppSettingsTableOrderingComposer,
    $$AppSettingsTableAnnotationComposer,
    $$AppSettingsTableCreateCompanionBuilder,
    $$AppSettingsTableUpdateCompanionBuilder,
    (AppSetting, BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>),
    AppSetting,
    PrefetchHooks Function()> {
  $$AppSettingsTableTableManager(_$AppDatabase db, $AppSettingsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> key = const Value.absent(),
            Value<String> settingValue = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AppSettingsCompanion(
            key: key,
            settingValue: settingValue,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String key,
            required String settingValue,
            Value<int> rowid = const Value.absent(),
          }) =>
              AppSettingsCompanion.insert(
            key: key,
            settingValue: settingValue,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$AppSettingsTable, AppSetting>(table),
                    BaseReferences<_$AppDatabase, $AppSettingsTable,
                        AppSetting>(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AppSettingsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AppSettingsTable,
    AppSetting,
    $$AppSettingsTableFilterComposer,
    $$AppSettingsTableOrderingComposer,
    $$AppSettingsTableAnnotationComposer,
    $$AppSettingsTableCreateCompanionBuilder,
    $$AppSettingsTableUpdateCompanionBuilder,
    (AppSetting, BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>),
    AppSetting,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$FarmsTableTableManager get farms =>
      $$FarmsTableTableManager(_db, _db.farms);
  $$FarmMembersTableTableManager get farmMembers =>
      $$FarmMembersTableTableManager(_db, _db.farmMembers);
  $$AnimalsTableTableManager get animals =>
      $$AnimalsTableTableManager(_db, _db.animals);
  $$LambingsTableTableManager get lambings =>
      $$LambingsTableTableManager(_db, _db.lambings);
  $$LambingLambsTableTableManager get lambingLambs =>
      $$LambingLambsTableTableManager(_db, _db.lambingLambs);
  $$TreatmentsTableTableManager get treatments =>
      $$TreatmentsTableTableManager(_db, _db.treatments);
  $$BreedingEventsTableTableManager get breedingEvents =>
      $$BreedingEventsTableTableManager(_db, _db.breedingEvents);
  $$WeighingsTableTableManager get weighings =>
      $$WeighingsTableTableManager(_db, _db.weighings);
  $$AnimalEventsTableTableManager get animalEvents =>
      $$AnimalEventsTableTableManager(_db, _db.animalEvents);
  $$SyncQueueTableTableManager get syncQueue =>
      $$SyncQueueTableTableManager(_db, _db.syncQueue);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
}
