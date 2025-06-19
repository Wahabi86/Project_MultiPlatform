const String loginMutation = r'''
mutation Login($email: String!, $password: String!) {
  login(email: $email, password: $password) {
    token
    user {
      id
      name
      email
      role {
        name
      }
    }
  }
}
''';
