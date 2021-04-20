class Lazy<T> {
  final T Function() lazyFunction;

  Lazy(this.lazyFunction);

  T _value;

  T get value {
    if (_value == null) {
      _value = lazyFunction();
    }

    return _value;
  }
}
