// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recipe_challenge_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RecipeChallenge {

 Recipe get recipe; Duration get timeTaken; Duration get expectedTime; DateTime get dateCompleted;
/// Create a copy of RecipeChallenge
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecipeChallengeCopyWith<RecipeChallenge> get copyWith => _$RecipeChallengeCopyWithImpl<RecipeChallenge>(this as RecipeChallenge, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecipeChallenge&&(identical(other.recipe, recipe) || other.recipe == recipe)&&(identical(other.timeTaken, timeTaken) || other.timeTaken == timeTaken)&&(identical(other.expectedTime, expectedTime) || other.expectedTime == expectedTime)&&(identical(other.dateCompleted, dateCompleted) || other.dateCompleted == dateCompleted));
}


@override
int get hashCode => Object.hash(runtimeType,recipe,timeTaken,expectedTime,dateCompleted);

@override
String toString() {
  return 'RecipeChallenge(recipe: $recipe, timeTaken: $timeTaken, expectedTime: $expectedTime, dateCompleted: $dateCompleted)';
}


}

/// @nodoc
abstract mixin class $RecipeChallengeCopyWith<$Res>  {
  factory $RecipeChallengeCopyWith(RecipeChallenge value, $Res Function(RecipeChallenge) _then) = _$RecipeChallengeCopyWithImpl;
@useResult
$Res call({
 Recipe recipe, Duration timeTaken, Duration expectedTime, DateTime dateCompleted
});


$RecipeCopyWith<$Res> get recipe;

}
/// @nodoc
class _$RecipeChallengeCopyWithImpl<$Res>
    implements $RecipeChallengeCopyWith<$Res> {
  _$RecipeChallengeCopyWithImpl(this._self, this._then);

  final RecipeChallenge _self;
  final $Res Function(RecipeChallenge) _then;

/// Create a copy of RecipeChallenge
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? recipe = null,Object? timeTaken = null,Object? expectedTime = null,Object? dateCompleted = null,}) {
  return _then(_self.copyWith(
recipe: null == recipe ? _self.recipe : recipe // ignore: cast_nullable_to_non_nullable
as Recipe,timeTaken: null == timeTaken ? _self.timeTaken : timeTaken // ignore: cast_nullable_to_non_nullable
as Duration,expectedTime: null == expectedTime ? _self.expectedTime : expectedTime // ignore: cast_nullable_to_non_nullable
as Duration,dateCompleted: null == dateCompleted ? _self.dateCompleted : dateCompleted // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of RecipeChallenge
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RecipeCopyWith<$Res> get recipe {
  
  return $RecipeCopyWith<$Res>(_self.recipe, (value) {
    return _then(_self.copyWith(recipe: value));
  });
}
}


/// Adds pattern-matching-related methods to [RecipeChallenge].
extension RecipeChallengePatterns on RecipeChallenge {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecipeChallenge value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecipeChallenge() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecipeChallenge value)  $default,){
final _that = this;
switch (_that) {
case _RecipeChallenge():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecipeChallenge value)?  $default,){
final _that = this;
switch (_that) {
case _RecipeChallenge() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Recipe recipe,  Duration timeTaken,  Duration expectedTime,  DateTime dateCompleted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecipeChallenge() when $default != null:
return $default(_that.recipe,_that.timeTaken,_that.expectedTime,_that.dateCompleted);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Recipe recipe,  Duration timeTaken,  Duration expectedTime,  DateTime dateCompleted)  $default,) {final _that = this;
switch (_that) {
case _RecipeChallenge():
return $default(_that.recipe,_that.timeTaken,_that.expectedTime,_that.dateCompleted);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Recipe recipe,  Duration timeTaken,  Duration expectedTime,  DateTime dateCompleted)?  $default,) {final _that = this;
switch (_that) {
case _RecipeChallenge() when $default != null:
return $default(_that.recipe,_that.timeTaken,_that.expectedTime,_that.dateCompleted);case _:
  return null;

}
}

}

/// @nodoc


class _RecipeChallenge implements RecipeChallenge {
  const _RecipeChallenge({required this.recipe, required this.timeTaken, required this.expectedTime, required this.dateCompleted});
  

@override final  Recipe recipe;
@override final  Duration timeTaken;
@override final  Duration expectedTime;
@override final  DateTime dateCompleted;

/// Create a copy of RecipeChallenge
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecipeChallengeCopyWith<_RecipeChallenge> get copyWith => __$RecipeChallengeCopyWithImpl<_RecipeChallenge>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecipeChallenge&&(identical(other.recipe, recipe) || other.recipe == recipe)&&(identical(other.timeTaken, timeTaken) || other.timeTaken == timeTaken)&&(identical(other.expectedTime, expectedTime) || other.expectedTime == expectedTime)&&(identical(other.dateCompleted, dateCompleted) || other.dateCompleted == dateCompleted));
}


@override
int get hashCode => Object.hash(runtimeType,recipe,timeTaken,expectedTime,dateCompleted);

@override
String toString() {
  return 'RecipeChallenge(recipe: $recipe, timeTaken: $timeTaken, expectedTime: $expectedTime, dateCompleted: $dateCompleted)';
}


}

/// @nodoc
abstract mixin class _$RecipeChallengeCopyWith<$Res> implements $RecipeChallengeCopyWith<$Res> {
  factory _$RecipeChallengeCopyWith(_RecipeChallenge value, $Res Function(_RecipeChallenge) _then) = __$RecipeChallengeCopyWithImpl;
@override @useResult
$Res call({
 Recipe recipe, Duration timeTaken, Duration expectedTime, DateTime dateCompleted
});


@override $RecipeCopyWith<$Res> get recipe;

}
/// @nodoc
class __$RecipeChallengeCopyWithImpl<$Res>
    implements _$RecipeChallengeCopyWith<$Res> {
  __$RecipeChallengeCopyWithImpl(this._self, this._then);

  final _RecipeChallenge _self;
  final $Res Function(_RecipeChallenge) _then;

/// Create a copy of RecipeChallenge
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? recipe = null,Object? timeTaken = null,Object? expectedTime = null,Object? dateCompleted = null,}) {
  return _then(_RecipeChallenge(
recipe: null == recipe ? _self.recipe : recipe // ignore: cast_nullable_to_non_nullable
as Recipe,timeTaken: null == timeTaken ? _self.timeTaken : timeTaken // ignore: cast_nullable_to_non_nullable
as Duration,expectedTime: null == expectedTime ? _self.expectedTime : expectedTime // ignore: cast_nullable_to_non_nullable
as Duration,dateCompleted: null == dateCompleted ? _self.dateCompleted : dateCompleted // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of RecipeChallenge
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RecipeCopyWith<$Res> get recipe {
  
  return $RecipeCopyWith<$Res>(_self.recipe, (value) {
    return _then(_self.copyWith(recipe: value));
  });
}
}

// dart format on
