mixin JsonMappable {
  Map<String, dynamic> mergeAttr(item, {included = const []}) {
    var attrs = {
      "success": item?['success'],
      "message": item?['message'],
      "included": included,
    };
    attrs.addAll(item?['attributes'] ?? {});
    return attrs;
  }
}