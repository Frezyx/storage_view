class StorageViewerFilter {
  const StorageViewerFilter({
    required this.type,
    required this.asc,
  });

  final ViewerFilterType type;
  final bool asc;

  factory StorageViewerFilter.initial() =>
      const StorageViewerFilter(type: ViewerFilterType.key, asc: true);

  StorageViewerFilter copyWith({
    ViewerFilterType? type,
    bool? asc,
  }) {
    return StorageViewerFilter(
      type: type ?? this.type,
      asc: asc ?? this.asc,
    );
  }
}

enum ViewerFilterType {
  key(0),
  value(1),
  type(2);

  final int filterIndex;
  const ViewerFilterType(this.filterIndex);

  static ViewerFilterType fromIndex(int filterIndex) {
    switch (filterIndex) {
      case 1:
        return ViewerFilterType.value;
      case 2:
        return ViewerFilterType.type;
      case 0:
      default:
        return ViewerFilterType.key;
    }
  }
}
