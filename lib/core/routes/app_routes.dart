enum AppRoutes {
  root("/"),
  splash('/splash'),

  // Auth
  authSignIn('/auth/sign-in'),
  authSignUp('/auth/sign-up'),
  authMe('/auth/me'),

  // Home
  home('/home'),
  ;

  const AppRoutes(this.path);
  final String path;
}
