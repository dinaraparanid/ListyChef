enum AppRoute {
  root(path: '/'),
  auth(path: '/auth'),
  signIn(path: '/auth/signIn'),
  signUp(path: '/auth/signUp'),
  main(path: '/main'),
  folders(path: '/main/folders'),
  folder(path: '/main/folders/:$pathFolderId'),
  transfer(path: '/main/transfer'),
  profile(path: '/main/profile');

  static const pathFolderId = 'folder_id';

  static const queryEmail = 'email';

  final String path;
  const AppRoute({required this.path});
}
