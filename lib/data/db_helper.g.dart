// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_helper.dart';

// ignore_for_file: type=lint
class $FlashFoldersTable extends FlashFolders
    with TableInfo<$FlashFoldersTable, FlashFolder> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FlashFoldersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'flash_folders';
  @override
  VerificationContext validateIntegrity(
    Insertable<FlashFolder> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FlashFolder map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FlashFolder(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
    );
  }

  @override
  $FlashFoldersTable createAlias(String alias) {
    return $FlashFoldersTable(attachedDatabase, alias);
  }
}

class FlashFolder extends DataClass implements Insertable<FlashFolder> {
  final int id;
  final String name;
  const FlashFolder({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  FlashFoldersCompanion toCompanion(bool nullToAbsent) {
    return FlashFoldersCompanion(id: Value(id), name: Value(name));
  }

  factory FlashFolder.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FlashFolder(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  FlashFolder copyWith({int? id, String? name}) =>
      FlashFolder(id: id ?? this.id, name: name ?? this.name);
  FlashFolder copyWithCompanion(FlashFoldersCompanion data) {
    return FlashFolder(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FlashFolder(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FlashFolder && other.id == this.id && other.name == this.name);
}

class FlashFoldersCompanion extends UpdateCompanion<FlashFolder> {
  final Value<int> id;
  final Value<String> name;
  const FlashFoldersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  FlashFoldersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<FlashFolder> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  FlashFoldersCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return FlashFoldersCompanion(id: id ?? this.id, name: name ?? this.name);
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FlashFoldersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $FlashCardsTable extends FlashCards
    with TableInfo<$FlashCardsTable, FlashCard> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FlashCardsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _front_kanjiMeta = const VerificationMeta(
    'front_kanji',
  );
  @override
  late final GeneratedColumn<String> front_kanji = GeneratedColumn<String>(
    'front_kanji',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _front_kanaMeta = const VerificationMeta(
    'front_kana',
  );
  @override
  late final GeneratedColumn<String> front_kana = GeneratedColumn<String>(
    'front_kana',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _backMeta = const VerificationMeta('back');
  @override
  late final GeneratedColumn<String> back = GeneratedColumn<String>(
    'back',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _folderMeta = const VerificationMeta('folder');
  @override
  late final GeneratedColumn<int> folder = GeneratedColumn<int>(
    'folder',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES flash_folders (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [front_kanji, front_kana, back, folder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'flash_cards';
  @override
  VerificationContext validateIntegrity(
    Insertable<FlashCard> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('front_kanji')) {
      context.handle(
        _front_kanjiMeta,
        front_kanji.isAcceptableOrUnknown(
          data['front_kanji']!,
          _front_kanjiMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_front_kanjiMeta);
    }
    if (data.containsKey('front_kana')) {
      context.handle(
        _front_kanaMeta,
        front_kana.isAcceptableOrUnknown(data['front_kana']!, _front_kanaMeta),
      );
    }
    if (data.containsKey('back')) {
      context.handle(
        _backMeta,
        back.isAcceptableOrUnknown(data['back']!, _backMeta),
      );
    } else if (isInserting) {
      context.missing(_backMeta);
    }
    if (data.containsKey('folder')) {
      context.handle(
        _folderMeta,
        folder.isAcceptableOrUnknown(data['folder']!, _folderMeta),
      );
    } else if (isInserting) {
      context.missing(_folderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  FlashCard map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FlashCard(
      front_kanji: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}front_kanji'],
      )!,
      front_kana: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}front_kana'],
      ),
      back: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}back'],
      )!,
      folder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}folder'],
      )!,
    );
  }

  @override
  $FlashCardsTable createAlias(String alias) {
    return $FlashCardsTable(attachedDatabase, alias);
  }
}

class FlashCard extends DataClass implements Insertable<FlashCard> {
  final String front_kanji;
  final String? front_kana;
  final String back;
  final int folder;
  const FlashCard({
    required this.front_kanji,
    this.front_kana,
    required this.back,
    required this.folder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['front_kanji'] = Variable<String>(front_kanji);
    if (!nullToAbsent || front_kana != null) {
      map['front_kana'] = Variable<String>(front_kana);
    }
    map['back'] = Variable<String>(back);
    map['folder'] = Variable<int>(folder);
    return map;
  }

  FlashCardsCompanion toCompanion(bool nullToAbsent) {
    return FlashCardsCompanion(
      front_kanji: Value(front_kanji),
      front_kana: front_kana == null && nullToAbsent
          ? const Value.absent()
          : Value(front_kana),
      back: Value(back),
      folder: Value(folder),
    );
  }

  factory FlashCard.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FlashCard(
      front_kanji: serializer.fromJson<String>(json['front_kanji']),
      front_kana: serializer.fromJson<String?>(json['front_kana']),
      back: serializer.fromJson<String>(json['back']),
      folder: serializer.fromJson<int>(json['folder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'front_kanji': serializer.toJson<String>(front_kanji),
      'front_kana': serializer.toJson<String?>(front_kana),
      'back': serializer.toJson<String>(back),
      'folder': serializer.toJson<int>(folder),
    };
  }

  FlashCard copyWith({
    String? front_kanji,
    Value<String?> front_kana = const Value.absent(),
    String? back,
    int? folder,
  }) => FlashCard(
    front_kanji: front_kanji ?? this.front_kanji,
    front_kana: front_kana.present ? front_kana.value : this.front_kana,
    back: back ?? this.back,
    folder: folder ?? this.folder,
  );
  FlashCard copyWithCompanion(FlashCardsCompanion data) {
    return FlashCard(
      front_kanji: data.front_kanji.present
          ? data.front_kanji.value
          : this.front_kanji,
      front_kana: data.front_kana.present
          ? data.front_kana.value
          : this.front_kana,
      back: data.back.present ? data.back.value : this.back,
      folder: data.folder.present ? data.folder.value : this.folder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FlashCard(')
          ..write('front_kanji: $front_kanji, ')
          ..write('front_kana: $front_kana, ')
          ..write('back: $back, ')
          ..write('folder: $folder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(front_kanji, front_kana, back, folder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FlashCard &&
          other.front_kanji == this.front_kanji &&
          other.front_kana == this.front_kana &&
          other.back == this.back &&
          other.folder == this.folder);
}

class FlashCardsCompanion extends UpdateCompanion<FlashCard> {
  final Value<String> front_kanji;
  final Value<String?> front_kana;
  final Value<String> back;
  final Value<int> folder;
  final Value<int> rowid;
  const FlashCardsCompanion({
    this.front_kanji = const Value.absent(),
    this.front_kana = const Value.absent(),
    this.back = const Value.absent(),
    this.folder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FlashCardsCompanion.insert({
    required String front_kanji,
    this.front_kana = const Value.absent(),
    required String back,
    required int folder,
    this.rowid = const Value.absent(),
  }) : front_kanji = Value(front_kanji),
       back = Value(back),
       folder = Value(folder);
  static Insertable<FlashCard> custom({
    Expression<String>? front_kanji,
    Expression<String>? front_kana,
    Expression<String>? back,
    Expression<int>? folder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (front_kanji != null) 'front_kanji': front_kanji,
      if (front_kana != null) 'front_kana': front_kana,
      if (back != null) 'back': back,
      if (folder != null) 'folder': folder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FlashCardsCompanion copyWith({
    Value<String>? front_kanji,
    Value<String?>? front_kana,
    Value<String>? back,
    Value<int>? folder,
    Value<int>? rowid,
  }) {
    return FlashCardsCompanion(
      front_kanji: front_kanji ?? this.front_kanji,
      front_kana: front_kana ?? this.front_kana,
      back: back ?? this.back,
      folder: folder ?? this.folder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (front_kanji.present) {
      map['front_kanji'] = Variable<String>(front_kanji.value);
    }
    if (front_kana.present) {
      map['front_kana'] = Variable<String>(front_kana.value);
    }
    if (back.present) {
      map['back'] = Variable<String>(back.value);
    }
    if (folder.present) {
      map['folder'] = Variable<int>(folder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FlashCardsCompanion(')
          ..write('front_kanji: $front_kanji, ')
          ..write('front_kana: $front_kana, ')
          ..write('back: $back, ')
          ..write('folder: $folder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $VisitedWordTable extends VisitedWord
    with TableInfo<$VisitedWordTable, VisitedWordData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VisitedWordTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _kanjiMeta = const VerificationMeta('kanji');
  @override
  late final GeneratedColumn<String> kanji = GeneratedColumn<String>(
    'kanji',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _kanaMeta = const VerificationMeta('kana');
  @override
  late final GeneratedColumn<String> kana = GeneratedColumn<String>(
    'kana',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _definitionMeta = const VerificationMeta(
    'definition',
  );
  @override
  late final GeneratedColumn<String> definition = GeneratedColumn<String>(
    'definition',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _visitedAtMeta = const VerificationMeta(
    'visitedAt',
  );
  @override
  late final GeneratedColumn<DateTime> visitedAt = GeneratedColumn<DateTime>(
    'visited_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    kanji,
    kana,
    definition,
    visitedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'visited_word';
  @override
  VerificationContext validateIntegrity(
    Insertable<VisitedWordData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('kanji')) {
      context.handle(
        _kanjiMeta,
        kanji.isAcceptableOrUnknown(data['kanji']!, _kanjiMeta),
      );
    }
    if (data.containsKey('kana')) {
      context.handle(
        _kanaMeta,
        kana.isAcceptableOrUnknown(data['kana']!, _kanaMeta),
      );
    } else if (isInserting) {
      context.missing(_kanaMeta);
    }
    if (data.containsKey('definition')) {
      context.handle(
        _definitionMeta,
        definition.isAcceptableOrUnknown(data['definition']!, _definitionMeta),
      );
    } else if (isInserting) {
      context.missing(_definitionMeta);
    }
    if (data.containsKey('visited_at')) {
      context.handle(
        _visitedAtMeta,
        visitedAt.isAcceptableOrUnknown(data['visited_at']!, _visitedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VisitedWordData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VisitedWordData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      kanji: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kanji'],
      ),
      kana: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kana'],
      )!,
      definition: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}definition'],
      )!,
      visitedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}visited_at'],
      )!,
    );
  }

  @override
  $VisitedWordTable createAlias(String alias) {
    return $VisitedWordTable(attachedDatabase, alias);
  }
}

class VisitedWordData extends DataClass implements Insertable<VisitedWordData> {
  final int id;
  final String? kanji;
  final String kana;
  final String definition;
  final DateTime visitedAt;
  const VisitedWordData({
    required this.id,
    this.kanji,
    required this.kana,
    required this.definition,
    required this.visitedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || kanji != null) {
      map['kanji'] = Variable<String>(kanji);
    }
    map['kana'] = Variable<String>(kana);
    map['definition'] = Variable<String>(definition);
    map['visited_at'] = Variable<DateTime>(visitedAt);
    return map;
  }

  VisitedWordCompanion toCompanion(bool nullToAbsent) {
    return VisitedWordCompanion(
      id: Value(id),
      kanji: kanji == null && nullToAbsent
          ? const Value.absent()
          : Value(kanji),
      kana: Value(kana),
      definition: Value(definition),
      visitedAt: Value(visitedAt),
    );
  }

  factory VisitedWordData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VisitedWordData(
      id: serializer.fromJson<int>(json['id']),
      kanji: serializer.fromJson<String?>(json['kanji']),
      kana: serializer.fromJson<String>(json['kana']),
      definition: serializer.fromJson<String>(json['definition']),
      visitedAt: serializer.fromJson<DateTime>(json['visitedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'kanji': serializer.toJson<String?>(kanji),
      'kana': serializer.toJson<String>(kana),
      'definition': serializer.toJson<String>(definition),
      'visitedAt': serializer.toJson<DateTime>(visitedAt),
    };
  }

  VisitedWordData copyWith({
    int? id,
    Value<String?> kanji = const Value.absent(),
    String? kana,
    String? definition,
    DateTime? visitedAt,
  }) => VisitedWordData(
    id: id ?? this.id,
    kanji: kanji.present ? kanji.value : this.kanji,
    kana: kana ?? this.kana,
    definition: definition ?? this.definition,
    visitedAt: visitedAt ?? this.visitedAt,
  );
  VisitedWordData copyWithCompanion(VisitedWordCompanion data) {
    return VisitedWordData(
      id: data.id.present ? data.id.value : this.id,
      kanji: data.kanji.present ? data.kanji.value : this.kanji,
      kana: data.kana.present ? data.kana.value : this.kana,
      definition: data.definition.present
          ? data.definition.value
          : this.definition,
      visitedAt: data.visitedAt.present ? data.visitedAt.value : this.visitedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VisitedWordData(')
          ..write('id: $id, ')
          ..write('kanji: $kanji, ')
          ..write('kana: $kana, ')
          ..write('definition: $definition, ')
          ..write('visitedAt: $visitedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, kanji, kana, definition, visitedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VisitedWordData &&
          other.id == this.id &&
          other.kanji == this.kanji &&
          other.kana == this.kana &&
          other.definition == this.definition &&
          other.visitedAt == this.visitedAt);
}

class VisitedWordCompanion extends UpdateCompanion<VisitedWordData> {
  final Value<int> id;
  final Value<String?> kanji;
  final Value<String> kana;
  final Value<String> definition;
  final Value<DateTime> visitedAt;
  const VisitedWordCompanion({
    this.id = const Value.absent(),
    this.kanji = const Value.absent(),
    this.kana = const Value.absent(),
    this.definition = const Value.absent(),
    this.visitedAt = const Value.absent(),
  });
  VisitedWordCompanion.insert({
    this.id = const Value.absent(),
    this.kanji = const Value.absent(),
    required String kana,
    required String definition,
    this.visitedAt = const Value.absent(),
  }) : kana = Value(kana),
       definition = Value(definition);
  static Insertable<VisitedWordData> custom({
    Expression<int>? id,
    Expression<String>? kanji,
    Expression<String>? kana,
    Expression<String>? definition,
    Expression<DateTime>? visitedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (kanji != null) 'kanji': kanji,
      if (kana != null) 'kana': kana,
      if (definition != null) 'definition': definition,
      if (visitedAt != null) 'visited_at': visitedAt,
    });
  }

  VisitedWordCompanion copyWith({
    Value<int>? id,
    Value<String?>? kanji,
    Value<String>? kana,
    Value<String>? definition,
    Value<DateTime>? visitedAt,
  }) {
    return VisitedWordCompanion(
      id: id ?? this.id,
      kanji: kanji ?? this.kanji,
      kana: kana ?? this.kana,
      definition: definition ?? this.definition,
      visitedAt: visitedAt ?? this.visitedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (kanji.present) {
      map['kanji'] = Variable<String>(kanji.value);
    }
    if (kana.present) {
      map['kana'] = Variable<String>(kana.value);
    }
    if (definition.present) {
      map['definition'] = Variable<String>(definition.value);
    }
    if (visitedAt.present) {
      map['visited_at'] = Variable<DateTime>(visitedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VisitedWordCompanion(')
          ..write('id: $id, ')
          ..write('kanji: $kanji, ')
          ..write('kana: $kana, ')
          ..write('definition: $definition, ')
          ..write('visitedAt: $visitedAt')
          ..write(')'))
        .toString();
  }
}

class $NotesTable extends Notes with TableInfo<$NotesTable, Note> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES visited_word (id)',
    ),
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, note];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notes';
  @override
  VerificationContext validateIntegrity(
    Insertable<Note> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    } else if (isInserting) {
      context.missing(_noteMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Note map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Note(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      )!,
    );
  }

  @override
  $NotesTable createAlias(String alias) {
    return $NotesTable(attachedDatabase, alias);
  }
}

class Note extends DataClass implements Insertable<Note> {
  final int id;
  final String note;
  const Note({required this.id, required this.note});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['note'] = Variable<String>(note);
    return map;
  }

  NotesCompanion toCompanion(bool nullToAbsent) {
    return NotesCompanion(id: Value(id), note: Value(note));
  }

  factory Note.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Note(
      id: serializer.fromJson<int>(json['id']),
      note: serializer.fromJson<String>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'note': serializer.toJson<String>(note),
    };
  }

  Note copyWith({int? id, String? note}) =>
      Note(id: id ?? this.id, note: note ?? this.note);
  Note copyWithCompanion(NotesCompanion data) {
    return Note(
      id: data.id.present ? data.id.value : this.id,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Note(')
          ..write('id: $id, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, note);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Note && other.id == this.id && other.note == this.note);
}

class NotesCompanion extends UpdateCompanion<Note> {
  final Value<int> id;
  final Value<String> note;
  const NotesCompanion({
    this.id = const Value.absent(),
    this.note = const Value.absent(),
  });
  NotesCompanion.insert({this.id = const Value.absent(), required String note})
    : note = Value(note);
  static Insertable<Note> custom({
    Expression<int>? id,
    Expression<String>? note,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (note != null) 'note': note,
    });
  }

  NotesCompanion copyWith({Value<int>? id, Value<String>? note}) {
    return NotesCompanion(id: id ?? this.id, note: note ?? this.note);
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotesCompanion(')
          ..write('id: $id, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }
}

abstract class _$DbHelper extends GeneratedDatabase {
  _$DbHelper(QueryExecutor e) : super(e);
  $DbHelperManager get managers => $DbHelperManager(this);
  late final $FlashFoldersTable flashFolders = $FlashFoldersTable(this);
  late final $FlashCardsTable flashCards = $FlashCardsTable(this);
  late final $VisitedWordTable visitedWord = $VisitedWordTable(this);
  late final $NotesTable notes = $NotesTable(this);
  late final VisitedWordDao visitedWordDao = VisitedWordDao(this as DbHelper);
  late final NotesDao notesDao = NotesDao(this as DbHelper);
  late final FoldersDao foldersDao = FoldersDao(this as DbHelper);
  late final FlashcardsDao flashcardsDao = FlashcardsDao(this as DbHelper);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    flashFolders,
    flashCards,
    visitedWord,
    notes,
  ];
}

typedef $$FlashFoldersTableCreateCompanionBuilder =
    FlashFoldersCompanion Function({Value<int> id, required String name});
typedef $$FlashFoldersTableUpdateCompanionBuilder =
    FlashFoldersCompanion Function({Value<int> id, Value<String> name});

final class $$FlashFoldersTableReferences
    extends BaseReferences<_$DbHelper, $FlashFoldersTable, FlashFolder> {
  $$FlashFoldersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$FlashCardsTable, List<FlashCard>>
  _flashCardsRefsTable(_$DbHelper db) => MultiTypedResultKey.fromTable(
    db.flashCards,
    aliasName: $_aliasNameGenerator(db.flashFolders.id, db.flashCards.folder),
  );

  $$FlashCardsTableProcessedTableManager get flashCardsRefs {
    final manager = $$FlashCardsTableTableManager(
      $_db,
      $_db.flashCards,
    ).filter((f) => f.folder.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_flashCardsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$FlashFoldersTableFilterComposer
    extends Composer<_$DbHelper, $FlashFoldersTable> {
  $$FlashFoldersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> flashCardsRefs(
    Expression<bool> Function($$FlashCardsTableFilterComposer f) f,
  ) {
    final $$FlashCardsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.flashCards,
      getReferencedColumn: (t) => t.folder,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FlashCardsTableFilterComposer(
            $db: $db,
            $table: $db.flashCards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FlashFoldersTableOrderingComposer
    extends Composer<_$DbHelper, $FlashFoldersTable> {
  $$FlashFoldersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FlashFoldersTableAnnotationComposer
    extends Composer<_$DbHelper, $FlashFoldersTable> {
  $$FlashFoldersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  Expression<T> flashCardsRefs<T extends Object>(
    Expression<T> Function($$FlashCardsTableAnnotationComposer a) f,
  ) {
    final $$FlashCardsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.flashCards,
      getReferencedColumn: (t) => t.folder,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FlashCardsTableAnnotationComposer(
            $db: $db,
            $table: $db.flashCards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FlashFoldersTableTableManager
    extends
        RootTableManager<
          _$DbHelper,
          $FlashFoldersTable,
          FlashFolder,
          $$FlashFoldersTableFilterComposer,
          $$FlashFoldersTableOrderingComposer,
          $$FlashFoldersTableAnnotationComposer,
          $$FlashFoldersTableCreateCompanionBuilder,
          $$FlashFoldersTableUpdateCompanionBuilder,
          (FlashFolder, $$FlashFoldersTableReferences),
          FlashFolder,
          PrefetchHooks Function({bool flashCardsRefs})
        > {
  $$FlashFoldersTableTableManager(_$DbHelper db, $FlashFoldersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FlashFoldersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FlashFoldersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FlashFoldersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
              }) => FlashFoldersCompanion(id: id, name: name),
          createCompanionCallback:
              ({Value<int> id = const Value.absent(), required String name}) =>
                  FlashFoldersCompanion.insert(id: id, name: name),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$FlashFoldersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({flashCardsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (flashCardsRefs) db.flashCards],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (flashCardsRefs)
                    await $_getPrefetchedData<
                      FlashFolder,
                      $FlashFoldersTable,
                      FlashCard
                    >(
                      currentTable: table,
                      referencedTable: $$FlashFoldersTableReferences
                          ._flashCardsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$FlashFoldersTableReferences(
                            db,
                            table,
                            p0,
                          ).flashCardsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.folder == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$FlashFoldersTableProcessedTableManager =
    ProcessedTableManager<
      _$DbHelper,
      $FlashFoldersTable,
      FlashFolder,
      $$FlashFoldersTableFilterComposer,
      $$FlashFoldersTableOrderingComposer,
      $$FlashFoldersTableAnnotationComposer,
      $$FlashFoldersTableCreateCompanionBuilder,
      $$FlashFoldersTableUpdateCompanionBuilder,
      (FlashFolder, $$FlashFoldersTableReferences),
      FlashFolder,
      PrefetchHooks Function({bool flashCardsRefs})
    >;
typedef $$FlashCardsTableCreateCompanionBuilder =
    FlashCardsCompanion Function({
      required String front_kanji,
      Value<String?> front_kana,
      required String back,
      required int folder,
      Value<int> rowid,
    });
typedef $$FlashCardsTableUpdateCompanionBuilder =
    FlashCardsCompanion Function({
      Value<String> front_kanji,
      Value<String?> front_kana,
      Value<String> back,
      Value<int> folder,
      Value<int> rowid,
    });

final class $$FlashCardsTableReferences
    extends BaseReferences<_$DbHelper, $FlashCardsTable, FlashCard> {
  $$FlashCardsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $FlashFoldersTable _folderTable(_$DbHelper db) =>
      db.flashFolders.createAlias(
        $_aliasNameGenerator(db.flashCards.folder, db.flashFolders.id),
      );

  $$FlashFoldersTableProcessedTableManager get folder {
    final $_column = $_itemColumn<int>('folder')!;

    final manager = $$FlashFoldersTableTableManager(
      $_db,
      $_db.flashFolders,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_folderTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$FlashCardsTableFilterComposer
    extends Composer<_$DbHelper, $FlashCardsTable> {
  $$FlashCardsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get front_kanji => $composableBuilder(
    column: $table.front_kanji,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get front_kana => $composableBuilder(
    column: $table.front_kana,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get back => $composableBuilder(
    column: $table.back,
    builder: (column) => ColumnFilters(column),
  );

  $$FlashFoldersTableFilterComposer get folder {
    final $$FlashFoldersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.folder,
      referencedTable: $db.flashFolders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FlashFoldersTableFilterComposer(
            $db: $db,
            $table: $db.flashFolders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FlashCardsTableOrderingComposer
    extends Composer<_$DbHelper, $FlashCardsTable> {
  $$FlashCardsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get front_kanji => $composableBuilder(
    column: $table.front_kanji,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get front_kana => $composableBuilder(
    column: $table.front_kana,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get back => $composableBuilder(
    column: $table.back,
    builder: (column) => ColumnOrderings(column),
  );

  $$FlashFoldersTableOrderingComposer get folder {
    final $$FlashFoldersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.folder,
      referencedTable: $db.flashFolders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FlashFoldersTableOrderingComposer(
            $db: $db,
            $table: $db.flashFolders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FlashCardsTableAnnotationComposer
    extends Composer<_$DbHelper, $FlashCardsTable> {
  $$FlashCardsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get front_kanji => $composableBuilder(
    column: $table.front_kanji,
    builder: (column) => column,
  );

  GeneratedColumn<String> get front_kana => $composableBuilder(
    column: $table.front_kana,
    builder: (column) => column,
  );

  GeneratedColumn<String> get back =>
      $composableBuilder(column: $table.back, builder: (column) => column);

  $$FlashFoldersTableAnnotationComposer get folder {
    final $$FlashFoldersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.folder,
      referencedTable: $db.flashFolders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FlashFoldersTableAnnotationComposer(
            $db: $db,
            $table: $db.flashFolders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FlashCardsTableTableManager
    extends
        RootTableManager<
          _$DbHelper,
          $FlashCardsTable,
          FlashCard,
          $$FlashCardsTableFilterComposer,
          $$FlashCardsTableOrderingComposer,
          $$FlashCardsTableAnnotationComposer,
          $$FlashCardsTableCreateCompanionBuilder,
          $$FlashCardsTableUpdateCompanionBuilder,
          (FlashCard, $$FlashCardsTableReferences),
          FlashCard,
          PrefetchHooks Function({bool folder})
        > {
  $$FlashCardsTableTableManager(_$DbHelper db, $FlashCardsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FlashCardsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FlashCardsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FlashCardsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> front_kanji = const Value.absent(),
                Value<String?> front_kana = const Value.absent(),
                Value<String> back = const Value.absent(),
                Value<int> folder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FlashCardsCompanion(
                front_kanji: front_kanji,
                front_kana: front_kana,
                back: back,
                folder: folder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String front_kanji,
                Value<String?> front_kana = const Value.absent(),
                required String back,
                required int folder,
                Value<int> rowid = const Value.absent(),
              }) => FlashCardsCompanion.insert(
                front_kanji: front_kanji,
                front_kana: front_kana,
                back: back,
                folder: folder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$FlashCardsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({folder = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
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
                      dynamic
                    >
                  >(state) {
                    if (folder) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.folder,
                                referencedTable: $$FlashCardsTableReferences
                                    ._folderTable(db),
                                referencedColumn: $$FlashCardsTableReferences
                                    ._folderTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$FlashCardsTableProcessedTableManager =
    ProcessedTableManager<
      _$DbHelper,
      $FlashCardsTable,
      FlashCard,
      $$FlashCardsTableFilterComposer,
      $$FlashCardsTableOrderingComposer,
      $$FlashCardsTableAnnotationComposer,
      $$FlashCardsTableCreateCompanionBuilder,
      $$FlashCardsTableUpdateCompanionBuilder,
      (FlashCard, $$FlashCardsTableReferences),
      FlashCard,
      PrefetchHooks Function({bool folder})
    >;
typedef $$VisitedWordTableCreateCompanionBuilder =
    VisitedWordCompanion Function({
      Value<int> id,
      Value<String?> kanji,
      required String kana,
      required String definition,
      Value<DateTime> visitedAt,
    });
typedef $$VisitedWordTableUpdateCompanionBuilder =
    VisitedWordCompanion Function({
      Value<int> id,
      Value<String?> kanji,
      Value<String> kana,
      Value<String> definition,
      Value<DateTime> visitedAt,
    });

final class $$VisitedWordTableReferences
    extends BaseReferences<_$DbHelper, $VisitedWordTable, VisitedWordData> {
  $$VisitedWordTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$NotesTable, List<Note>> _notesRefsTable(
    _$DbHelper db,
  ) => MultiTypedResultKey.fromTable(
    db.notes,
    aliasName: $_aliasNameGenerator(db.visitedWord.id, db.notes.id),
  );

  $$NotesTableProcessedTableManager get notesRefs {
    final manager = $$NotesTableTableManager(
      $_db,
      $_db.notes,
    ).filter((f) => f.id.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_notesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$VisitedWordTableFilterComposer
    extends Composer<_$DbHelper, $VisitedWordTable> {
  $$VisitedWordTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kanji => $composableBuilder(
    column: $table.kanji,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kana => $composableBuilder(
    column: $table.kana,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get definition => $composableBuilder(
    column: $table.definition,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get visitedAt => $composableBuilder(
    column: $table.visitedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> notesRefs(
    Expression<bool> Function($$NotesTableFilterComposer f) f,
  ) {
    final $$NotesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.notes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NotesTableFilterComposer(
            $db: $db,
            $table: $db.notes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VisitedWordTableOrderingComposer
    extends Composer<_$DbHelper, $VisitedWordTable> {
  $$VisitedWordTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kanji => $composableBuilder(
    column: $table.kanji,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kana => $composableBuilder(
    column: $table.kana,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get definition => $composableBuilder(
    column: $table.definition,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get visitedAt => $composableBuilder(
    column: $table.visitedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$VisitedWordTableAnnotationComposer
    extends Composer<_$DbHelper, $VisitedWordTable> {
  $$VisitedWordTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get kanji =>
      $composableBuilder(column: $table.kanji, builder: (column) => column);

  GeneratedColumn<String> get kana =>
      $composableBuilder(column: $table.kana, builder: (column) => column);

  GeneratedColumn<String> get definition => $composableBuilder(
    column: $table.definition,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get visitedAt =>
      $composableBuilder(column: $table.visitedAt, builder: (column) => column);

  Expression<T> notesRefs<T extends Object>(
    Expression<T> Function($$NotesTableAnnotationComposer a) f,
  ) {
    final $$NotesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.notes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NotesTableAnnotationComposer(
            $db: $db,
            $table: $db.notes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VisitedWordTableTableManager
    extends
        RootTableManager<
          _$DbHelper,
          $VisitedWordTable,
          VisitedWordData,
          $$VisitedWordTableFilterComposer,
          $$VisitedWordTableOrderingComposer,
          $$VisitedWordTableAnnotationComposer,
          $$VisitedWordTableCreateCompanionBuilder,
          $$VisitedWordTableUpdateCompanionBuilder,
          (VisitedWordData, $$VisitedWordTableReferences),
          VisitedWordData,
          PrefetchHooks Function({bool notesRefs})
        > {
  $$VisitedWordTableTableManager(_$DbHelper db, $VisitedWordTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VisitedWordTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VisitedWordTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VisitedWordTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> kanji = const Value.absent(),
                Value<String> kana = const Value.absent(),
                Value<String> definition = const Value.absent(),
                Value<DateTime> visitedAt = const Value.absent(),
              }) => VisitedWordCompanion(
                id: id,
                kanji: kanji,
                kana: kana,
                definition: definition,
                visitedAt: visitedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> kanji = const Value.absent(),
                required String kana,
                required String definition,
                Value<DateTime> visitedAt = const Value.absent(),
              }) => VisitedWordCompanion.insert(
                id: id,
                kanji: kanji,
                kana: kana,
                definition: definition,
                visitedAt: visitedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$VisitedWordTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({notesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (notesRefs) db.notes],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (notesRefs)
                    await $_getPrefetchedData<
                      VisitedWordData,
                      $VisitedWordTable,
                      Note
                    >(
                      currentTable: table,
                      referencedTable: $$VisitedWordTableReferences
                          ._notesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$VisitedWordTableReferences(db, table, p0).notesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.id == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$VisitedWordTableProcessedTableManager =
    ProcessedTableManager<
      _$DbHelper,
      $VisitedWordTable,
      VisitedWordData,
      $$VisitedWordTableFilterComposer,
      $$VisitedWordTableOrderingComposer,
      $$VisitedWordTableAnnotationComposer,
      $$VisitedWordTableCreateCompanionBuilder,
      $$VisitedWordTableUpdateCompanionBuilder,
      (VisitedWordData, $$VisitedWordTableReferences),
      VisitedWordData,
      PrefetchHooks Function({bool notesRefs})
    >;
typedef $$NotesTableCreateCompanionBuilder =
    NotesCompanion Function({Value<int> id, required String note});
typedef $$NotesTableUpdateCompanionBuilder =
    NotesCompanion Function({Value<int> id, Value<String> note});

final class $$NotesTableReferences
    extends BaseReferences<_$DbHelper, $NotesTable, Note> {
  $$NotesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $VisitedWordTable _idTable(_$DbHelper db) => db.visitedWord
      .createAlias($_aliasNameGenerator(db.notes.id, db.visitedWord.id));

  $$VisitedWordTableProcessedTableManager get id {
    final $_column = $_itemColumn<int>('id')!;

    final manager = $$VisitedWordTableTableManager(
      $_db,
      $_db.visitedWord,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_idTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$NotesTableFilterComposer extends Composer<_$DbHelper, $NotesTable> {
  $$NotesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  $$VisitedWordTableFilterComposer get id {
    final $$VisitedWordTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.visitedWord,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VisitedWordTableFilterComposer(
            $db: $db,
            $table: $db.visitedWord,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$NotesTableOrderingComposer extends Composer<_$DbHelper, $NotesTable> {
  $$NotesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  $$VisitedWordTableOrderingComposer get id {
    final $$VisitedWordTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.visitedWord,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VisitedWordTableOrderingComposer(
            $db: $db,
            $table: $db.visitedWord,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$NotesTableAnnotationComposer extends Composer<_$DbHelper, $NotesTable> {
  $$NotesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  $$VisitedWordTableAnnotationComposer get id {
    final $$VisitedWordTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.visitedWord,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VisitedWordTableAnnotationComposer(
            $db: $db,
            $table: $db.visitedWord,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$NotesTableTableManager
    extends
        RootTableManager<
          _$DbHelper,
          $NotesTable,
          Note,
          $$NotesTableFilterComposer,
          $$NotesTableOrderingComposer,
          $$NotesTableAnnotationComposer,
          $$NotesTableCreateCompanionBuilder,
          $$NotesTableUpdateCompanionBuilder,
          (Note, $$NotesTableReferences),
          Note,
          PrefetchHooks Function({bool id})
        > {
  $$NotesTableTableManager(_$DbHelper db, $NotesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NotesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NotesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> note = const Value.absent(),
              }) => NotesCompanion(id: id, note: note),
          createCompanionCallback:
              ({Value<int> id = const Value.absent(), required String note}) =>
                  NotesCompanion.insert(id: id, note: note),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$NotesTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({id = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
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
                      dynamic
                    >
                  >(state) {
                    if (id) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.id,
                                referencedTable: $$NotesTableReferences
                                    ._idTable(db),
                                referencedColumn: $$NotesTableReferences
                                    ._idTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$NotesTableProcessedTableManager =
    ProcessedTableManager<
      _$DbHelper,
      $NotesTable,
      Note,
      $$NotesTableFilterComposer,
      $$NotesTableOrderingComposer,
      $$NotesTableAnnotationComposer,
      $$NotesTableCreateCompanionBuilder,
      $$NotesTableUpdateCompanionBuilder,
      (Note, $$NotesTableReferences),
      Note,
      PrefetchHooks Function({bool id})
    >;

class $DbHelperManager {
  final _$DbHelper _db;
  $DbHelperManager(this._db);
  $$FlashFoldersTableTableManager get flashFolders =>
      $$FlashFoldersTableTableManager(_db, _db.flashFolders);
  $$FlashCardsTableTableManager get flashCards =>
      $$FlashCardsTableTableManager(_db, _db.flashCards);
  $$VisitedWordTableTableManager get visitedWord =>
      $$VisitedWordTableTableManager(_db, _db.visitedWord);
  $$NotesTableTableManager get notes =>
      $$NotesTableTableManager(_db, _db.notes);
}
