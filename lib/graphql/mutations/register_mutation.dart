const String registerMutation = r'''
mutation Register($input: RegisterInput!) {
  register(input: $input) {
    token
    user {
      id
      name
      email
    }
  }
}
''';
