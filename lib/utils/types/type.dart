/// Type definition for a function that converts a JSON map to a model object of type [T].
typedef JsonToModel<T> = T Function(Map<String, dynamic> json);

/// Type definition for a function that converts a model object of type [T] to a JSON map.
typedef ModelToJson<T> = Map<String, dynamic> Function(T model);
