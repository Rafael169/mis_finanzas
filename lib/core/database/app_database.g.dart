// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, AppSettingsData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 36,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _currencyCodeMeta = const VerificationMeta(
    'currencyCode',
  );
  @override
  late final GeneratedColumn<String> currencyCode = GeneratedColumn<String>(
    'currency_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('COP'),
  );
  static const VerificationMeta _localeMeta = const VerificationMeta('locale');
  @override
  late final GeneratedColumn<String> locale = GeneratedColumn<String>(
    'locale',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('es_CO'),
  );
  static const VerificationMeta _defaultAlertPercentMeta =
      const VerificationMeta('defaultAlertPercent');
  @override
  late final GeneratedColumn<int> defaultAlertPercent = GeneratedColumn<int>(
    'default_alert_percent',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(80),
  );
  static const VerificationMeta _notificationsEnabledMeta =
      const VerificationMeta('notificationsEnabled');
  @override
  late final GeneratedColumn<bool> notificationsEnabled = GeneratedColumn<bool>(
    'notifications_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("notifications_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _onboardingCompletedMeta =
      const VerificationMeta('onboardingCompleted');
  @override
  late final GeneratedColumn<bool> onboardingCompleted = GeneratedColumn<bool>(
    'onboarding_completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("onboarding_completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    displayName,
    currencyCode,
    locale,
    defaultAlertPercent,
    notificationsEnabled,
    onboardingCompleted,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppSettingsData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    }
    if (data.containsKey('currency_code')) {
      context.handle(
        _currencyCodeMeta,
        currencyCode.isAcceptableOrUnknown(
          data['currency_code']!,
          _currencyCodeMeta,
        ),
      );
    }
    if (data.containsKey('locale')) {
      context.handle(
        _localeMeta,
        locale.isAcceptableOrUnknown(data['locale']!, _localeMeta),
      );
    }
    if (data.containsKey('default_alert_percent')) {
      context.handle(
        _defaultAlertPercentMeta,
        defaultAlertPercent.isAcceptableOrUnknown(
          data['default_alert_percent']!,
          _defaultAlertPercentMeta,
        ),
      );
    }
    if (data.containsKey('notifications_enabled')) {
      context.handle(
        _notificationsEnabledMeta,
        notificationsEnabled.isAcceptableOrUnknown(
          data['notifications_enabled']!,
          _notificationsEnabledMeta,
        ),
      );
    }
    if (data.containsKey('onboarding_completed')) {
      context.handle(
        _onboardingCompletedMeta,
        onboardingCompleted.isAcceptableOrUnknown(
          data['onboarding_completed']!,
          _onboardingCompletedMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppSettingsData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSettingsData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      ),
      currencyCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency_code'],
      )!,
      locale: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}locale'],
      )!,
      defaultAlertPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}default_alert_percent'],
      )!,
      notificationsEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}notifications_enabled'],
      )!,
      onboardingCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}onboarding_completed'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }
}

class AppSettingsData extends DataClass implements Insertable<AppSettingsData> {
  final String id;
  final String? displayName;
  final String currencyCode;
  final String locale;
  final int defaultAlertPercent;
  final bool notificationsEnabled;
  final bool onboardingCompleted;
  final DateTime createdAt;
  final DateTime updatedAt;
  const AppSettingsData({
    required this.id,
    this.displayName,
    required this.currencyCode,
    required this.locale,
    required this.defaultAlertPercent,
    required this.notificationsEnabled,
    required this.onboardingCompleted,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || displayName != null) {
      map['display_name'] = Variable<String>(displayName);
    }
    map['currency_code'] = Variable<String>(currencyCode);
    map['locale'] = Variable<String>(locale);
    map['default_alert_percent'] = Variable<int>(defaultAlertPercent);
    map['notifications_enabled'] = Variable<bool>(notificationsEnabled);
    map['onboarding_completed'] = Variable<bool>(onboardingCompleted);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(
      id: Value(id),
      displayName: displayName == null && nullToAbsent
          ? const Value.absent()
          : Value(displayName),
      currencyCode: Value(currencyCode),
      locale: Value(locale),
      defaultAlertPercent: Value(defaultAlertPercent),
      notificationsEnabled: Value(notificationsEnabled),
      onboardingCompleted: Value(onboardingCompleted),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory AppSettingsData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSettingsData(
      id: serializer.fromJson<String>(json['id']),
      displayName: serializer.fromJson<String?>(json['displayName']),
      currencyCode: serializer.fromJson<String>(json['currencyCode']),
      locale: serializer.fromJson<String>(json['locale']),
      defaultAlertPercent: serializer.fromJson<int>(
        json['defaultAlertPercent'],
      ),
      notificationsEnabled: serializer.fromJson<bool>(
        json['notificationsEnabled'],
      ),
      onboardingCompleted: serializer.fromJson<bool>(
        json['onboardingCompleted'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'displayName': serializer.toJson<String?>(displayName),
      'currencyCode': serializer.toJson<String>(currencyCode),
      'locale': serializer.toJson<String>(locale),
      'defaultAlertPercent': serializer.toJson<int>(defaultAlertPercent),
      'notificationsEnabled': serializer.toJson<bool>(notificationsEnabled),
      'onboardingCompleted': serializer.toJson<bool>(onboardingCompleted),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  AppSettingsData copyWith({
    String? id,
    Value<String?> displayName = const Value.absent(),
    String? currencyCode,
    String? locale,
    int? defaultAlertPercent,
    bool? notificationsEnabled,
    bool? onboardingCompleted,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => AppSettingsData(
    id: id ?? this.id,
    displayName: displayName.present ? displayName.value : this.displayName,
    currencyCode: currencyCode ?? this.currencyCode,
    locale: locale ?? this.locale,
    defaultAlertPercent: defaultAlertPercent ?? this.defaultAlertPercent,
    notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
    onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  AppSettingsData copyWithCompanion(AppSettingsCompanion data) {
    return AppSettingsData(
      id: data.id.present ? data.id.value : this.id,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      currencyCode: data.currencyCode.present
          ? data.currencyCode.value
          : this.currencyCode,
      locale: data.locale.present ? data.locale.value : this.locale,
      defaultAlertPercent: data.defaultAlertPercent.present
          ? data.defaultAlertPercent.value
          : this.defaultAlertPercent,
      notificationsEnabled: data.notificationsEnabled.present
          ? data.notificationsEnabled.value
          : this.notificationsEnabled,
      onboardingCompleted: data.onboardingCompleted.present
          ? data.onboardingCompleted.value
          : this.onboardingCompleted,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsData(')
          ..write('id: $id, ')
          ..write('displayName: $displayName, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('locale: $locale, ')
          ..write('defaultAlertPercent: $defaultAlertPercent, ')
          ..write('notificationsEnabled: $notificationsEnabled, ')
          ..write('onboardingCompleted: $onboardingCompleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    displayName,
    currencyCode,
    locale,
    defaultAlertPercent,
    notificationsEnabled,
    onboardingCompleted,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSettingsData &&
          other.id == this.id &&
          other.displayName == this.displayName &&
          other.currencyCode == this.currencyCode &&
          other.locale == this.locale &&
          other.defaultAlertPercent == this.defaultAlertPercent &&
          other.notificationsEnabled == this.notificationsEnabled &&
          other.onboardingCompleted == this.onboardingCompleted &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class AppSettingsCompanion extends UpdateCompanion<AppSettingsData> {
  final Value<String> id;
  final Value<String?> displayName;
  final Value<String> currencyCode;
  final Value<String> locale;
  final Value<int> defaultAlertPercent;
  final Value<bool> notificationsEnabled;
  final Value<bool> onboardingCompleted;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const AppSettingsCompanion({
    this.id = const Value.absent(),
    this.displayName = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.locale = const Value.absent(),
    this.defaultAlertPercent = const Value.absent(),
    this.notificationsEnabled = const Value.absent(),
    this.onboardingCompleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    required String id,
    this.displayName = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.locale = const Value.absent(),
    this.defaultAlertPercent = const Value.absent(),
    this.notificationsEnabled = const Value.absent(),
    this.onboardingCompleted = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<AppSettingsData> custom({
    Expression<String>? id,
    Expression<String>? displayName,
    Expression<String>? currencyCode,
    Expression<String>? locale,
    Expression<int>? defaultAlertPercent,
    Expression<bool>? notificationsEnabled,
    Expression<bool>? onboardingCompleted,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (displayName != null) 'display_name': displayName,
      if (currencyCode != null) 'currency_code': currencyCode,
      if (locale != null) 'locale': locale,
      if (defaultAlertPercent != null)
        'default_alert_percent': defaultAlertPercent,
      if (notificationsEnabled != null)
        'notifications_enabled': notificationsEnabled,
      if (onboardingCompleted != null)
        'onboarding_completed': onboardingCompleted,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppSettingsCompanion copyWith({
    Value<String>? id,
    Value<String?>? displayName,
    Value<String>? currencyCode,
    Value<String>? locale,
    Value<int>? defaultAlertPercent,
    Value<bool>? notificationsEnabled,
    Value<bool>? onboardingCompleted,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return AppSettingsCompanion(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      currencyCode: currencyCode ?? this.currencyCode,
      locale: locale ?? this.locale,
      defaultAlertPercent: defaultAlertPercent ?? this.defaultAlertPercent,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (currencyCode.present) {
      map['currency_code'] = Variable<String>(currencyCode.value);
    }
    if (locale.present) {
      map['locale'] = Variable<String>(locale.value);
    }
    if (defaultAlertPercent.present) {
      map['default_alert_percent'] = Variable<int>(defaultAlertPercent.value);
    }
    if (notificationsEnabled.present) {
      map['notifications_enabled'] = Variable<bool>(notificationsEnabled.value);
    }
    if (onboardingCompleted.present) {
      map['onboarding_completed'] = Variable<bool>(onboardingCompleted.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('id: $id, ')
          ..write('displayName: $displayName, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('locale: $locale, ')
          ..write('defaultAlertPercent: $defaultAlertPercent, ')
          ..write('notificationsEnabled: $notificationsEnabled, ')
          ..write('onboardingCompleted: $onboardingCompleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FinancialPeriodsTable extends FinancialPeriods
    with TableInfo<$FinancialPeriodsTable, FinancialPeriod> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FinancialPeriodsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 36,
      maxTextLength: 36,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _yearMeta = const VerificationMeta('year');
  @override
  late final GeneratedColumn<int> year = GeneratedColumn<int>(
    'year',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _monthMeta = const VerificationMeta('month');
  @override
  late final GeneratedColumn<int> month = GeneratedColumn<int>(
    'month',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
    'start_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endDateMeta = const VerificationMeta(
    'endDate',
  );
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
    'end_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isClosedMeta = const VerificationMeta(
    'isClosed',
  );
  @override
  late final GeneratedColumn<bool> isClosed = GeneratedColumn<bool>(
    'is_closed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_closed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _closedAtMeta = const VerificationMeta(
    'closedAt',
  );
  @override
  late final GeneratedColumn<DateTime> closedAt = GeneratedColumn<DateTime>(
    'closed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _incomeBudgetTotalMeta = const VerificationMeta(
    'incomeBudgetTotal',
  );
  @override
  late final GeneratedColumn<int> incomeBudgetTotal = GeneratedColumn<int>(
    'income_budget_total',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _incomeActualTotalMeta = const VerificationMeta(
    'incomeActualTotal',
  );
  @override
  late final GeneratedColumn<int> incomeActualTotal = GeneratedColumn<int>(
    'income_actual_total',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _extraIncomeActualTotalMeta =
      const VerificationMeta('extraIncomeActualTotal');
  @override
  late final GeneratedColumn<int> extraIncomeActualTotal = GeneratedColumn<int>(
    'extra_income_actual_total',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _expenseBudgetTotalMeta =
      const VerificationMeta('expenseBudgetTotal');
  @override
  late final GeneratedColumn<int> expenseBudgetTotal = GeneratedColumn<int>(
    'expense_budget_total',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _expenseActualTotalMeta =
      const VerificationMeta('expenseActualTotal');
  @override
  late final GeneratedColumn<int> expenseActualTotal = GeneratedColumn<int>(
    'expense_actual_total',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _antExpenseActualTotalMeta =
      const VerificationMeta('antExpenseActualTotal');
  @override
  late final GeneratedColumn<int> antExpenseActualTotal = GeneratedColumn<int>(
    'ant_expense_actual_total',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    year,
    month,
    startDate,
    endDate,
    isClosed,
    closedAt,
    incomeBudgetTotal,
    incomeActualTotal,
    extraIncomeActualTotal,
    expenseBudgetTotal,
    expenseActualTotal,
    antExpenseActualTotal,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'financial_periods';
  @override
  VerificationContext validateIntegrity(
    Insertable<FinancialPeriod> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('year')) {
      context.handle(
        _yearMeta,
        year.isAcceptableOrUnknown(data['year']!, _yearMeta),
      );
    } else if (isInserting) {
      context.missing(_yearMeta);
    }
    if (data.containsKey('month')) {
      context.handle(
        _monthMeta,
        month.isAcceptableOrUnknown(data['month']!, _monthMeta),
      );
    } else if (isInserting) {
      context.missing(_monthMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('end_date')) {
      context.handle(
        _endDateMeta,
        endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta),
      );
    } else if (isInserting) {
      context.missing(_endDateMeta);
    }
    if (data.containsKey('is_closed')) {
      context.handle(
        _isClosedMeta,
        isClosed.isAcceptableOrUnknown(data['is_closed']!, _isClosedMeta),
      );
    }
    if (data.containsKey('closed_at')) {
      context.handle(
        _closedAtMeta,
        closedAt.isAcceptableOrUnknown(data['closed_at']!, _closedAtMeta),
      );
    }
    if (data.containsKey('income_budget_total')) {
      context.handle(
        _incomeBudgetTotalMeta,
        incomeBudgetTotal.isAcceptableOrUnknown(
          data['income_budget_total']!,
          _incomeBudgetTotalMeta,
        ),
      );
    }
    if (data.containsKey('income_actual_total')) {
      context.handle(
        _incomeActualTotalMeta,
        incomeActualTotal.isAcceptableOrUnknown(
          data['income_actual_total']!,
          _incomeActualTotalMeta,
        ),
      );
    }
    if (data.containsKey('extra_income_actual_total')) {
      context.handle(
        _extraIncomeActualTotalMeta,
        extraIncomeActualTotal.isAcceptableOrUnknown(
          data['extra_income_actual_total']!,
          _extraIncomeActualTotalMeta,
        ),
      );
    }
    if (data.containsKey('expense_budget_total')) {
      context.handle(
        _expenseBudgetTotalMeta,
        expenseBudgetTotal.isAcceptableOrUnknown(
          data['expense_budget_total']!,
          _expenseBudgetTotalMeta,
        ),
      );
    }
    if (data.containsKey('expense_actual_total')) {
      context.handle(
        _expenseActualTotalMeta,
        expenseActualTotal.isAcceptableOrUnknown(
          data['expense_actual_total']!,
          _expenseActualTotalMeta,
        ),
      );
    }
    if (data.containsKey('ant_expense_actual_total')) {
      context.handle(
        _antExpenseActualTotalMeta,
        antExpenseActualTotal.isAcceptableOrUnknown(
          data['ant_expense_actual_total']!,
          _antExpenseActualTotalMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {year, month},
  ];
  @override
  FinancialPeriod map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FinancialPeriod(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      year: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}year'],
      )!,
      month: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}month'],
      )!,
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_date'],
      )!,
      endDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_date'],
      )!,
      isClosed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_closed'],
      )!,
      closedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}closed_at'],
      ),
      incomeBudgetTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}income_budget_total'],
      )!,
      incomeActualTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}income_actual_total'],
      )!,
      extraIncomeActualTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}extra_income_actual_total'],
      )!,
      expenseBudgetTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}expense_budget_total'],
      )!,
      expenseActualTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}expense_actual_total'],
      )!,
      antExpenseActualTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ant_expense_actual_total'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $FinancialPeriodsTable createAlias(String alias) {
    return $FinancialPeriodsTable(attachedDatabase, alias);
  }
}

class FinancialPeriod extends DataClass implements Insertable<FinancialPeriod> {
  final String id;
  final int year;
  final int month;
  final DateTime startDate;
  final DateTime endDate;
  final bool isClosed;
  final DateTime? closedAt;
  final int incomeBudgetTotal;
  final int incomeActualTotal;
  final int extraIncomeActualTotal;
  final int expenseBudgetTotal;
  final int expenseActualTotal;
  final int antExpenseActualTotal;
  final DateTime createdAt;
  final DateTime updatedAt;
  const FinancialPeriod({
    required this.id,
    required this.year,
    required this.month,
    required this.startDate,
    required this.endDate,
    required this.isClosed,
    this.closedAt,
    required this.incomeBudgetTotal,
    required this.incomeActualTotal,
    required this.extraIncomeActualTotal,
    required this.expenseBudgetTotal,
    required this.expenseActualTotal,
    required this.antExpenseActualTotal,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['year'] = Variable<int>(year);
    map['month'] = Variable<int>(month);
    map['start_date'] = Variable<DateTime>(startDate);
    map['end_date'] = Variable<DateTime>(endDate);
    map['is_closed'] = Variable<bool>(isClosed);
    if (!nullToAbsent || closedAt != null) {
      map['closed_at'] = Variable<DateTime>(closedAt);
    }
    map['income_budget_total'] = Variable<int>(incomeBudgetTotal);
    map['income_actual_total'] = Variable<int>(incomeActualTotal);
    map['extra_income_actual_total'] = Variable<int>(extraIncomeActualTotal);
    map['expense_budget_total'] = Variable<int>(expenseBudgetTotal);
    map['expense_actual_total'] = Variable<int>(expenseActualTotal);
    map['ant_expense_actual_total'] = Variable<int>(antExpenseActualTotal);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  FinancialPeriodsCompanion toCompanion(bool nullToAbsent) {
    return FinancialPeriodsCompanion(
      id: Value(id),
      year: Value(year),
      month: Value(month),
      startDate: Value(startDate),
      endDate: Value(endDate),
      isClosed: Value(isClosed),
      closedAt: closedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(closedAt),
      incomeBudgetTotal: Value(incomeBudgetTotal),
      incomeActualTotal: Value(incomeActualTotal),
      extraIncomeActualTotal: Value(extraIncomeActualTotal),
      expenseBudgetTotal: Value(expenseBudgetTotal),
      expenseActualTotal: Value(expenseActualTotal),
      antExpenseActualTotal: Value(antExpenseActualTotal),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory FinancialPeriod.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FinancialPeriod(
      id: serializer.fromJson<String>(json['id']),
      year: serializer.fromJson<int>(json['year']),
      month: serializer.fromJson<int>(json['month']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      endDate: serializer.fromJson<DateTime>(json['endDate']),
      isClosed: serializer.fromJson<bool>(json['isClosed']),
      closedAt: serializer.fromJson<DateTime?>(json['closedAt']),
      incomeBudgetTotal: serializer.fromJson<int>(json['incomeBudgetTotal']),
      incomeActualTotal: serializer.fromJson<int>(json['incomeActualTotal']),
      extraIncomeActualTotal: serializer.fromJson<int>(
        json['extraIncomeActualTotal'],
      ),
      expenseBudgetTotal: serializer.fromJson<int>(json['expenseBudgetTotal']),
      expenseActualTotal: serializer.fromJson<int>(json['expenseActualTotal']),
      antExpenseActualTotal: serializer.fromJson<int>(
        json['antExpenseActualTotal'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'year': serializer.toJson<int>(year),
      'month': serializer.toJson<int>(month),
      'startDate': serializer.toJson<DateTime>(startDate),
      'endDate': serializer.toJson<DateTime>(endDate),
      'isClosed': serializer.toJson<bool>(isClosed),
      'closedAt': serializer.toJson<DateTime?>(closedAt),
      'incomeBudgetTotal': serializer.toJson<int>(incomeBudgetTotal),
      'incomeActualTotal': serializer.toJson<int>(incomeActualTotal),
      'extraIncomeActualTotal': serializer.toJson<int>(extraIncomeActualTotal),
      'expenseBudgetTotal': serializer.toJson<int>(expenseBudgetTotal),
      'expenseActualTotal': serializer.toJson<int>(expenseActualTotal),
      'antExpenseActualTotal': serializer.toJson<int>(antExpenseActualTotal),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  FinancialPeriod copyWith({
    String? id,
    int? year,
    int? month,
    DateTime? startDate,
    DateTime? endDate,
    bool? isClosed,
    Value<DateTime?> closedAt = const Value.absent(),
    int? incomeBudgetTotal,
    int? incomeActualTotal,
    int? extraIncomeActualTotal,
    int? expenseBudgetTotal,
    int? expenseActualTotal,
    int? antExpenseActualTotal,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => FinancialPeriod(
    id: id ?? this.id,
    year: year ?? this.year,
    month: month ?? this.month,
    startDate: startDate ?? this.startDate,
    endDate: endDate ?? this.endDate,
    isClosed: isClosed ?? this.isClosed,
    closedAt: closedAt.present ? closedAt.value : this.closedAt,
    incomeBudgetTotal: incomeBudgetTotal ?? this.incomeBudgetTotal,
    incomeActualTotal: incomeActualTotal ?? this.incomeActualTotal,
    extraIncomeActualTotal:
        extraIncomeActualTotal ?? this.extraIncomeActualTotal,
    expenseBudgetTotal: expenseBudgetTotal ?? this.expenseBudgetTotal,
    expenseActualTotal: expenseActualTotal ?? this.expenseActualTotal,
    antExpenseActualTotal: antExpenseActualTotal ?? this.antExpenseActualTotal,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  FinancialPeriod copyWithCompanion(FinancialPeriodsCompanion data) {
    return FinancialPeriod(
      id: data.id.present ? data.id.value : this.id,
      year: data.year.present ? data.year.value : this.year,
      month: data.month.present ? data.month.value : this.month,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      isClosed: data.isClosed.present ? data.isClosed.value : this.isClosed,
      closedAt: data.closedAt.present ? data.closedAt.value : this.closedAt,
      incomeBudgetTotal: data.incomeBudgetTotal.present
          ? data.incomeBudgetTotal.value
          : this.incomeBudgetTotal,
      incomeActualTotal: data.incomeActualTotal.present
          ? data.incomeActualTotal.value
          : this.incomeActualTotal,
      extraIncomeActualTotal: data.extraIncomeActualTotal.present
          ? data.extraIncomeActualTotal.value
          : this.extraIncomeActualTotal,
      expenseBudgetTotal: data.expenseBudgetTotal.present
          ? data.expenseBudgetTotal.value
          : this.expenseBudgetTotal,
      expenseActualTotal: data.expenseActualTotal.present
          ? data.expenseActualTotal.value
          : this.expenseActualTotal,
      antExpenseActualTotal: data.antExpenseActualTotal.present
          ? data.antExpenseActualTotal.value
          : this.antExpenseActualTotal,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FinancialPeriod(')
          ..write('id: $id, ')
          ..write('year: $year, ')
          ..write('month: $month, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('isClosed: $isClosed, ')
          ..write('closedAt: $closedAt, ')
          ..write('incomeBudgetTotal: $incomeBudgetTotal, ')
          ..write('incomeActualTotal: $incomeActualTotal, ')
          ..write('extraIncomeActualTotal: $extraIncomeActualTotal, ')
          ..write('expenseBudgetTotal: $expenseBudgetTotal, ')
          ..write('expenseActualTotal: $expenseActualTotal, ')
          ..write('antExpenseActualTotal: $antExpenseActualTotal, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    year,
    month,
    startDate,
    endDate,
    isClosed,
    closedAt,
    incomeBudgetTotal,
    incomeActualTotal,
    extraIncomeActualTotal,
    expenseBudgetTotal,
    expenseActualTotal,
    antExpenseActualTotal,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FinancialPeriod &&
          other.id == this.id &&
          other.year == this.year &&
          other.month == this.month &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.isClosed == this.isClosed &&
          other.closedAt == this.closedAt &&
          other.incomeBudgetTotal == this.incomeBudgetTotal &&
          other.incomeActualTotal == this.incomeActualTotal &&
          other.extraIncomeActualTotal == this.extraIncomeActualTotal &&
          other.expenseBudgetTotal == this.expenseBudgetTotal &&
          other.expenseActualTotal == this.expenseActualTotal &&
          other.antExpenseActualTotal == this.antExpenseActualTotal &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class FinancialPeriodsCompanion extends UpdateCompanion<FinancialPeriod> {
  final Value<String> id;
  final Value<int> year;
  final Value<int> month;
  final Value<DateTime> startDate;
  final Value<DateTime> endDate;
  final Value<bool> isClosed;
  final Value<DateTime?> closedAt;
  final Value<int> incomeBudgetTotal;
  final Value<int> incomeActualTotal;
  final Value<int> extraIncomeActualTotal;
  final Value<int> expenseBudgetTotal;
  final Value<int> expenseActualTotal;
  final Value<int> antExpenseActualTotal;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const FinancialPeriodsCompanion({
    this.id = const Value.absent(),
    this.year = const Value.absent(),
    this.month = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.isClosed = const Value.absent(),
    this.closedAt = const Value.absent(),
    this.incomeBudgetTotal = const Value.absent(),
    this.incomeActualTotal = const Value.absent(),
    this.extraIncomeActualTotal = const Value.absent(),
    this.expenseBudgetTotal = const Value.absent(),
    this.expenseActualTotal = const Value.absent(),
    this.antExpenseActualTotal = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FinancialPeriodsCompanion.insert({
    required String id,
    required int year,
    required int month,
    required DateTime startDate,
    required DateTime endDate,
    this.isClosed = const Value.absent(),
    this.closedAt = const Value.absent(),
    this.incomeBudgetTotal = const Value.absent(),
    this.incomeActualTotal = const Value.absent(),
    this.extraIncomeActualTotal = const Value.absent(),
    this.expenseBudgetTotal = const Value.absent(),
    this.expenseActualTotal = const Value.absent(),
    this.antExpenseActualTotal = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       year = Value(year),
       month = Value(month),
       startDate = Value(startDate),
       endDate = Value(endDate),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<FinancialPeriod> custom({
    Expression<String>? id,
    Expression<int>? year,
    Expression<int>? month,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<bool>? isClosed,
    Expression<DateTime>? closedAt,
    Expression<int>? incomeBudgetTotal,
    Expression<int>? incomeActualTotal,
    Expression<int>? extraIncomeActualTotal,
    Expression<int>? expenseBudgetTotal,
    Expression<int>? expenseActualTotal,
    Expression<int>? antExpenseActualTotal,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (year != null) 'year': year,
      if (month != null) 'month': month,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (isClosed != null) 'is_closed': isClosed,
      if (closedAt != null) 'closed_at': closedAt,
      if (incomeBudgetTotal != null) 'income_budget_total': incomeBudgetTotal,
      if (incomeActualTotal != null) 'income_actual_total': incomeActualTotal,
      if (extraIncomeActualTotal != null)
        'extra_income_actual_total': extraIncomeActualTotal,
      if (expenseBudgetTotal != null)
        'expense_budget_total': expenseBudgetTotal,
      if (expenseActualTotal != null)
        'expense_actual_total': expenseActualTotal,
      if (antExpenseActualTotal != null)
        'ant_expense_actual_total': antExpenseActualTotal,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FinancialPeriodsCompanion copyWith({
    Value<String>? id,
    Value<int>? year,
    Value<int>? month,
    Value<DateTime>? startDate,
    Value<DateTime>? endDate,
    Value<bool>? isClosed,
    Value<DateTime?>? closedAt,
    Value<int>? incomeBudgetTotal,
    Value<int>? incomeActualTotal,
    Value<int>? extraIncomeActualTotal,
    Value<int>? expenseBudgetTotal,
    Value<int>? expenseActualTotal,
    Value<int>? antExpenseActualTotal,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return FinancialPeriodsCompanion(
      id: id ?? this.id,
      year: year ?? this.year,
      month: month ?? this.month,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isClosed: isClosed ?? this.isClosed,
      closedAt: closedAt ?? this.closedAt,
      incomeBudgetTotal: incomeBudgetTotal ?? this.incomeBudgetTotal,
      incomeActualTotal: incomeActualTotal ?? this.incomeActualTotal,
      extraIncomeActualTotal:
          extraIncomeActualTotal ?? this.extraIncomeActualTotal,
      expenseBudgetTotal: expenseBudgetTotal ?? this.expenseBudgetTotal,
      expenseActualTotal: expenseActualTotal ?? this.expenseActualTotal,
      antExpenseActualTotal:
          antExpenseActualTotal ?? this.antExpenseActualTotal,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (year.present) {
      map['year'] = Variable<int>(year.value);
    }
    if (month.present) {
      map['month'] = Variable<int>(month.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (isClosed.present) {
      map['is_closed'] = Variable<bool>(isClosed.value);
    }
    if (closedAt.present) {
      map['closed_at'] = Variable<DateTime>(closedAt.value);
    }
    if (incomeBudgetTotal.present) {
      map['income_budget_total'] = Variable<int>(incomeBudgetTotal.value);
    }
    if (incomeActualTotal.present) {
      map['income_actual_total'] = Variable<int>(incomeActualTotal.value);
    }
    if (extraIncomeActualTotal.present) {
      map['extra_income_actual_total'] = Variable<int>(
        extraIncomeActualTotal.value,
      );
    }
    if (expenseBudgetTotal.present) {
      map['expense_budget_total'] = Variable<int>(expenseBudgetTotal.value);
    }
    if (expenseActualTotal.present) {
      map['expense_actual_total'] = Variable<int>(expenseActualTotal.value);
    }
    if (antExpenseActualTotal.present) {
      map['ant_expense_actual_total'] = Variable<int>(
        antExpenseActualTotal.value,
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FinancialPeriodsCompanion(')
          ..write('id: $id, ')
          ..write('year: $year, ')
          ..write('month: $month, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('isClosed: $isClosed, ')
          ..write('closedAt: $closedAt, ')
          ..write('incomeBudgetTotal: $incomeBudgetTotal, ')
          ..write('incomeActualTotal: $incomeActualTotal, ')
          ..write('extraIncomeActualTotal: $extraIncomeActualTotal, ')
          ..write('expenseBudgetTotal: $expenseBudgetTotal, ')
          ..write('expenseActualTotal: $expenseActualTotal, ')
          ..write('antExpenseActualTotal: $antExpenseActualTotal, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, Category> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 36,
      maxTextLength: 36,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 60,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isIncomeMeta = const VerificationMeta(
    'isIncome',
  );
  @override
  late final GeneratedColumn<bool> isIncome = GeneratedColumn<bool>(
    'is_income',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_income" IN (0, 1))',
    ),
  );
  static const VerificationMeta _isFixedMeta = const VerificationMeta(
    'isFixed',
  );
  @override
  late final GeneratedColumn<bool> isFixed = GeneratedColumn<bool>(
    'is_fixed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_fixed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isAntExpenseMeta = const VerificationMeta(
    'isAntExpense',
  );
  @override
  late final GeneratedColumn<bool> isAntExpense = GeneratedColumn<bool>(
    'is_ant_expense',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_ant_expense" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _iconKeyMeta = const VerificationMeta(
    'iconKey',
  );
  @override
  late final GeneratedColumn<String> iconKey = GeneratedColumn<String>(
    'icon_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('category'),
  );
  static const VerificationMeta _colorHexMeta = const VerificationMeta(
    'colorHex',
  );
  @override
  late final GeneratedColumn<String> colorHex = GeneratedColumn<String>(
    'color_hex',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('#1E6FD9'),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isArchivedMeta = const VerificationMeta(
    'isArchived',
  );
  @override
  late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>(
    'is_archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isDefaultMeta = const VerificationMeta(
    'isDefault',
  );
  @override
  late final GeneratedColumn<bool> isDefault = GeneratedColumn<bool>(
    'is_default',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_default" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    isIncome,
    isFixed,
    isAntExpense,
    iconKey,
    colorHex,
    sortOrder,
    isArchived,
    isDefault,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<Category> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('is_income')) {
      context.handle(
        _isIncomeMeta,
        isIncome.isAcceptableOrUnknown(data['is_income']!, _isIncomeMeta),
      );
    } else if (isInserting) {
      context.missing(_isIncomeMeta);
    }
    if (data.containsKey('is_fixed')) {
      context.handle(
        _isFixedMeta,
        isFixed.isAcceptableOrUnknown(data['is_fixed']!, _isFixedMeta),
      );
    }
    if (data.containsKey('is_ant_expense')) {
      context.handle(
        _isAntExpenseMeta,
        isAntExpense.isAcceptableOrUnknown(
          data['is_ant_expense']!,
          _isAntExpenseMeta,
        ),
      );
    }
    if (data.containsKey('icon_key')) {
      context.handle(
        _iconKeyMeta,
        iconKey.isAcceptableOrUnknown(data['icon_key']!, _iconKeyMeta),
      );
    }
    if (data.containsKey('color_hex')) {
      context.handle(
        _colorHexMeta,
        colorHex.isAcceptableOrUnknown(data['color_hex']!, _colorHexMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('is_archived')) {
      context.handle(
        _isArchivedMeta,
        isArchived.isAcceptableOrUnknown(data['is_archived']!, _isArchivedMeta),
      );
    }
    if (data.containsKey('is_default')) {
      context.handle(
        _isDefaultMeta,
        isDefault.isAcceptableOrUnknown(data['is_default']!, _isDefaultMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Category map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Category(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      isIncome: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_income'],
      )!,
      isFixed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_fixed'],
      )!,
      isAntExpense: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_ant_expense'],
      )!,
      iconKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon_key'],
      )!,
      colorHex: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color_hex'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      isArchived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_archived'],
      )!,
      isDefault: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_default'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(attachedDatabase, alias);
  }
}

class Category extends DataClass implements Insertable<Category> {
  final String id;
  final String name;
  final bool isIncome;

  /// Gasto fijo/recurrente (true) o variable (false). En ingresos:
  /// recurrente (true) o esporádico (false).
  final bool isFixed;

  /// Marca de gasto hormiga (solo gastos variables).
  final bool isAntExpense;
  final String iconKey;
  final String colorHex;
  final int sortOrder;
  final bool isArchived;
  final bool isDefault;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Category({
    required this.id,
    required this.name,
    required this.isIncome,
    required this.isFixed,
    required this.isAntExpense,
    required this.iconKey,
    required this.colorHex,
    required this.sortOrder,
    required this.isArchived,
    required this.isDefault,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['is_income'] = Variable<bool>(isIncome);
    map['is_fixed'] = Variable<bool>(isFixed);
    map['is_ant_expense'] = Variable<bool>(isAntExpense);
    map['icon_key'] = Variable<String>(iconKey);
    map['color_hex'] = Variable<String>(colorHex);
    map['sort_order'] = Variable<int>(sortOrder);
    map['is_archived'] = Variable<bool>(isArchived);
    map['is_default'] = Variable<bool>(isDefault);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: Value(id),
      name: Value(name),
      isIncome: Value(isIncome),
      isFixed: Value(isFixed),
      isAntExpense: Value(isAntExpense),
      iconKey: Value(iconKey),
      colorHex: Value(colorHex),
      sortOrder: Value(sortOrder),
      isArchived: Value(isArchived),
      isDefault: Value(isDefault),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Category.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Category(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      isIncome: serializer.fromJson<bool>(json['isIncome']),
      isFixed: serializer.fromJson<bool>(json['isFixed']),
      isAntExpense: serializer.fromJson<bool>(json['isAntExpense']),
      iconKey: serializer.fromJson<String>(json['iconKey']),
      colorHex: serializer.fromJson<String>(json['colorHex']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
      isDefault: serializer.fromJson<bool>(json['isDefault']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'isIncome': serializer.toJson<bool>(isIncome),
      'isFixed': serializer.toJson<bool>(isFixed),
      'isAntExpense': serializer.toJson<bool>(isAntExpense),
      'iconKey': serializer.toJson<String>(iconKey),
      'colorHex': serializer.toJson<String>(colorHex),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'isArchived': serializer.toJson<bool>(isArchived),
      'isDefault': serializer.toJson<bool>(isDefault),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Category copyWith({
    String? id,
    String? name,
    bool? isIncome,
    bool? isFixed,
    bool? isAntExpense,
    String? iconKey,
    String? colorHex,
    int? sortOrder,
    bool? isArchived,
    bool? isDefault,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Category(
    id: id ?? this.id,
    name: name ?? this.name,
    isIncome: isIncome ?? this.isIncome,
    isFixed: isFixed ?? this.isFixed,
    isAntExpense: isAntExpense ?? this.isAntExpense,
    iconKey: iconKey ?? this.iconKey,
    colorHex: colorHex ?? this.colorHex,
    sortOrder: sortOrder ?? this.sortOrder,
    isArchived: isArchived ?? this.isArchived,
    isDefault: isDefault ?? this.isDefault,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Category copyWithCompanion(CategoriesCompanion data) {
    return Category(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      isIncome: data.isIncome.present ? data.isIncome.value : this.isIncome,
      isFixed: data.isFixed.present ? data.isFixed.value : this.isFixed,
      isAntExpense: data.isAntExpense.present
          ? data.isAntExpense.value
          : this.isAntExpense,
      iconKey: data.iconKey.present ? data.iconKey.value : this.iconKey,
      colorHex: data.colorHex.present ? data.colorHex.value : this.colorHex,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      isArchived: data.isArchived.present
          ? data.isArchived.value
          : this.isArchived,
      isDefault: data.isDefault.present ? data.isDefault.value : this.isDefault,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Category(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('isIncome: $isIncome, ')
          ..write('isFixed: $isFixed, ')
          ..write('isAntExpense: $isAntExpense, ')
          ..write('iconKey: $iconKey, ')
          ..write('colorHex: $colorHex, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isArchived: $isArchived, ')
          ..write('isDefault: $isDefault, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    isIncome,
    isFixed,
    isAntExpense,
    iconKey,
    colorHex,
    sortOrder,
    isArchived,
    isDefault,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Category &&
          other.id == this.id &&
          other.name == this.name &&
          other.isIncome == this.isIncome &&
          other.isFixed == this.isFixed &&
          other.isAntExpense == this.isAntExpense &&
          other.iconKey == this.iconKey &&
          other.colorHex == this.colorHex &&
          other.sortOrder == this.sortOrder &&
          other.isArchived == this.isArchived &&
          other.isDefault == this.isDefault &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CategoriesCompanion extends UpdateCompanion<Category> {
  final Value<String> id;
  final Value<String> name;
  final Value<bool> isIncome;
  final Value<bool> isFixed;
  final Value<bool> isAntExpense;
  final Value<String> iconKey;
  final Value<String> colorHex;
  final Value<int> sortOrder;
  final Value<bool> isArchived;
  final Value<bool> isDefault;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.isIncome = const Value.absent(),
    this.isFixed = const Value.absent(),
    this.isAntExpense = const Value.absent(),
    this.iconKey = const Value.absent(),
    this.colorHex = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CategoriesCompanion.insert({
    required String id,
    required String name,
    required bool isIncome,
    this.isFixed = const Value.absent(),
    this.isAntExpense = const Value.absent(),
    this.iconKey = const Value.absent(),
    this.colorHex = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.isDefault = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       isIncome = Value(isIncome),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Category> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<bool>? isIncome,
    Expression<bool>? isFixed,
    Expression<bool>? isAntExpense,
    Expression<String>? iconKey,
    Expression<String>? colorHex,
    Expression<int>? sortOrder,
    Expression<bool>? isArchived,
    Expression<bool>? isDefault,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (isIncome != null) 'is_income': isIncome,
      if (isFixed != null) 'is_fixed': isFixed,
      if (isAntExpense != null) 'is_ant_expense': isAntExpense,
      if (iconKey != null) 'icon_key': iconKey,
      if (colorHex != null) 'color_hex': colorHex,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (isArchived != null) 'is_archived': isArchived,
      if (isDefault != null) 'is_default': isDefault,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CategoriesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<bool>? isIncome,
    Value<bool>? isFixed,
    Value<bool>? isAntExpense,
    Value<String>? iconKey,
    Value<String>? colorHex,
    Value<int>? sortOrder,
    Value<bool>? isArchived,
    Value<bool>? isDefault,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return CategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      isIncome: isIncome ?? this.isIncome,
      isFixed: isFixed ?? this.isFixed,
      isAntExpense: isAntExpense ?? this.isAntExpense,
      iconKey: iconKey ?? this.iconKey,
      colorHex: colorHex ?? this.colorHex,
      sortOrder: sortOrder ?? this.sortOrder,
      isArchived: isArchived ?? this.isArchived,
      isDefault: isDefault ?? this.isDefault,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
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
    if (isIncome.present) {
      map['is_income'] = Variable<bool>(isIncome.value);
    }
    if (isFixed.present) {
      map['is_fixed'] = Variable<bool>(isFixed.value);
    }
    if (isAntExpense.present) {
      map['is_ant_expense'] = Variable<bool>(isAntExpense.value);
    }
    if (iconKey.present) {
      map['icon_key'] = Variable<String>(iconKey.value);
    }
    if (colorHex.present) {
      map['color_hex'] = Variable<String>(colorHex.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
    }
    if (isDefault.present) {
      map['is_default'] = Variable<bool>(isDefault.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('isIncome: $isIncome, ')
          ..write('isFixed: $isFixed, ')
          ..write('isAntExpense: $isAntExpense, ')
          ..write('iconKey: $iconKey, ')
          ..write('colorHex: $colorHex, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isArchived: $isArchived, ')
          ..write('isDefault: $isDefault, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FinancialTransactionsTable extends FinancialTransactions
    with TableInfo<$FinancialTransactionsTable, FinancialTransaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FinancialTransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 36,
      maxTextLength: 36,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _periodIdMeta = const VerificationMeta(
    'periodId',
  );
  @override
  late final GeneratedColumn<String> periodId = GeneratedColumn<String>(
    'period_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES financial_periods (id)',
    ),
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES categories (id)',
    ),
  );
  static const VerificationMeta _isIncomeMeta = const VerificationMeta(
    'isIncome',
  );
  @override
  late final GeneratedColumn<bool> isIncome = GeneratedColumn<bool>(
    'is_income',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_income" IN (0, 1))',
    ),
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cutNumberMeta = const VerificationMeta(
    'cutNumber',
  );
  @override
  late final GeneratedColumn<int> cutNumber = GeneratedColumn<int>(
    'cut_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    periodId,
    categoryId,
    isIncome,
    amount,
    date,
    cutNumber,
    description,
    createdAt,
    updatedAt,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'financial_transactions';
  @override
  VerificationContext validateIntegrity(
    Insertable<FinancialTransaction> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('period_id')) {
      context.handle(
        _periodIdMeta,
        periodId.isAcceptableOrUnknown(data['period_id']!, _periodIdMeta),
      );
    } else if (isInserting) {
      context.missing(_periodIdMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('is_income')) {
      context.handle(
        _isIncomeMeta,
        isIncome.isAcceptableOrUnknown(data['is_income']!, _isIncomeMeta),
      );
    } else if (isInserting) {
      context.missing(_isIncomeMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('cut_number')) {
      context.handle(
        _cutNumberMeta,
        cutNumber.isAcceptableOrUnknown(data['cut_number']!, _cutNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_cutNumberMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FinancialTransaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FinancialTransaction(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      periodId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}period_id'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      )!,
      isIncome: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_income'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      cutNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cut_number'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $FinancialTransactionsTable createAlias(String alias) {
    return $FinancialTransactionsTable(attachedDatabase, alias);
  }
}

class FinancialTransaction extends DataClass
    implements Insertable<FinancialTransaction> {
  final String id;
  final String periodId;
  final String categoryId;

  /// Copia del tipo de la categoría, para consultas rápidas.
  final bool isIncome;

  /// Monto positivo en "centavos".
  final int amount;
  final DateTime date;

  /// 1 = primera quincena (día 1 al 15), 2 = resto del mes.
  final int cutNumber;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;

  /// Borrado lógico: si tiene fecha, el movimiento está eliminado.
  final DateTime? deletedAt;
  const FinancialTransaction({
    required this.id,
    required this.periodId,
    required this.categoryId,
    required this.isIncome,
    required this.amount,
    required this.date,
    required this.cutNumber,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['period_id'] = Variable<String>(periodId);
    map['category_id'] = Variable<String>(categoryId);
    map['is_income'] = Variable<bool>(isIncome);
    map['amount'] = Variable<int>(amount);
    map['date'] = Variable<DateTime>(date);
    map['cut_number'] = Variable<int>(cutNumber);
    map['description'] = Variable<String>(description);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  FinancialTransactionsCompanion toCompanion(bool nullToAbsent) {
    return FinancialTransactionsCompanion(
      id: Value(id),
      periodId: Value(periodId),
      categoryId: Value(categoryId),
      isIncome: Value(isIncome),
      amount: Value(amount),
      date: Value(date),
      cutNumber: Value(cutNumber),
      description: Value(description),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory FinancialTransaction.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FinancialTransaction(
      id: serializer.fromJson<String>(json['id']),
      periodId: serializer.fromJson<String>(json['periodId']),
      categoryId: serializer.fromJson<String>(json['categoryId']),
      isIncome: serializer.fromJson<bool>(json['isIncome']),
      amount: serializer.fromJson<int>(json['amount']),
      date: serializer.fromJson<DateTime>(json['date']),
      cutNumber: serializer.fromJson<int>(json['cutNumber']),
      description: serializer.fromJson<String>(json['description']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'periodId': serializer.toJson<String>(periodId),
      'categoryId': serializer.toJson<String>(categoryId),
      'isIncome': serializer.toJson<bool>(isIncome),
      'amount': serializer.toJson<int>(amount),
      'date': serializer.toJson<DateTime>(date),
      'cutNumber': serializer.toJson<int>(cutNumber),
      'description': serializer.toJson<String>(description),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  FinancialTransaction copyWith({
    String? id,
    String? periodId,
    String? categoryId,
    bool? isIncome,
    int? amount,
    DateTime? date,
    int? cutNumber,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
  }) => FinancialTransaction(
    id: id ?? this.id,
    periodId: periodId ?? this.periodId,
    categoryId: categoryId ?? this.categoryId,
    isIncome: isIncome ?? this.isIncome,
    amount: amount ?? this.amount,
    date: date ?? this.date,
    cutNumber: cutNumber ?? this.cutNumber,
    description: description ?? this.description,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  FinancialTransaction copyWithCompanion(FinancialTransactionsCompanion data) {
    return FinancialTransaction(
      id: data.id.present ? data.id.value : this.id,
      periodId: data.periodId.present ? data.periodId.value : this.periodId,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      isIncome: data.isIncome.present ? data.isIncome.value : this.isIncome,
      amount: data.amount.present ? data.amount.value : this.amount,
      date: data.date.present ? data.date.value : this.date,
      cutNumber: data.cutNumber.present ? data.cutNumber.value : this.cutNumber,
      description: data.description.present
          ? data.description.value
          : this.description,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FinancialTransaction(')
          ..write('id: $id, ')
          ..write('periodId: $periodId, ')
          ..write('categoryId: $categoryId, ')
          ..write('isIncome: $isIncome, ')
          ..write('amount: $amount, ')
          ..write('date: $date, ')
          ..write('cutNumber: $cutNumber, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    periodId,
    categoryId,
    isIncome,
    amount,
    date,
    cutNumber,
    description,
    createdAt,
    updatedAt,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FinancialTransaction &&
          other.id == this.id &&
          other.periodId == this.periodId &&
          other.categoryId == this.categoryId &&
          other.isIncome == this.isIncome &&
          other.amount == this.amount &&
          other.date == this.date &&
          other.cutNumber == this.cutNumber &&
          other.description == this.description &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class FinancialTransactionsCompanion
    extends UpdateCompanion<FinancialTransaction> {
  final Value<String> id;
  final Value<String> periodId;
  final Value<String> categoryId;
  final Value<bool> isIncome;
  final Value<int> amount;
  final Value<DateTime> date;
  final Value<int> cutNumber;
  final Value<String> description;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const FinancialTransactionsCompanion({
    this.id = const Value.absent(),
    this.periodId = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.isIncome = const Value.absent(),
    this.amount = const Value.absent(),
    this.date = const Value.absent(),
    this.cutNumber = const Value.absent(),
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FinancialTransactionsCompanion.insert({
    required String id,
    required String periodId,
    required String categoryId,
    required bool isIncome,
    required int amount,
    required DateTime date,
    required int cutNumber,
    this.description = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       periodId = Value(periodId),
       categoryId = Value(categoryId),
       isIncome = Value(isIncome),
       amount = Value(amount),
       date = Value(date),
       cutNumber = Value(cutNumber),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<FinancialTransaction> custom({
    Expression<String>? id,
    Expression<String>? periodId,
    Expression<String>? categoryId,
    Expression<bool>? isIncome,
    Expression<int>? amount,
    Expression<DateTime>? date,
    Expression<int>? cutNumber,
    Expression<String>? description,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (periodId != null) 'period_id': periodId,
      if (categoryId != null) 'category_id': categoryId,
      if (isIncome != null) 'is_income': isIncome,
      if (amount != null) 'amount': amount,
      if (date != null) 'date': date,
      if (cutNumber != null) 'cut_number': cutNumber,
      if (description != null) 'description': description,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FinancialTransactionsCompanion copyWith({
    Value<String>? id,
    Value<String>? periodId,
    Value<String>? categoryId,
    Value<bool>? isIncome,
    Value<int>? amount,
    Value<DateTime>? date,
    Value<int>? cutNumber,
    Value<String>? description,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<int>? rowid,
  }) {
    return FinancialTransactionsCompanion(
      id: id ?? this.id,
      periodId: periodId ?? this.periodId,
      categoryId: categoryId ?? this.categoryId,
      isIncome: isIncome ?? this.isIncome,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      cutNumber: cutNumber ?? this.cutNumber,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (periodId.present) {
      map['period_id'] = Variable<String>(periodId.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (isIncome.present) {
      map['is_income'] = Variable<bool>(isIncome.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (cutNumber.present) {
      map['cut_number'] = Variable<int>(cutNumber.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
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
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FinancialTransactionsCompanion(')
          ..write('id: $id, ')
          ..write('periodId: $periodId, ')
          ..write('categoryId: $categoryId, ')
          ..write('isIncome: $isIncome, ')
          ..write('amount: $amount, ')
          ..write('date: $date, ')
          ..write('cutNumber: $cutNumber, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BudgetItemsTable extends BudgetItems
    with TableInfo<$BudgetItemsTable, BudgetItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BudgetItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 36,
      maxTextLength: 36,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _periodIdMeta = const VerificationMeta(
    'periodId',
  );
  @override
  late final GeneratedColumn<String> periodId = GeneratedColumn<String>(
    'period_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES financial_periods (id)',
    ),
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES categories (id)',
    ),
  );
  static const VerificationMeta _cutNumberMeta = const VerificationMeta(
    'cutNumber',
  );
  @override
  late final GeneratedColumn<int> cutNumber = GeneratedColumn<int>(
    'cut_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _amountLimitMeta = const VerificationMeta(
    'amountLimit',
  );
  @override
  late final GeneratedColumn<int> amountLimit = GeneratedColumn<int>(
    'amount_limit',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _alertPercentMeta = const VerificationMeta(
    'alertPercent',
  );
  @override
  late final GeneratedColumn<int> alertPercent = GeneratedColumn<int>(
    'alert_percent',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastAlertLevelMeta = const VerificationMeta(
    'lastAlertLevel',
  );
  @override
  late final GeneratedColumn<int> lastAlertLevel = GeneratedColumn<int>(
    'last_alert_level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    periodId,
    categoryId,
    cutNumber,
    amountLimit,
    alertPercent,
    lastAlertLevel,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'budget_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<BudgetItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('period_id')) {
      context.handle(
        _periodIdMeta,
        periodId.isAcceptableOrUnknown(data['period_id']!, _periodIdMeta),
      );
    } else if (isInserting) {
      context.missing(_periodIdMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('cut_number')) {
      context.handle(
        _cutNumberMeta,
        cutNumber.isAcceptableOrUnknown(data['cut_number']!, _cutNumberMeta),
      );
    }
    if (data.containsKey('amount_limit')) {
      context.handle(
        _amountLimitMeta,
        amountLimit.isAcceptableOrUnknown(
          data['amount_limit']!,
          _amountLimitMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountLimitMeta);
    }
    if (data.containsKey('alert_percent')) {
      context.handle(
        _alertPercentMeta,
        alertPercent.isAcceptableOrUnknown(
          data['alert_percent']!,
          _alertPercentMeta,
        ),
      );
    }
    if (data.containsKey('last_alert_level')) {
      context.handle(
        _lastAlertLevelMeta,
        lastAlertLevel.isAcceptableOrUnknown(
          data['last_alert_level']!,
          _lastAlertLevelMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {periodId, categoryId, cutNumber},
  ];
  @override
  BudgetItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BudgetItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      periodId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}period_id'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      )!,
      cutNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cut_number'],
      )!,
      amountLimit: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_limit'],
      )!,
      alertPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}alert_percent'],
      ),
      lastAlertLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_alert_level'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $BudgetItemsTable createAlias(String alias) {
    return $BudgetItemsTable(attachedDatabase, alias);
  }
}

class BudgetItem extends DataClass implements Insertable<BudgetItem> {
  final String id;
  final String periodId;
  final String categoryId;

  /// 0 = todo el mes, 1 = primera quincena, 2 = segunda.
  final int cutNumber;
  final int amountLimit;
  final int? alertPercent;

  /// 0 = sin alerta, 1 = advertencia, 2 = superado.
  final int lastAlertLevel;
  final DateTime createdAt;
  final DateTime updatedAt;
  const BudgetItem({
    required this.id,
    required this.periodId,
    required this.categoryId,
    required this.cutNumber,
    required this.amountLimit,
    this.alertPercent,
    required this.lastAlertLevel,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['period_id'] = Variable<String>(periodId);
    map['category_id'] = Variable<String>(categoryId);
    map['cut_number'] = Variable<int>(cutNumber);
    map['amount_limit'] = Variable<int>(amountLimit);
    if (!nullToAbsent || alertPercent != null) {
      map['alert_percent'] = Variable<int>(alertPercent);
    }
    map['last_alert_level'] = Variable<int>(lastAlertLevel);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  BudgetItemsCompanion toCompanion(bool nullToAbsent) {
    return BudgetItemsCompanion(
      id: Value(id),
      periodId: Value(periodId),
      categoryId: Value(categoryId),
      cutNumber: Value(cutNumber),
      amountLimit: Value(amountLimit),
      alertPercent: alertPercent == null && nullToAbsent
          ? const Value.absent()
          : Value(alertPercent),
      lastAlertLevel: Value(lastAlertLevel),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory BudgetItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BudgetItem(
      id: serializer.fromJson<String>(json['id']),
      periodId: serializer.fromJson<String>(json['periodId']),
      categoryId: serializer.fromJson<String>(json['categoryId']),
      cutNumber: serializer.fromJson<int>(json['cutNumber']),
      amountLimit: serializer.fromJson<int>(json['amountLimit']),
      alertPercent: serializer.fromJson<int?>(json['alertPercent']),
      lastAlertLevel: serializer.fromJson<int>(json['lastAlertLevel']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'periodId': serializer.toJson<String>(periodId),
      'categoryId': serializer.toJson<String>(categoryId),
      'cutNumber': serializer.toJson<int>(cutNumber),
      'amountLimit': serializer.toJson<int>(amountLimit),
      'alertPercent': serializer.toJson<int?>(alertPercent),
      'lastAlertLevel': serializer.toJson<int>(lastAlertLevel),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  BudgetItem copyWith({
    String? id,
    String? periodId,
    String? categoryId,
    int? cutNumber,
    int? amountLimit,
    Value<int?> alertPercent = const Value.absent(),
    int? lastAlertLevel,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => BudgetItem(
    id: id ?? this.id,
    periodId: periodId ?? this.periodId,
    categoryId: categoryId ?? this.categoryId,
    cutNumber: cutNumber ?? this.cutNumber,
    amountLimit: amountLimit ?? this.amountLimit,
    alertPercent: alertPercent.present ? alertPercent.value : this.alertPercent,
    lastAlertLevel: lastAlertLevel ?? this.lastAlertLevel,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  BudgetItem copyWithCompanion(BudgetItemsCompanion data) {
    return BudgetItem(
      id: data.id.present ? data.id.value : this.id,
      periodId: data.periodId.present ? data.periodId.value : this.periodId,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      cutNumber: data.cutNumber.present ? data.cutNumber.value : this.cutNumber,
      amountLimit: data.amountLimit.present
          ? data.amountLimit.value
          : this.amountLimit,
      alertPercent: data.alertPercent.present
          ? data.alertPercent.value
          : this.alertPercent,
      lastAlertLevel: data.lastAlertLevel.present
          ? data.lastAlertLevel.value
          : this.lastAlertLevel,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BudgetItem(')
          ..write('id: $id, ')
          ..write('periodId: $periodId, ')
          ..write('categoryId: $categoryId, ')
          ..write('cutNumber: $cutNumber, ')
          ..write('amountLimit: $amountLimit, ')
          ..write('alertPercent: $alertPercent, ')
          ..write('lastAlertLevel: $lastAlertLevel, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    periodId,
    categoryId,
    cutNumber,
    amountLimit,
    alertPercent,
    lastAlertLevel,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BudgetItem &&
          other.id == this.id &&
          other.periodId == this.periodId &&
          other.categoryId == this.categoryId &&
          other.cutNumber == this.cutNumber &&
          other.amountLimit == this.amountLimit &&
          other.alertPercent == this.alertPercent &&
          other.lastAlertLevel == this.lastAlertLevel &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class BudgetItemsCompanion extends UpdateCompanion<BudgetItem> {
  final Value<String> id;
  final Value<String> periodId;
  final Value<String> categoryId;
  final Value<int> cutNumber;
  final Value<int> amountLimit;
  final Value<int?> alertPercent;
  final Value<int> lastAlertLevel;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const BudgetItemsCompanion({
    this.id = const Value.absent(),
    this.periodId = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.cutNumber = const Value.absent(),
    this.amountLimit = const Value.absent(),
    this.alertPercent = const Value.absent(),
    this.lastAlertLevel = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BudgetItemsCompanion.insert({
    required String id,
    required String periodId,
    required String categoryId,
    this.cutNumber = const Value.absent(),
    required int amountLimit,
    this.alertPercent = const Value.absent(),
    this.lastAlertLevel = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       periodId = Value(periodId),
       categoryId = Value(categoryId),
       amountLimit = Value(amountLimit),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<BudgetItem> custom({
    Expression<String>? id,
    Expression<String>? periodId,
    Expression<String>? categoryId,
    Expression<int>? cutNumber,
    Expression<int>? amountLimit,
    Expression<int>? alertPercent,
    Expression<int>? lastAlertLevel,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (periodId != null) 'period_id': periodId,
      if (categoryId != null) 'category_id': categoryId,
      if (cutNumber != null) 'cut_number': cutNumber,
      if (amountLimit != null) 'amount_limit': amountLimit,
      if (alertPercent != null) 'alert_percent': alertPercent,
      if (lastAlertLevel != null) 'last_alert_level': lastAlertLevel,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BudgetItemsCompanion copyWith({
    Value<String>? id,
    Value<String>? periodId,
    Value<String>? categoryId,
    Value<int>? cutNumber,
    Value<int>? amountLimit,
    Value<int?>? alertPercent,
    Value<int>? lastAlertLevel,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return BudgetItemsCompanion(
      id: id ?? this.id,
      periodId: periodId ?? this.periodId,
      categoryId: categoryId ?? this.categoryId,
      cutNumber: cutNumber ?? this.cutNumber,
      amountLimit: amountLimit ?? this.amountLimit,
      alertPercent: alertPercent ?? this.alertPercent,
      lastAlertLevel: lastAlertLevel ?? this.lastAlertLevel,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (periodId.present) {
      map['period_id'] = Variable<String>(periodId.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (cutNumber.present) {
      map['cut_number'] = Variable<int>(cutNumber.value);
    }
    if (amountLimit.present) {
      map['amount_limit'] = Variable<int>(amountLimit.value);
    }
    if (alertPercent.present) {
      map['alert_percent'] = Variable<int>(alertPercent.value);
    }
    if (lastAlertLevel.present) {
      map['last_alert_level'] = Variable<int>(lastAlertLevel.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BudgetItemsCompanion(')
          ..write('id: $id, ')
          ..write('periodId: $periodId, ')
          ..write('categoryId: $categoryId, ')
          ..write('cutNumber: $cutNumber, ')
          ..write('amountLimit: $amountLimit, ')
          ..write('alertPercent: $alertPercent, ')
          ..write('lastAlertLevel: $lastAlertLevel, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CategoryPeriodTotalsTable extends CategoryPeriodTotals
    with TableInfo<$CategoryPeriodTotalsTable, CategoryPeriodTotal> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoryPeriodTotalsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _periodIdMeta = const VerificationMeta(
    'periodId',
  );
  @override
  late final GeneratedColumn<String> periodId = GeneratedColumn<String>(
    'period_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES financial_periods (id)',
    ),
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES categories (id)',
    ),
  );
  static const VerificationMeta _cutNumberMeta = const VerificationMeta(
    'cutNumber',
  );
  @override
  late final GeneratedColumn<int> cutNumber = GeneratedColumn<int>(
    'cut_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _actualTotalMeta = const VerificationMeta(
    'actualTotal',
  );
  @override
  late final GeneratedColumn<int> actualTotal = GeneratedColumn<int>(
    'actual_total',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _txCountMeta = const VerificationMeta(
    'txCount',
  );
  @override
  late final GeneratedColumn<int> txCount = GeneratedColumn<int>(
    'tx_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    periodId,
    categoryId,
    cutNumber,
    actualTotal,
    txCount,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'category_period_totals';
  @override
  VerificationContext validateIntegrity(
    Insertable<CategoryPeriodTotal> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('period_id')) {
      context.handle(
        _periodIdMeta,
        periodId.isAcceptableOrUnknown(data['period_id']!, _periodIdMeta),
      );
    } else if (isInserting) {
      context.missing(_periodIdMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('cut_number')) {
      context.handle(
        _cutNumberMeta,
        cutNumber.isAcceptableOrUnknown(data['cut_number']!, _cutNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_cutNumberMeta);
    }
    if (data.containsKey('actual_total')) {
      context.handle(
        _actualTotalMeta,
        actualTotal.isAcceptableOrUnknown(
          data['actual_total']!,
          _actualTotalMeta,
        ),
      );
    }
    if (data.containsKey('tx_count')) {
      context.handle(
        _txCountMeta,
        txCount.isAcceptableOrUnknown(data['tx_count']!, _txCountMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {periodId, categoryId, cutNumber};
  @override
  CategoryPeriodTotal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoryPeriodTotal(
      periodId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}period_id'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      )!,
      cutNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cut_number'],
      )!,
      actualTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}actual_total'],
      )!,
      txCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tx_count'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $CategoryPeriodTotalsTable createAlias(String alias) {
    return $CategoryPeriodTotalsTable(attachedDatabase, alias);
  }
}

class CategoryPeriodTotal extends DataClass
    implements Insertable<CategoryPeriodTotal> {
  final String periodId;
  final String categoryId;
  final int cutNumber;
  final int actualTotal;
  final int txCount;
  final DateTime updatedAt;
  const CategoryPeriodTotal({
    required this.periodId,
    required this.categoryId,
    required this.cutNumber,
    required this.actualTotal,
    required this.txCount,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['period_id'] = Variable<String>(periodId);
    map['category_id'] = Variable<String>(categoryId);
    map['cut_number'] = Variable<int>(cutNumber);
    map['actual_total'] = Variable<int>(actualTotal);
    map['tx_count'] = Variable<int>(txCount);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CategoryPeriodTotalsCompanion toCompanion(bool nullToAbsent) {
    return CategoryPeriodTotalsCompanion(
      periodId: Value(periodId),
      categoryId: Value(categoryId),
      cutNumber: Value(cutNumber),
      actualTotal: Value(actualTotal),
      txCount: Value(txCount),
      updatedAt: Value(updatedAt),
    );
  }

  factory CategoryPeriodTotal.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoryPeriodTotal(
      periodId: serializer.fromJson<String>(json['periodId']),
      categoryId: serializer.fromJson<String>(json['categoryId']),
      cutNumber: serializer.fromJson<int>(json['cutNumber']),
      actualTotal: serializer.fromJson<int>(json['actualTotal']),
      txCount: serializer.fromJson<int>(json['txCount']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'periodId': serializer.toJson<String>(periodId),
      'categoryId': serializer.toJson<String>(categoryId),
      'cutNumber': serializer.toJson<int>(cutNumber),
      'actualTotal': serializer.toJson<int>(actualTotal),
      'txCount': serializer.toJson<int>(txCount),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CategoryPeriodTotal copyWith({
    String? periodId,
    String? categoryId,
    int? cutNumber,
    int? actualTotal,
    int? txCount,
    DateTime? updatedAt,
  }) => CategoryPeriodTotal(
    periodId: periodId ?? this.periodId,
    categoryId: categoryId ?? this.categoryId,
    cutNumber: cutNumber ?? this.cutNumber,
    actualTotal: actualTotal ?? this.actualTotal,
    txCount: txCount ?? this.txCount,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  CategoryPeriodTotal copyWithCompanion(CategoryPeriodTotalsCompanion data) {
    return CategoryPeriodTotal(
      periodId: data.periodId.present ? data.periodId.value : this.periodId,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      cutNumber: data.cutNumber.present ? data.cutNumber.value : this.cutNumber,
      actualTotal: data.actualTotal.present
          ? data.actualTotal.value
          : this.actualTotal,
      txCount: data.txCount.present ? data.txCount.value : this.txCount,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CategoryPeriodTotal(')
          ..write('periodId: $periodId, ')
          ..write('categoryId: $categoryId, ')
          ..write('cutNumber: $cutNumber, ')
          ..write('actualTotal: $actualTotal, ')
          ..write('txCount: $txCount, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    periodId,
    categoryId,
    cutNumber,
    actualTotal,
    txCount,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoryPeriodTotal &&
          other.periodId == this.periodId &&
          other.categoryId == this.categoryId &&
          other.cutNumber == this.cutNumber &&
          other.actualTotal == this.actualTotal &&
          other.txCount == this.txCount &&
          other.updatedAt == this.updatedAt);
}

class CategoryPeriodTotalsCompanion
    extends UpdateCompanion<CategoryPeriodTotal> {
  final Value<String> periodId;
  final Value<String> categoryId;
  final Value<int> cutNumber;
  final Value<int> actualTotal;
  final Value<int> txCount;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const CategoryPeriodTotalsCompanion({
    this.periodId = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.cutNumber = const Value.absent(),
    this.actualTotal = const Value.absent(),
    this.txCount = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CategoryPeriodTotalsCompanion.insert({
    required String periodId,
    required String categoryId,
    required int cutNumber,
    this.actualTotal = const Value.absent(),
    this.txCount = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : periodId = Value(periodId),
       categoryId = Value(categoryId),
       cutNumber = Value(cutNumber),
       updatedAt = Value(updatedAt);
  static Insertable<CategoryPeriodTotal> custom({
    Expression<String>? periodId,
    Expression<String>? categoryId,
    Expression<int>? cutNumber,
    Expression<int>? actualTotal,
    Expression<int>? txCount,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (periodId != null) 'period_id': periodId,
      if (categoryId != null) 'category_id': categoryId,
      if (cutNumber != null) 'cut_number': cutNumber,
      if (actualTotal != null) 'actual_total': actualTotal,
      if (txCount != null) 'tx_count': txCount,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CategoryPeriodTotalsCompanion copyWith({
    Value<String>? periodId,
    Value<String>? categoryId,
    Value<int>? cutNumber,
    Value<int>? actualTotal,
    Value<int>? txCount,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return CategoryPeriodTotalsCompanion(
      periodId: periodId ?? this.periodId,
      categoryId: categoryId ?? this.categoryId,
      cutNumber: cutNumber ?? this.cutNumber,
      actualTotal: actualTotal ?? this.actualTotal,
      txCount: txCount ?? this.txCount,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (periodId.present) {
      map['period_id'] = Variable<String>(periodId.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (cutNumber.present) {
      map['cut_number'] = Variable<int>(cutNumber.value);
    }
    if (actualTotal.present) {
      map['actual_total'] = Variable<int>(actualTotal.value);
    }
    if (txCount.present) {
      map['tx_count'] = Variable<int>(txCount.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoryPeriodTotalsCompanion(')
          ..write('periodId: $periodId, ')
          ..write('categoryId: $categoryId, ')
          ..write('cutNumber: $cutNumber, ')
          ..write('actualTotal: $actualTotal, ')
          ..write('txCount: $txCount, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  late final $FinancialPeriodsTable financialPeriods = $FinancialPeriodsTable(
    this,
  );
  late final $CategoriesTable categories = $CategoriesTable(this);
  late final $FinancialTransactionsTable financialTransactions =
      $FinancialTransactionsTable(this);
  late final $BudgetItemsTable budgetItems = $BudgetItemsTable(this);
  late final $CategoryPeriodTotalsTable categoryPeriodTotals =
      $CategoryPeriodTotalsTable(this);
  late final Index idxTransactionsPeriodDate = Index(
    'idx_transactions_period_date',
    'CREATE INDEX idx_transactions_period_date ON financial_transactions (period_id, date)',
  );
  late final Index idxTransactionsPeriodCategory = Index(
    'idx_transactions_period_category',
    'CREATE INDEX idx_transactions_period_category ON financial_transactions (period_id, category_id)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    appSettings,
    financialPeriods,
    categories,
    financialTransactions,
    budgetItems,
    categoryPeriodTotals,
    idxTransactionsPeriodDate,
    idxTransactionsPeriodCategory,
  ];
}

typedef $$AppSettingsTableCreateCompanionBuilder =
    AppSettingsCompanion Function({
      required String id,
      Value<String?> displayName,
      Value<String> currencyCode,
      Value<String> locale,
      Value<int> defaultAlertPercent,
      Value<bool> notificationsEnabled,
      Value<bool> onboardingCompleted,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$AppSettingsTableUpdateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<String> id,
      Value<String?> displayName,
      Value<String> currencyCode,
      Value<String> locale,
      Value<int> defaultAlertPercent,
      Value<bool> notificationsEnabled,
      Value<bool> onboardingCompleted,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
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
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get locale => $composableBuilder(
    column: $table.locale,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get defaultAlertPercent => $composableBuilder(
    column: $table.defaultAlertPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get notificationsEnabled => $composableBuilder(
    column: $table.notificationsEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get onboardingCompleted => $composableBuilder(
    column: $table.onboardingCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
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
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get locale => $composableBuilder(
    column: $table.locale,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get defaultAlertPercent => $composableBuilder(
    column: $table.defaultAlertPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get notificationsEnabled => $composableBuilder(
    column: $table.notificationsEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get onboardingCompleted => $composableBuilder(
    column: $table.onboardingCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
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
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get locale =>
      $composableBuilder(column: $table.locale, builder: (column) => column);

  GeneratedColumn<int> get defaultAlertPercent => $composableBuilder(
    column: $table.defaultAlertPercent,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get notificationsEnabled => $composableBuilder(
    column: $table.notificationsEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get onboardingCompleted => $composableBuilder(
    column: $table.onboardingCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$AppSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppSettingsTable,
          AppSettingsData,
          $$AppSettingsTableFilterComposer,
          $$AppSettingsTableOrderingComposer,
          $$AppSettingsTableAnnotationComposer,
          $$AppSettingsTableCreateCompanionBuilder,
          $$AppSettingsTableUpdateCompanionBuilder,
          (
            AppSettingsData,
            BaseReferences<_$AppDatabase, $AppSettingsTable, AppSettingsData>,
          ),
          AppSettingsData,
          PrefetchHooks Function()
        > {
  $$AppSettingsTableTableManager(_$AppDatabase db, $AppSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> displayName = const Value.absent(),
                Value<String> currencyCode = const Value.absent(),
                Value<String> locale = const Value.absent(),
                Value<int> defaultAlertPercent = const Value.absent(),
                Value<bool> notificationsEnabled = const Value.absent(),
                Value<bool> onboardingCompleted = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsCompanion(
                id: id,
                displayName: displayName,
                currencyCode: currencyCode,
                locale: locale,
                defaultAlertPercent: defaultAlertPercent,
                notificationsEnabled: notificationsEnabled,
                onboardingCompleted: onboardingCompleted,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> displayName = const Value.absent(),
                Value<String> currencyCode = const Value.absent(),
                Value<String> locale = const Value.absent(),
                Value<int> defaultAlertPercent = const Value.absent(),
                Value<bool> notificationsEnabled = const Value.absent(),
                Value<bool> onboardingCompleted = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsCompanion.insert(
                id: id,
                displayName: displayName,
                currencyCode: currencyCode,
                locale: locale,
                defaultAlertPercent: defaultAlertPercent,
                notificationsEnabled: notificationsEnabled,
                onboardingCompleted: onboardingCompleted,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AppSettingsTable, AppSettingsData>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $AppSettingsTable,
                    AppSettingsData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppSettingsTable,
      AppSettingsData,
      $$AppSettingsTableFilterComposer,
      $$AppSettingsTableOrderingComposer,
      $$AppSettingsTableAnnotationComposer,
      $$AppSettingsTableCreateCompanionBuilder,
      $$AppSettingsTableUpdateCompanionBuilder,
      (
        AppSettingsData,
        BaseReferences<_$AppDatabase, $AppSettingsTable, AppSettingsData>,
      ),
      AppSettingsData,
      PrefetchHooks Function()
    >;
typedef $$FinancialPeriodsTableCreateCompanionBuilder =
    FinancialPeriodsCompanion Function({
      required String id,
      required int year,
      required int month,
      required DateTime startDate,
      required DateTime endDate,
      Value<bool> isClosed,
      Value<DateTime?> closedAt,
      Value<int> incomeBudgetTotal,
      Value<int> incomeActualTotal,
      Value<int> extraIncomeActualTotal,
      Value<int> expenseBudgetTotal,
      Value<int> expenseActualTotal,
      Value<int> antExpenseActualTotal,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$FinancialPeriodsTableUpdateCompanionBuilder =
    FinancialPeriodsCompanion Function({
      Value<String> id,
      Value<int> year,
      Value<int> month,
      Value<DateTime> startDate,
      Value<DateTime> endDate,
      Value<bool> isClosed,
      Value<DateTime?> closedAt,
      Value<int> incomeBudgetTotal,
      Value<int> incomeActualTotal,
      Value<int> extraIncomeActualTotal,
      Value<int> expenseBudgetTotal,
      Value<int> expenseActualTotal,
      Value<int> antExpenseActualTotal,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$FinancialPeriodsTableReferences
    extends
        BaseReferences<_$AppDatabase, $FinancialPeriodsTable, FinancialPeriod> {
  $$FinancialPeriodsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $FinancialTransactionsTable,
    List<FinancialTransaction>
  >
  _financialTransactionsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.financialTransactions,
        aliasName: 'financial_periods__id__financial_transactions__period_id',
      );

  $$FinancialTransactionsTableProcessedTableManager
  get financialTransactionsRefs {
    final manager = $$FinancialTransactionsTableTableManager(
      $_db,
      $_db.financialTransactions,
    ).filter((f) => f.periodId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _financialTransactionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$BudgetItemsTable, List<BudgetItem>>
  _budgetItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.budgetItems,
    aliasName: 'financial_periods__id__budget_items__period_id',
  );

  $$BudgetItemsTableProcessedTableManager get budgetItemsRefs {
    final manager = $$BudgetItemsTableTableManager(
      $_db,
      $_db.budgetItems,
    ).filter((f) => f.periodId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_budgetItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $CategoryPeriodTotalsTable,
    List<CategoryPeriodTotal>
  >
  _categoryPeriodTotalsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.categoryPeriodTotals,
        aliasName: 'financial_periods__id__category_period_totals__period_id',
      );

  $$CategoryPeriodTotalsTableProcessedTableManager
  get categoryPeriodTotalsRefs {
    final manager = $$CategoryPeriodTotalsTableTableManager(
      $_db,
      $_db.categoryPeriodTotals,
    ).filter((f) => f.periodId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _categoryPeriodTotalsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$FinancialPeriodsTableFilterComposer
    extends Composer<_$AppDatabase, $FinancialPeriodsTable> {
  $$FinancialPeriodsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get year => $composableBuilder(
    column: $table.year,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get month => $composableBuilder(
    column: $table.month,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isClosed => $composableBuilder(
    column: $table.isClosed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get closedAt => $composableBuilder(
    column: $table.closedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get incomeBudgetTotal => $composableBuilder(
    column: $table.incomeBudgetTotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get incomeActualTotal => $composableBuilder(
    column: $table.incomeActualTotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get extraIncomeActualTotal => $composableBuilder(
    column: $table.extraIncomeActualTotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get expenseBudgetTotal => $composableBuilder(
    column: $table.expenseBudgetTotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get expenseActualTotal => $composableBuilder(
    column: $table.expenseActualTotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get antExpenseActualTotal => $composableBuilder(
    column: $table.antExpenseActualTotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> financialTransactionsRefs(
    Expression<bool> Function($$FinancialTransactionsTableFilterComposer f) f,
  ) {
    final $$FinancialTransactionsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.financialTransactions,
          getReferencedColumn: (t) => t.periodId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$FinancialTransactionsTableFilterComposer(
                $db: $db,
                $table: $db.financialTransactions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> budgetItemsRefs(
    Expression<bool> Function($$BudgetItemsTableFilterComposer f) f,
  ) {
    final $$BudgetItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.budgetItems,
      getReferencedColumn: (t) => t.periodId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BudgetItemsTableFilterComposer(
            $db: $db,
            $table: $db.budgetItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> categoryPeriodTotalsRefs(
    Expression<bool> Function($$CategoryPeriodTotalsTableFilterComposer f) f,
  ) {
    final $$CategoryPeriodTotalsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.categoryPeriodTotals,
      getReferencedColumn: (t) => t.periodId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoryPeriodTotalsTableFilterComposer(
            $db: $db,
            $table: $db.categoryPeriodTotals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FinancialPeriodsTableOrderingComposer
    extends Composer<_$AppDatabase, $FinancialPeriodsTable> {
  $$FinancialPeriodsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get year => $composableBuilder(
    column: $table.year,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get month => $composableBuilder(
    column: $table.month,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isClosed => $composableBuilder(
    column: $table.isClosed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get closedAt => $composableBuilder(
    column: $table.closedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get incomeBudgetTotal => $composableBuilder(
    column: $table.incomeBudgetTotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get incomeActualTotal => $composableBuilder(
    column: $table.incomeActualTotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get extraIncomeActualTotal => $composableBuilder(
    column: $table.extraIncomeActualTotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get expenseBudgetTotal => $composableBuilder(
    column: $table.expenseBudgetTotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get expenseActualTotal => $composableBuilder(
    column: $table.expenseActualTotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get antExpenseActualTotal => $composableBuilder(
    column: $table.antExpenseActualTotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FinancialPeriodsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FinancialPeriodsTable> {
  $$FinancialPeriodsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get year =>
      $composableBuilder(column: $table.year, builder: (column) => column);

  GeneratedColumn<int> get month =>
      $composableBuilder(column: $table.month, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<bool> get isClosed =>
      $composableBuilder(column: $table.isClosed, builder: (column) => column);

  GeneratedColumn<DateTime> get closedAt =>
      $composableBuilder(column: $table.closedAt, builder: (column) => column);

  GeneratedColumn<int> get incomeBudgetTotal => $composableBuilder(
    column: $table.incomeBudgetTotal,
    builder: (column) => column,
  );

  GeneratedColumn<int> get incomeActualTotal => $composableBuilder(
    column: $table.incomeActualTotal,
    builder: (column) => column,
  );

  GeneratedColumn<int> get extraIncomeActualTotal => $composableBuilder(
    column: $table.extraIncomeActualTotal,
    builder: (column) => column,
  );

  GeneratedColumn<int> get expenseBudgetTotal => $composableBuilder(
    column: $table.expenseBudgetTotal,
    builder: (column) => column,
  );

  GeneratedColumn<int> get expenseActualTotal => $composableBuilder(
    column: $table.expenseActualTotal,
    builder: (column) => column,
  );

  GeneratedColumn<int> get antExpenseActualTotal => $composableBuilder(
    column: $table.antExpenseActualTotal,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> financialTransactionsRefs<T extends Object>(
    Expression<T> Function($$FinancialTransactionsTableAnnotationComposer a) f,
  ) {
    final $$FinancialTransactionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.financialTransactions,
          getReferencedColumn: (t) => t.periodId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$FinancialTransactionsTableAnnotationComposer(
                $db: $db,
                $table: $db.financialTransactions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> budgetItemsRefs<T extends Object>(
    Expression<T> Function($$BudgetItemsTableAnnotationComposer a) f,
  ) {
    final $$BudgetItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.budgetItems,
      getReferencedColumn: (t) => t.periodId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BudgetItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.budgetItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> categoryPeriodTotalsRefs<T extends Object>(
    Expression<T> Function($$CategoryPeriodTotalsTableAnnotationComposer a) f,
  ) {
    final $$CategoryPeriodTotalsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.categoryPeriodTotals,
          getReferencedColumn: (t) => t.periodId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CategoryPeriodTotalsTableAnnotationComposer(
                $db: $db,
                $table: $db.categoryPeriodTotals,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$FinancialPeriodsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FinancialPeriodsTable,
          FinancialPeriod,
          $$FinancialPeriodsTableFilterComposer,
          $$FinancialPeriodsTableOrderingComposer,
          $$FinancialPeriodsTableAnnotationComposer,
          $$FinancialPeriodsTableCreateCompanionBuilder,
          $$FinancialPeriodsTableUpdateCompanionBuilder,
          (FinancialPeriod, $$FinancialPeriodsTableReferences),
          FinancialPeriod,
          PrefetchHooks Function({
            bool financialTransactionsRefs,
            bool budgetItemsRefs,
            bool categoryPeriodTotalsRefs,
          })
        > {
  $$FinancialPeriodsTableTableManager(
    _$AppDatabase db,
    $FinancialPeriodsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FinancialPeriodsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FinancialPeriodsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FinancialPeriodsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<int> year = const Value.absent(),
                Value<int> month = const Value.absent(),
                Value<DateTime> startDate = const Value.absent(),
                Value<DateTime> endDate = const Value.absent(),
                Value<bool> isClosed = const Value.absent(),
                Value<DateTime?> closedAt = const Value.absent(),
                Value<int> incomeBudgetTotal = const Value.absent(),
                Value<int> incomeActualTotal = const Value.absent(),
                Value<int> extraIncomeActualTotal = const Value.absent(),
                Value<int> expenseBudgetTotal = const Value.absent(),
                Value<int> expenseActualTotal = const Value.absent(),
                Value<int> antExpenseActualTotal = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FinancialPeriodsCompanion(
                id: id,
                year: year,
                month: month,
                startDate: startDate,
                endDate: endDate,
                isClosed: isClosed,
                closedAt: closedAt,
                incomeBudgetTotal: incomeBudgetTotal,
                incomeActualTotal: incomeActualTotal,
                extraIncomeActualTotal: extraIncomeActualTotal,
                expenseBudgetTotal: expenseBudgetTotal,
                expenseActualTotal: expenseActualTotal,
                antExpenseActualTotal: antExpenseActualTotal,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required int year,
                required int month,
                required DateTime startDate,
                required DateTime endDate,
                Value<bool> isClosed = const Value.absent(),
                Value<DateTime?> closedAt = const Value.absent(),
                Value<int> incomeBudgetTotal = const Value.absent(),
                Value<int> incomeActualTotal = const Value.absent(),
                Value<int> extraIncomeActualTotal = const Value.absent(),
                Value<int> expenseBudgetTotal = const Value.absent(),
                Value<int> expenseActualTotal = const Value.absent(),
                Value<int> antExpenseActualTotal = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => FinancialPeriodsCompanion.insert(
                id: id,
                year: year,
                month: month,
                startDate: startDate,
                endDate: endDate,
                isClosed: isClosed,
                closedAt: closedAt,
                incomeBudgetTotal: incomeBudgetTotal,
                incomeActualTotal: incomeActualTotal,
                extraIncomeActualTotal: extraIncomeActualTotal,
                expenseBudgetTotal: expenseBudgetTotal,
                expenseActualTotal: expenseActualTotal,
                antExpenseActualTotal: antExpenseActualTotal,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$FinancialPeriodsTable, FinancialPeriod>(table),
                  $$FinancialPeriodsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                financialTransactionsRefs = false,
                budgetItemsRefs = false,
                categoryPeriodTotalsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (financialTransactionsRefs) db.financialTransactions,
                    if (budgetItemsRefs) db.budgetItems,
                    if (categoryPeriodTotalsRefs) db.categoryPeriodTotals,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (financialTransactionsRefs)
                        await $_getPrefetchedData<
                          FinancialPeriod,
                          $FinancialPeriodsTable,
                          FinancialTransaction
                        >(
                          currentTable: table,
                          referencedTable: $$FinancialPeriodsTableReferences
                              ._financialTransactionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FinancialPeriodsTableReferences(
                                db,
                                table,
                                p0,
                              ).financialTransactionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.periodId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (budgetItemsRefs)
                        await $_getPrefetchedData<
                          FinancialPeriod,
                          $FinancialPeriodsTable,
                          BudgetItem
                        >(
                          currentTable: table,
                          referencedTable: $$FinancialPeriodsTableReferences
                              ._budgetItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FinancialPeriodsTableReferences(
                                db,
                                table,
                                p0,
                              ).budgetItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.periodId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (categoryPeriodTotalsRefs)
                        await $_getPrefetchedData<
                          FinancialPeriod,
                          $FinancialPeriodsTable,
                          CategoryPeriodTotal
                        >(
                          currentTable: table,
                          referencedTable: $$FinancialPeriodsTableReferences
                              ._categoryPeriodTotalsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FinancialPeriodsTableReferences(
                                db,
                                table,
                                p0,
                              ).categoryPeriodTotalsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.periodId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$FinancialPeriodsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FinancialPeriodsTable,
      FinancialPeriod,
      $$FinancialPeriodsTableFilterComposer,
      $$FinancialPeriodsTableOrderingComposer,
      $$FinancialPeriodsTableAnnotationComposer,
      $$FinancialPeriodsTableCreateCompanionBuilder,
      $$FinancialPeriodsTableUpdateCompanionBuilder,
      (FinancialPeriod, $$FinancialPeriodsTableReferences),
      FinancialPeriod,
      PrefetchHooks Function({
        bool financialTransactionsRefs,
        bool budgetItemsRefs,
        bool categoryPeriodTotalsRefs,
      })
    >;
typedef $$CategoriesTableCreateCompanionBuilder = CategoriesCompanion Function({
  required String id,
  required String name,
  required bool isIncome,
  Value<bool> isFixed,
  Value<bool> isAntExpense,
  Value<String> iconKey,
  Value<String> colorHex,
  Value<int> sortOrder,
  Value<bool> isArchived,
  Value<bool> isDefault,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$CategoriesTableUpdateCompanionBuilder = CategoriesCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<bool> isIncome,
  Value<bool> isFixed,
  Value<bool> isAntExpense,
  Value<String> iconKey,
  Value<String> colorHex,
  Value<int> sortOrder,
  Value<bool> isArchived,
  Value<bool> isDefault,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$CategoriesTableReferences
    extends BaseReferences<_$AppDatabase, $CategoriesTable, Category> {
  $$CategoriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<
    $FinancialTransactionsTable,
    List<FinancialTransaction>
  >
  _financialTransactionsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.financialTransactions,
        aliasName: 'categories__id__financial_transactions__category_id',
      );

  $$FinancialTransactionsTableProcessedTableManager
  get financialTransactionsRefs {
    final manager = $$FinancialTransactionsTableTableManager(
      $_db,
      $_db.financialTransactions,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _financialTransactionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$BudgetItemsTable, List<BudgetItem>>
  _budgetItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.budgetItems,
    aliasName: 'categories__id__budget_items__category_id',
  );

  $$BudgetItemsTableProcessedTableManager get budgetItemsRefs {
    final manager = $$BudgetItemsTableTableManager(
      $_db,
      $_db.budgetItems,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_budgetItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $CategoryPeriodTotalsTable,
    List<CategoryPeriodTotal>
  >
  _categoryPeriodTotalsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.categoryPeriodTotals,
        aliasName: 'categories__id__category_period_totals__category_id',
      );

  $$CategoryPeriodTotalsTableProcessedTableManager
  get categoryPeriodTotalsRefs {
    final manager = $$CategoryPeriodTotalsTableTableManager(
      $_db,
      $_db.categoryPeriodTotals,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _categoryPeriodTotalsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isIncome => $composableBuilder(
    column: $table.isIncome,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFixed => $composableBuilder(
    column: $table.isFixed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isAntExpense => $composableBuilder(
    column: $table.isAntExpense,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get iconKey => $composableBuilder(
    column: $table.iconKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get colorHex => $composableBuilder(
    column: $table.colorHex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> financialTransactionsRefs(
    Expression<bool> Function($$FinancialTransactionsTableFilterComposer f) f,
  ) {
    final $$FinancialTransactionsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.financialTransactions,
          getReferencedColumn: (t) => t.categoryId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$FinancialTransactionsTableFilterComposer(
                $db: $db,
                $table: $db.financialTransactions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> budgetItemsRefs(
    Expression<bool> Function($$BudgetItemsTableFilterComposer f) f,
  ) {
    final $$BudgetItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.budgetItems,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BudgetItemsTableFilterComposer(
            $db: $db,
            $table: $db.budgetItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> categoryPeriodTotalsRefs(
    Expression<bool> Function($$CategoryPeriodTotalsTableFilterComposer f) f,
  ) {
    final $$CategoryPeriodTotalsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.categoryPeriodTotals,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoryPeriodTotalsTableFilterComposer(
            $db: $db,
            $table: $db.categoryPeriodTotals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isIncome => $composableBuilder(
    column: $table.isIncome,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFixed => $composableBuilder(
    column: $table.isFixed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isAntExpense => $composableBuilder(
    column: $table.isAntExpense,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get iconKey => $composableBuilder(
    column: $table.iconKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get colorHex => $composableBuilder(
    column: $table.colorHex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableAnnotationComposer({
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

  GeneratedColumn<bool> get isIncome =>
      $composableBuilder(column: $table.isIncome, builder: (column) => column);

  GeneratedColumn<bool> get isFixed =>
      $composableBuilder(column: $table.isFixed, builder: (column) => column);

  GeneratedColumn<bool> get isAntExpense => $composableBuilder(
    column: $table.isAntExpense,
    builder: (column) => column,
  );

  GeneratedColumn<String> get iconKey =>
      $composableBuilder(column: $table.iconKey, builder: (column) => column);

  GeneratedColumn<String> get colorHex =>
      $composableBuilder(column: $table.colorHex, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDefault =>
      $composableBuilder(column: $table.isDefault, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> financialTransactionsRefs<T extends Object>(
    Expression<T> Function($$FinancialTransactionsTableAnnotationComposer a) f,
  ) {
    final $$FinancialTransactionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.financialTransactions,
          getReferencedColumn: (t) => t.categoryId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$FinancialTransactionsTableAnnotationComposer(
                $db: $db,
                $table: $db.financialTransactions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> budgetItemsRefs<T extends Object>(
    Expression<T> Function($$BudgetItemsTableAnnotationComposer a) f,
  ) {
    final $$BudgetItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.budgetItems,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BudgetItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.budgetItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> categoryPeriodTotalsRefs<T extends Object>(
    Expression<T> Function($$CategoryPeriodTotalsTableAnnotationComposer a) f,
  ) {
    final $$CategoryPeriodTotalsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.categoryPeriodTotals,
          getReferencedColumn: (t) => t.categoryId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CategoryPeriodTotalsTableAnnotationComposer(
                $db: $db,
                $table: $db.categoryPeriodTotals,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$CategoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CategoriesTable,
          Category,
          $$CategoriesTableFilterComposer,
          $$CategoriesTableOrderingComposer,
          $$CategoriesTableAnnotationComposer,
          $$CategoriesTableCreateCompanionBuilder,
          $$CategoriesTableUpdateCompanionBuilder,
          (Category, $$CategoriesTableReferences),
          Category,
          PrefetchHooks Function({
            bool financialTransactionsRefs,
            bool budgetItemsRefs,
            bool categoryPeriodTotalsRefs,
          })
        > {
  $$CategoriesTableTableManager(_$AppDatabase db, $CategoriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<bool> isIncome = const Value.absent(),
                Value<bool> isFixed = const Value.absent(),
                Value<bool> isAntExpense = const Value.absent(),
                Value<String> iconKey = const Value.absent(),
                Value<String> colorHex = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<bool> isDefault = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CategoriesCompanion(
                id: id,
                name: name,
                isIncome: isIncome,
                isFixed: isFixed,
                isAntExpense: isAntExpense,
                iconKey: iconKey,
                colorHex: colorHex,
                sortOrder: sortOrder,
                isArchived: isArchived,
                isDefault: isDefault,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required bool isIncome,
                Value<bool> isFixed = const Value.absent(),
                Value<bool> isAntExpense = const Value.absent(),
                Value<String> iconKey = const Value.absent(),
                Value<String> colorHex = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<bool> isDefault = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => CategoriesCompanion.insert(
                id: id,
                name: name,
                isIncome: isIncome,
                isFixed: isFixed,
                isAntExpense: isAntExpense,
                iconKey: iconKey,
                colorHex: colorHex,
                sortOrder: sortOrder,
                isArchived: isArchived,
                isDefault: isDefault,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CategoriesTable, Category>(table),
                  $$CategoriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                financialTransactionsRefs = false,
                budgetItemsRefs = false,
                categoryPeriodTotalsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (financialTransactionsRefs) db.financialTransactions,
                    if (budgetItemsRefs) db.budgetItems,
                    if (categoryPeriodTotalsRefs) db.categoryPeriodTotals,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (financialTransactionsRefs)
                        await $_getPrefetchedData<
                          Category,
                          $CategoriesTable,
                          FinancialTransaction
                        >(
                          currentTable: table,
                          referencedTable: $$CategoriesTableReferences
                              ._financialTransactionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CategoriesTableReferences(
                                db,
                                table,
                                p0,
                              ).financialTransactionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.categoryId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (budgetItemsRefs)
                        await $_getPrefetchedData<
                          Category,
                          $CategoriesTable,
                          BudgetItem
                        >(
                          currentTable: table,
                          referencedTable: $$CategoriesTableReferences
                              ._budgetItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CategoriesTableReferences(
                                db,
                                table,
                                p0,
                              ).budgetItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.categoryId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (categoryPeriodTotalsRefs)
                        await $_getPrefetchedData<
                          Category,
                          $CategoriesTable,
                          CategoryPeriodTotal
                        >(
                          currentTable: table,
                          referencedTable: $$CategoriesTableReferences
                              ._categoryPeriodTotalsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CategoriesTableReferences(
                                db,
                                table,
                                p0,
                              ).categoryPeriodTotalsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.categoryId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$CategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CategoriesTable,
      Category,
      $$CategoriesTableFilterComposer,
      $$CategoriesTableOrderingComposer,
      $$CategoriesTableAnnotationComposer,
      $$CategoriesTableCreateCompanionBuilder,
      $$CategoriesTableUpdateCompanionBuilder,
      (Category, $$CategoriesTableReferences),
      Category,
      PrefetchHooks Function({
        bool financialTransactionsRefs,
        bool budgetItemsRefs,
        bool categoryPeriodTotalsRefs,
      })
    >;
typedef $$FinancialTransactionsTableCreateCompanionBuilder =
    FinancialTransactionsCompanion Function({
      required String id,
      required String periodId,
      required String categoryId,
      required bool isIncome,
      required int amount,
      required DateTime date,
      required int cutNumber,
      Value<String> description,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });
typedef $$FinancialTransactionsTableUpdateCompanionBuilder =
    FinancialTransactionsCompanion Function({
      Value<String> id,
      Value<String> periodId,
      Value<String> categoryId,
      Value<bool> isIncome,
      Value<int> amount,
      Value<DateTime> date,
      Value<int> cutNumber,
      Value<String> description,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });

final class $$FinancialTransactionsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $FinancialTransactionsTable,
          FinancialTransaction
        > {
  $$FinancialTransactionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $FinancialPeriodsTable _periodIdTable(_$AppDatabase db) => db
      .financialPeriods
      .createAlias('financial_transactions__period_id__financial_periods__id');

  $$FinancialPeriodsTableProcessedTableManager get periodId {
    final $_column = $_itemColumn<String>('period_id')!;

    final manager = $$FinancialPeriodsTableTableManager(
      $_db,
      $_db.financialPeriods,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_periodIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CategoriesTable _categoryIdTable(_$AppDatabase db) => db.categories
      .createAlias('financial_transactions__category_id__categories__id');

  $$CategoriesTableProcessedTableManager get categoryId {
    final $_column = $_itemColumn<String>('category_id')!;

    final manager = $$CategoriesTableTableManager(
      $_db,
      $_db.categories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$FinancialTransactionsTableFilterComposer
    extends Composer<_$AppDatabase, $FinancialTransactionsTable> {
  $$FinancialTransactionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isIncome => $composableBuilder(
    column: $table.isIncome,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get cutNumber => $composableBuilder(
    column: $table.cutNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$FinancialPeriodsTableFilterComposer get periodId {
    final $$FinancialPeriodsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.periodId,
      referencedTable: $db.financialPeriods,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FinancialPeriodsTableFilterComposer(
            $db: $db,
            $table: $db.financialPeriods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoriesTableFilterComposer get categoryId {
    final $$CategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableFilterComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FinancialTransactionsTableOrderingComposer
    extends Composer<_$AppDatabase, $FinancialTransactionsTable> {
  $$FinancialTransactionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isIncome => $composableBuilder(
    column: $table.isIncome,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cutNumber => $composableBuilder(
    column: $table.cutNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$FinancialPeriodsTableOrderingComposer get periodId {
    final $$FinancialPeriodsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.periodId,
      referencedTable: $db.financialPeriods,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FinancialPeriodsTableOrderingComposer(
            $db: $db,
            $table: $db.financialPeriods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoriesTableOrderingComposer get categoryId {
    final $$CategoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableOrderingComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FinancialTransactionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FinancialTransactionsTable> {
  $$FinancialTransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get isIncome =>
      $composableBuilder(column: $table.isIncome, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get cutNumber =>
      $composableBuilder(column: $table.cutNumber, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$FinancialPeriodsTableAnnotationComposer get periodId {
    final $$FinancialPeriodsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.periodId,
      referencedTable: $db.financialPeriods,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FinancialPeriodsTableAnnotationComposer(
            $db: $db,
            $table: $db.financialPeriods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoriesTableAnnotationComposer get categoryId {
    final $$CategoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FinancialTransactionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FinancialTransactionsTable,
          FinancialTransaction,
          $$FinancialTransactionsTableFilterComposer,
          $$FinancialTransactionsTableOrderingComposer,
          $$FinancialTransactionsTableAnnotationComposer,
          $$FinancialTransactionsTableCreateCompanionBuilder,
          $$FinancialTransactionsTableUpdateCompanionBuilder,
          (FinancialTransaction, $$FinancialTransactionsTableReferences),
          FinancialTransaction,
          PrefetchHooks Function({bool periodId, bool categoryId})
        > {
  $$FinancialTransactionsTableTableManager(
    _$AppDatabase db,
    $FinancialTransactionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FinancialTransactionsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$FinancialTransactionsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$FinancialTransactionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> periodId = const Value.absent(),
                Value<String> categoryId = const Value.absent(),
                Value<bool> isIncome = const Value.absent(),
                Value<int> amount = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<int> cutNumber = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FinancialTransactionsCompanion(
                id: id,
                periodId: periodId,
                categoryId: categoryId,
                isIncome: isIncome,
                amount: amount,
                date: date,
                cutNumber: cutNumber,
                description: description,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String periodId,
                required String categoryId,
                required bool isIncome,
                required int amount,
                required DateTime date,
                required int cutNumber,
                Value<String> description = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FinancialTransactionsCompanion.insert(
                id: id,
                periodId: periodId,
                categoryId: categoryId,
                isIncome: isIncome,
                amount: amount,
                date: date,
                cutNumber: cutNumber,
                description: description,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $FinancialTransactionsTable,
                    FinancialTransaction
                  >(table),
                  $$FinancialTransactionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({periodId = false, categoryId = false}) {
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
                    if (periodId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.periodId,
                        referencedTable: $$FinancialTransactionsTableReferences
                            ._periodIdTable(db),
                        referencedColumn: $$FinancialTransactionsTableReferences
                            ._periodIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (categoryId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.categoryId,
                        referencedTable: $$FinancialTransactionsTableReferences
                            ._categoryIdTable(db),
                        referencedColumn: $$FinancialTransactionsTableReferences
                            ._categoryIdTable(db)
                            .id,
                      ) as T;
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

typedef $$FinancialTransactionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FinancialTransactionsTable,
      FinancialTransaction,
      $$FinancialTransactionsTableFilterComposer,
      $$FinancialTransactionsTableOrderingComposer,
      $$FinancialTransactionsTableAnnotationComposer,
      $$FinancialTransactionsTableCreateCompanionBuilder,
      $$FinancialTransactionsTableUpdateCompanionBuilder,
      (FinancialTransaction, $$FinancialTransactionsTableReferences),
      FinancialTransaction,
      PrefetchHooks Function({bool periodId, bool categoryId})
    >;
typedef $$BudgetItemsTableCreateCompanionBuilder =
    BudgetItemsCompanion Function({
      required String id,
      required String periodId,
      required String categoryId,
      Value<int> cutNumber,
      required int amountLimit,
      Value<int?> alertPercent,
      Value<int> lastAlertLevel,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$BudgetItemsTableUpdateCompanionBuilder =
    BudgetItemsCompanion Function({
      Value<String> id,
      Value<String> periodId,
      Value<String> categoryId,
      Value<int> cutNumber,
      Value<int> amountLimit,
      Value<int?> alertPercent,
      Value<int> lastAlertLevel,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$BudgetItemsTableReferences
    extends BaseReferences<_$AppDatabase, $BudgetItemsTable, BudgetItem> {
  $$BudgetItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $FinancialPeriodsTable _periodIdTable(_$AppDatabase db) => db
      .financialPeriods
      .createAlias('budget_items__period_id__financial_periods__id');

  $$FinancialPeriodsTableProcessedTableManager get periodId {
    final $_column = $_itemColumn<String>('period_id')!;

    final manager = $$FinancialPeriodsTableTableManager(
      $_db,
      $_db.financialPeriods,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_periodIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CategoriesTable _categoryIdTable(_$AppDatabase db) =>
      db.categories.createAlias('budget_items__category_id__categories__id');

  $$CategoriesTableProcessedTableManager get categoryId {
    final $_column = $_itemColumn<String>('category_id')!;

    final manager = $$CategoriesTableTableManager(
      $_db,
      $_db.categories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$BudgetItemsTableFilterComposer
    extends Composer<_$AppDatabase, $BudgetItemsTable> {
  $$BudgetItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get cutNumber => $composableBuilder(
    column: $table.cutNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountLimit => $composableBuilder(
    column: $table.amountLimit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get alertPercent => $composableBuilder(
    column: $table.alertPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastAlertLevel => $composableBuilder(
    column: $table.lastAlertLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$FinancialPeriodsTableFilterComposer get periodId {
    final $$FinancialPeriodsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.periodId,
      referencedTable: $db.financialPeriods,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FinancialPeriodsTableFilterComposer(
            $db: $db,
            $table: $db.financialPeriods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoriesTableFilterComposer get categoryId {
    final $$CategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableFilterComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BudgetItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $BudgetItemsTable> {
  $$BudgetItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cutNumber => $composableBuilder(
    column: $table.cutNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountLimit => $composableBuilder(
    column: $table.amountLimit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get alertPercent => $composableBuilder(
    column: $table.alertPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastAlertLevel => $composableBuilder(
    column: $table.lastAlertLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$FinancialPeriodsTableOrderingComposer get periodId {
    final $$FinancialPeriodsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.periodId,
      referencedTable: $db.financialPeriods,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FinancialPeriodsTableOrderingComposer(
            $db: $db,
            $table: $db.financialPeriods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoriesTableOrderingComposer get categoryId {
    final $$CategoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableOrderingComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BudgetItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BudgetItemsTable> {
  $$BudgetItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get cutNumber =>
      $composableBuilder(column: $table.cutNumber, builder: (column) => column);

  GeneratedColumn<int> get amountLimit => $composableBuilder(
    column: $table.amountLimit,
    builder: (column) => column,
  );

  GeneratedColumn<int> get alertPercent => $composableBuilder(
    column: $table.alertPercent,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lastAlertLevel => $composableBuilder(
    column: $table.lastAlertLevel,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$FinancialPeriodsTableAnnotationComposer get periodId {
    final $$FinancialPeriodsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.periodId,
      referencedTable: $db.financialPeriods,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FinancialPeriodsTableAnnotationComposer(
            $db: $db,
            $table: $db.financialPeriods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoriesTableAnnotationComposer get categoryId {
    final $$CategoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BudgetItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BudgetItemsTable,
          BudgetItem,
          $$BudgetItemsTableFilterComposer,
          $$BudgetItemsTableOrderingComposer,
          $$BudgetItemsTableAnnotationComposer,
          $$BudgetItemsTableCreateCompanionBuilder,
          $$BudgetItemsTableUpdateCompanionBuilder,
          (BudgetItem, $$BudgetItemsTableReferences),
          BudgetItem,
          PrefetchHooks Function({bool periodId, bool categoryId})
        > {
  $$BudgetItemsTableTableManager(_$AppDatabase db, $BudgetItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BudgetItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BudgetItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BudgetItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> periodId = const Value.absent(),
                Value<String> categoryId = const Value.absent(),
                Value<int> cutNumber = const Value.absent(),
                Value<int> amountLimit = const Value.absent(),
                Value<int?> alertPercent = const Value.absent(),
                Value<int> lastAlertLevel = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BudgetItemsCompanion(
                id: id,
                periodId: periodId,
                categoryId: categoryId,
                cutNumber: cutNumber,
                amountLimit: amountLimit,
                alertPercent: alertPercent,
                lastAlertLevel: lastAlertLevel,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String periodId,
                required String categoryId,
                Value<int> cutNumber = const Value.absent(),
                required int amountLimit,
                Value<int?> alertPercent = const Value.absent(),
                Value<int> lastAlertLevel = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => BudgetItemsCompanion.insert(
                id: id,
                periodId: periodId,
                categoryId: categoryId,
                cutNumber: cutNumber,
                amountLimit: amountLimit,
                alertPercent: alertPercent,
                lastAlertLevel: lastAlertLevel,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$BudgetItemsTable, BudgetItem>(table),
                  $$BudgetItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({periodId = false, categoryId = false}) {
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
                    if (periodId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.periodId,
                        referencedTable: $$BudgetItemsTableReferences
                            ._periodIdTable(db),
                        referencedColumn: $$BudgetItemsTableReferences
                            ._periodIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (categoryId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.categoryId,
                        referencedTable: $$BudgetItemsTableReferences
                            ._categoryIdTable(db),
                        referencedColumn: $$BudgetItemsTableReferences
                            ._categoryIdTable(db)
                            .id,
                      ) as T;
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

typedef $$BudgetItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BudgetItemsTable,
      BudgetItem,
      $$BudgetItemsTableFilterComposer,
      $$BudgetItemsTableOrderingComposer,
      $$BudgetItemsTableAnnotationComposer,
      $$BudgetItemsTableCreateCompanionBuilder,
      $$BudgetItemsTableUpdateCompanionBuilder,
      (BudgetItem, $$BudgetItemsTableReferences),
      BudgetItem,
      PrefetchHooks Function({bool periodId, bool categoryId})
    >;
typedef $$CategoryPeriodTotalsTableCreateCompanionBuilder =
    CategoryPeriodTotalsCompanion Function({
      required String periodId,
      required String categoryId,
      required int cutNumber,
      Value<int> actualTotal,
      Value<int> txCount,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$CategoryPeriodTotalsTableUpdateCompanionBuilder =
    CategoryPeriodTotalsCompanion Function({
      Value<String> periodId,
      Value<String> categoryId,
      Value<int> cutNumber,
      Value<int> actualTotal,
      Value<int> txCount,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$CategoryPeriodTotalsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $CategoryPeriodTotalsTable,
          CategoryPeriodTotal
        > {
  $$CategoryPeriodTotalsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $FinancialPeriodsTable _periodIdTable(_$AppDatabase db) => db
      .financialPeriods
      .createAlias('category_period_totals__period_id__financial_periods__id');

  $$FinancialPeriodsTableProcessedTableManager get periodId {
    final $_column = $_itemColumn<String>('period_id')!;

    final manager = $$FinancialPeriodsTableTableManager(
      $_db,
      $_db.financialPeriods,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_periodIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CategoriesTable _categoryIdTable(_$AppDatabase db) => db.categories
      .createAlias('category_period_totals__category_id__categories__id');

  $$CategoriesTableProcessedTableManager get categoryId {
    final $_column = $_itemColumn<String>('category_id')!;

    final manager = $$CategoriesTableTableManager(
      $_db,
      $_db.categories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CategoryPeriodTotalsTableFilterComposer
    extends Composer<_$AppDatabase, $CategoryPeriodTotalsTable> {
  $$CategoryPeriodTotalsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get cutNumber => $composableBuilder(
    column: $table.cutNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get actualTotal => $composableBuilder(
    column: $table.actualTotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get txCount => $composableBuilder(
    column: $table.txCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$FinancialPeriodsTableFilterComposer get periodId {
    final $$FinancialPeriodsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.periodId,
      referencedTable: $db.financialPeriods,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FinancialPeriodsTableFilterComposer(
            $db: $db,
            $table: $db.financialPeriods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoriesTableFilterComposer get categoryId {
    final $$CategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableFilterComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CategoryPeriodTotalsTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoryPeriodTotalsTable> {
  $$CategoryPeriodTotalsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get cutNumber => $composableBuilder(
    column: $table.cutNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get actualTotal => $composableBuilder(
    column: $table.actualTotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get txCount => $composableBuilder(
    column: $table.txCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$FinancialPeriodsTableOrderingComposer get periodId {
    final $$FinancialPeriodsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.periodId,
      referencedTable: $db.financialPeriods,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FinancialPeriodsTableOrderingComposer(
            $db: $db,
            $table: $db.financialPeriods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoriesTableOrderingComposer get categoryId {
    final $$CategoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableOrderingComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CategoryPeriodTotalsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoryPeriodTotalsTable> {
  $$CategoryPeriodTotalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get cutNumber =>
      $composableBuilder(column: $table.cutNumber, builder: (column) => column);

  GeneratedColumn<int> get actualTotal => $composableBuilder(
    column: $table.actualTotal,
    builder: (column) => column,
  );

  GeneratedColumn<int> get txCount =>
      $composableBuilder(column: $table.txCount, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$FinancialPeriodsTableAnnotationComposer get periodId {
    final $$FinancialPeriodsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.periodId,
      referencedTable: $db.financialPeriods,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FinancialPeriodsTableAnnotationComposer(
            $db: $db,
            $table: $db.financialPeriods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoriesTableAnnotationComposer get categoryId {
    final $$CategoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CategoryPeriodTotalsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CategoryPeriodTotalsTable,
          CategoryPeriodTotal,
          $$CategoryPeriodTotalsTableFilterComposer,
          $$CategoryPeriodTotalsTableOrderingComposer,
          $$CategoryPeriodTotalsTableAnnotationComposer,
          $$CategoryPeriodTotalsTableCreateCompanionBuilder,
          $$CategoryPeriodTotalsTableUpdateCompanionBuilder,
          (CategoryPeriodTotal, $$CategoryPeriodTotalsTableReferences),
          CategoryPeriodTotal,
          PrefetchHooks Function({bool periodId, bool categoryId})
        > {
  $$CategoryPeriodTotalsTableTableManager(
    _$AppDatabase db,
    $CategoryPeriodTotalsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoryPeriodTotalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoryPeriodTotalsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$CategoryPeriodTotalsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> periodId = const Value.absent(),
                Value<String> categoryId = const Value.absent(),
                Value<int> cutNumber = const Value.absent(),
                Value<int> actualTotal = const Value.absent(),
                Value<int> txCount = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CategoryPeriodTotalsCompanion(
                periodId: periodId,
                categoryId: categoryId,
                cutNumber: cutNumber,
                actualTotal: actualTotal,
                txCount: txCount,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String periodId,
                required String categoryId,
                required int cutNumber,
                Value<int> actualTotal = const Value.absent(),
                Value<int> txCount = const Value.absent(),
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => CategoryPeriodTotalsCompanion.insert(
                periodId: periodId,
                categoryId: categoryId,
                cutNumber: cutNumber,
                actualTotal: actualTotal,
                txCount: txCount,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CategoryPeriodTotalsTable, CategoryPeriodTotal>(
                    table,
                  ),
                  $$CategoryPeriodTotalsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({periodId = false, categoryId = false}) {
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
                    if (periodId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.periodId,
                        referencedTable: $$CategoryPeriodTotalsTableReferences
                            ._periodIdTable(db),
                        referencedColumn: $$CategoryPeriodTotalsTableReferences
                            ._periodIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (categoryId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.categoryId,
                        referencedTable: $$CategoryPeriodTotalsTableReferences
                            ._categoryIdTable(db),
                        referencedColumn: $$CategoryPeriodTotalsTableReferences
                            ._categoryIdTable(db)
                            .id,
                      ) as T;
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

typedef $$CategoryPeriodTotalsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CategoryPeriodTotalsTable,
      CategoryPeriodTotal,
      $$CategoryPeriodTotalsTableFilterComposer,
      $$CategoryPeriodTotalsTableOrderingComposer,
      $$CategoryPeriodTotalsTableAnnotationComposer,
      $$CategoryPeriodTotalsTableCreateCompanionBuilder,
      $$CategoryPeriodTotalsTableUpdateCompanionBuilder,
      (CategoryPeriodTotal, $$CategoryPeriodTotalsTableReferences),
      CategoryPeriodTotal,
      PrefetchHooks Function({bool periodId, bool categoryId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
  $$FinancialPeriodsTableTableManager get financialPeriods =>
      $$FinancialPeriodsTableTableManager(_db, _db.financialPeriods);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db, _db.categories);
  $$FinancialTransactionsTableTableManager get financialTransactions =>
      $$FinancialTransactionsTableTableManager(_db, _db.financialTransactions);
  $$BudgetItemsTableTableManager get budgetItems =>
      $$BudgetItemsTableTableManager(_db, _db.budgetItems);
  $$CategoryPeriodTotalsTableTableManager get categoryPeriodTotals =>
      $$CategoryPeriodTotalsTableTableManager(_db, _db.categoryPeriodTotals);
}
