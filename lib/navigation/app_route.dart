enum AppRoute {
  root(path: '/'),
  auth(path: '/auth'),
  signIn(path: '/auth/signIn'),
  signUp(path: '/auth/signUp'),
  main(path: '/main'),
  cart(path: '/main/cart'),
  recipes(path: '/main/recipes'),
  profile(path: '/main/profile');

  static const queryEmail = 'email';

  final String path;
  const AppRoute({required this.path});
}
