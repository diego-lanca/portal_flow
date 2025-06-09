/// Represents the authentication status of a user within the application.
enum AuthStatus {
  /// The authentication status has not been determined yet.
  unknown,

  /// The user is successfully authenticated.
  authenticated,

  /// The user is not authenticated.
  unauthenticated,
}
