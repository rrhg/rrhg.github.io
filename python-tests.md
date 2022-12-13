

[meetup about Mocks pytests & unitest](https://github.com/rrhg/test-doubles-and-functional-programming)


1 - `fake_time = mocker.patch('writing_better_tests.time', autospec=True)`
2 - autospec allows the mock object to fail when called with a method that did not exist in the original object been mocked.
