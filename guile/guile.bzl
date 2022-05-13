load(
  "//guile/internal:repository.bzl",
  _guile_repository = "guile_repository",
)

load(
  "//guile/internal:rules.bzl",
  _guile_binary = "guile_binary", 
  _guile_library = "guile_library", 
  _guile_test = "guile_test"
)

guile_repository = _guile_repository
guile_binary = _guile_binary
guile_library = _guile_library
guile_test = _guile_test
