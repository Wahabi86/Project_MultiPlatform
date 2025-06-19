const String meQuery = r'''
query Me {
  me {
    id
    name
    email
    role {
      id
      name
    }
  }
}
''';
