import 'dart:collection';

import 'package:last_fm_api/src/api_entity_info.dart';
import 'package:last_fm_api/src/lists/list_metadata.dart';
import 'package:meta/meta.dart';

abstract class BaseList<T extends ApiEntityInfo> implements Iterable<T> {
  final List<T> elements;
  final ListMetadata metadata;

  BaseList(
    List<Map<String, dynamic>> listData,
    T Function(dynamic element) listElementBuilder,
    this.metadata,
  )   : assert(listData != null),
        assert(listElementBuilder != null),
        elements = [for (final entry in listData) listElementBuilder(entry)];

  String toFullString() {
    return IterableBase.iterableToFullString(elements, '[', ']');
  }

  String toShortString() {
    return IterableBase.iterableToShortString(elements, '[', ']');
  }

  @override
  @nonVirtual
  String toString() {
    return '$runtimeType(${[
      metadata?.toString(),
      toFullString()
    ].where((element) => element != null && element.isNotEmpty).join(', ')})';
  }

  @override
  bool any(bool Function(T element) test) => elements.any(test);

  @override
  Iterable<R> cast<R>() => elements.cast<R>();

  @override
  bool contains(Object element) => elements.contains(element);

  @override
  T elementAt(int index) => elements.elementAt(index);

  @override
  bool every(bool Function(T element) test) => elements.every(test);

  @override
  Iterable<R> expand<R>(Iterable<R> Function(T element) f) {
    return elements.expand(f);
  }

  @override
  T get first => elements.first;

  @override
  T firstWhere(bool Function(T element) test, {T Function() orElse}) {
    return elements.firstWhere(test, orElse: orElse);
  }

  @override
  R fold<R>(R initialValue, R Function(R previousValue, T element) combine) {
    return elements.fold(initialValue, combine);
  }

  @override
  Iterable<T> followedBy(Iterable<T> other) => elements.followedBy(other);

  @override
  void forEach(void Function(T element) f) => elements.forEach(f);

  @override
  bool get isEmpty => elements.isEmpty;

  @override
  bool get isNotEmpty => elements.isNotEmpty;

  @override
  Iterator<T> get iterator => elements.iterator;

  @override
  String join([String separator = '']) => elements.join(separator);

  @override
  T get last => elements.last;

  @override
  T lastWhere(bool Function(T element) test, {T Function() orElse}) {
    return elements.lastWhere(test, orElse: orElse);
  }

  @override
  int get length => elements.length;

  @override
  Iterable<R> map<R>(R Function(T e) f) => elements.map<R>(f);

  @override
  T reduce(T Function(T value, T element) combine) => elements.reduce(combine);

  @override
  T get single => elements.single;

  @override
  T singleWhere(bool Function(T element) test, {T Function() orElse}) {
    return elements.singleWhere(test, orElse: orElse);
  }

  @override
  Iterable<T> skip(int count) => elements.skip(count);

  @override
  Iterable<T> skipWhile(bool Function(T value) test) {
    return elements.skipWhile(test);
  }

  @override
  Iterable<T> take(int count) => elements.take(count);

  @override
  Iterable<T> takeWhile(bool Function(T value) test) {
    return elements.takeWhile(test);
  }

  @override
  List<T> toList({bool growable = true}) => elements.toList(growable: growable);

  @override
  Set<T> toSet() => elements.toSet();

  @override
  Iterable<T> where(bool Function(T element) test) => elements.where(test);

  @override
  Iterable<R> whereType<R>() => elements.whereType<R>();
}
