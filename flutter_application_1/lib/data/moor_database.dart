import 'package:moor_flutter/moor_flutter.dart';
part 'moor_database.g.dart';

// The name of the database table is "tasks"
// By default, the name of the generated data class will be "Task" (without "s")
class Events extends Table {
  IntColumn get event_id => integer().autoIncrement()();
  IntColumn get group_id => integer()();
  TextColumn get event_name => text().withLength(min: 1, max: 50)();
  TextColumn get event_date => text()();
  TextColumn get group_name => text().withLength(min: 1, max: 50)();
}

@UseMoor(tables: [Events])
// _$AppDatabase is the name of the generated class
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      // Specify the location of the database file
      : super(FlutterQueryExecutor.inDatabaseFolder(
          path: 'db.sqlite',
          // Good for debugging - prints SQL in the console
          logStatements: true,
        ));

  // Bump this when changing tables and columns.
  // Migrations will be covered in the next part.
  @override
  int get schemaVersion => 1;
  // All tables have getters in the generated class - we can select the events table
  Future<List<Event>> getAllEvents() => select(events).get();

  // Moor supports Streams which emit elements when the watched data changes
  Stream<List<Event>> watchAllEvents() => select(events).watch();

  Future insertEvent(Event event) => into(events).insert(event);

  // Updates a Event with a matching primary key
  Future updateEvent(Event event) => update(events).replace(event);

  Future deleteEvent(Event event) => delete(events).delete(event);
}
