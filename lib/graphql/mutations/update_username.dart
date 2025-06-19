const String updateUsernameMutation = r'''
mutation UpdateUsername($newName: String!) {
  updateUsername(newName: $newName) {
    id
    name
    email
  }
}
''';
