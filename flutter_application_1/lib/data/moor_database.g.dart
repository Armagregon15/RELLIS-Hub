// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Event extends DataClass implements Insertable<Event> {
  final int event_id;
  final int group_id;
  final String event_name;
  final String event_date;
  final String group_name;
  Event(
      {required this.event_id,
      required this.group_id,
      required this.event_name,
      required this.event_date,
      required this.group_name});
  factory Event.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Event(
      event_id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}event_id'])!,
      group_id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}group_id'])!,
      event_name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}event_name'])!,
      event_date: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}event_date'])!,
      group_name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}group_name'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['event_id'] = Variable<int>(event_id);
    map['group_id'] = Variable<int>(group_id);
    map['event_name'] = Variable<String>(event_name);
    map['event_date'] = Variable<String>(event_date);
    map['group_name'] = Variable<String>(group_name);
    return map;
  }

  EventsCompanion toCompanion(bool nullToAbsent) {
    return EventsCompanion(
      event_id: Value(event_id),
      group_id: Value(group_id),
      event_name: Value(event_name),
      event_date: Value(event_date),
      group_name: Value(group_name),
    );
  }

  factory Event.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Event(
      event_id: serializer.fromJson<int>(json['event_id']),
      group_id: serializer.fromJson<int>(json['group_id']),
      event_name: serializer.fromJson<String>(json['event_name']),
      event_date: serializer.fromJson<String>(json['event_date']),
      group_name: serializer.fromJson<String>(json['group_name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'event_id': serializer.toJson<int>(event_id),
      'group_id': serializer.toJson<int>(group_id),
      'event_name': serializer.toJson<String>(event_name),
      'event_date': serializer.toJson<String>(event_date),
      'group_name': serializer.toJson<String>(group_name),
    };
  }

  Event copyWith(
          {int? event_id,
          int? group_id,
          String? event_name,
          String? event_date,
          String? group_name}) =>
      Event(
        event_id: event_id ?? this.event_id,
        group_id: group_id ?? this.group_id,
        event_name: event_name ?? this.event_name,
        event_date: event_date ?? this.event_date,
        group_name: group_name ?? this.group_name,
      );
  @override
  String toString() {
    return (StringBuffer('Event(')
          ..write('event_id: $event_id, ')
          ..write('group_id: $group_id, ')
          ..write('event_name: $event_name, ')
          ..write('event_date: $event_date, ')
          ..write('group_name: $group_name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(event_id, group_id, event_name, event_date, group_name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Event &&
          other.event_id == this.event_id &&
          other.group_id == this.group_id &&
          other.event_name == this.event_name &&
          other.event_date == this.event_date &&
          other.group_name == this.group_name);
}

class EventsCompanion extends UpdateCompanion<Event> {
  final Value<int> event_id;
  final Value<int> group_id;
  final Value<String> event_name;
  final Value<String> event_date;
  final Value<String> group_name;
  const EventsCompanion({
    this.event_id = const Value.absent(),
    this.group_id = const Value.absent(),
    this.event_name = const Value.absent(),
    this.event_date = const Value.absent(),
    this.group_name = const Value.absent(),
  });
  EventsCompanion.insert({
    this.event_id = const Value.absent(),
    required int group_id,
    required String event_name,
    required String event_date,
    required String group_name,
  })  : group_id = Value(group_id),
        event_name = Value(event_name),
        event_date = Value(event_date),
        group_name = Value(group_name);
  static Insertable<Event> custom({
    Expression<int>? event_id,
    Expression<int>? group_id,
    Expression<String>? event_name,
    Expression<String>? event_date,
    Expression<String>? group_name,
  }) {
    return RawValuesInsertable({
      if (event_id != null) 'event_id': event_id,
      if (group_id != null) 'group_id': group_id,
      if (event_name != null) 'event_name': event_name,
      if (event_date != null) 'event_date': event_date,
      if (group_name != null) 'group_name': group_name,
    });
  }

  EventsCompanion copyWith(
      {Value<int>? event_id,
      Value<int>? group_id,
      Value<String>? event_name,
      Value<String>? event_date,
      Value<String>? group_name}) {
    return EventsCompanion(
      event_id: event_id ?? this.event_id,
      group_id: group_id ?? this.group_id,
      event_name: event_name ?? this.event_name,
      event_date: event_date ?? this.event_date,
      group_name: group_name ?? this.group_name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (event_id.present) {
      map['event_id'] = Variable<int>(event_id.value);
    }
    if (group_id.present) {
      map['group_id'] = Variable<int>(group_id.value);
    }
    if (event_name.present) {
      map['event_name'] = Variable<String>(event_name.value);
    }
    if (event_date.present) {
      map['event_date'] = Variable<String>(event_date.value);
    }
    if (group_name.present) {
      map['group_name'] = Variable<String>(group_name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventsCompanion(')
          ..write('event_id: $event_id, ')
          ..write('group_id: $group_id, ')
          ..write('event_name: $event_name, ')
          ..write('event_date: $event_date, ')
          ..write('group_name: $group_name')
          ..write(')'))
        .toString();
  }
}

class $EventsTable extends Events with TableInfo<$EventsTable, Event> {
  final GeneratedDatabase _db;
  final String? _alias;
  $EventsTable(this._db, [this._alias]);
  final VerificationMeta _event_idMeta = const VerificationMeta('event_id');
  late final GeneratedColumn<int?> event_id = GeneratedColumn<int?>(
      'event_id', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _group_idMeta = const VerificationMeta('group_id');
  late final GeneratedColumn<int?> group_id = GeneratedColumn<int?>(
      'group_id', aliasedName, false,
      typeName: 'INTEGER', requiredDuringInsert: true);
  final VerificationMeta _event_nameMeta = const VerificationMeta('event_name');
  late final GeneratedColumn<String?> event_name = GeneratedColumn<String?>(
      'event_name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      typeName: 'TEXT',
      requiredDuringInsert: true);
  final VerificationMeta _event_dateMeta = const VerificationMeta('event_date');
  late final GeneratedColumn<String?> event_date = GeneratedColumn<String?>(
      'event_date', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _group_nameMeta = const VerificationMeta('group_name');
  late final GeneratedColumn<String?> group_name = GeneratedColumn<String?>(
      'group_name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      typeName: 'TEXT',
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [event_id, group_id, event_name, event_date, group_name];
  @override
  String get aliasedName => _alias ?? 'events';
  @override
  String get actualTableName => 'events';
  @override
  VerificationContext validateIntegrity(Insertable<Event> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('event_id')) {
      context.handle(_event_idMeta,
          event_id.isAcceptableOrUnknown(data['event_id']!, _event_idMeta));
    }
    if (data.containsKey('group_id')) {
      context.handle(_group_idMeta,
          group_id.isAcceptableOrUnknown(data['group_id']!, _group_idMeta));
    } else if (isInserting) {
      context.missing(_group_idMeta);
    }
    if (data.containsKey('event_name')) {
      context.handle(
          _event_nameMeta,
          event_name.isAcceptableOrUnknown(
              data['event_name']!, _event_nameMeta));
    } else if (isInserting) {
      context.missing(_event_nameMeta);
    }
    if (data.containsKey('event_date')) {
      context.handle(
          _event_dateMeta,
          event_date.isAcceptableOrUnknown(
              data['event_date']!, _event_dateMeta));
    } else if (isInserting) {
      context.missing(_event_dateMeta);
    }
    if (data.containsKey('group_name')) {
      context.handle(
          _group_nameMeta,
          group_name.isAcceptableOrUnknown(
              data['group_name']!, _group_nameMeta));
    } else if (isInserting) {
      context.missing(_group_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {event_id};
  @override
  Event map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Event.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $EventsTable createAlias(String alias) {
    return $EventsTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $EventsTable events = $EventsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [events];
}
