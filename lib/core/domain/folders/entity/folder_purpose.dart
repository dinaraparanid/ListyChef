enum FolderPurpose {
  check, list;

  static FolderPurpose? fromOrdinal(int ordinal) => switch (ordinal) {
    0 => check,
    1 => list,
    _ => null,
  };
}
