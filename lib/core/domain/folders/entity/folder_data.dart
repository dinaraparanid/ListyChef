import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:listy_chef/core/domain/auth/entity/email.dart';
import 'package:listy_chef/core/domain/folders/entity/folder_purpose.dart';

part 'folder_data.freezed.dart';

@freezed
abstract class FolderData with _$FolderData {
  const factory FolderData({
    required Email email,
    required String title,
    required FolderPurpose purpose,
  }) = _FolderData;
}
