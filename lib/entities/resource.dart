import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'resource.freezed.dart';

@freezed
abstract class Resource<T> with _$Resource<T> {
  const factory Resource(T value) = Data<T>;

  const factory Resource.loading() = Loading<T>;

  const factory Resource.error(String message) = ErrorDetails<T>;
}
