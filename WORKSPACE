workspace(name = "rules_guile")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")  # fetching http archives

# rules_foreign_cc is used to build guile from source
http_archive(
    name = "rules_foreign_cc",
    sha256 = "bcd0c5f46a49b85b384906daae41d277b3dc0ff27c7c752cc51e43048a58ec83",
    strip_prefix = "rules_foreign_cc-0.7.1",
    url = "https://github.com/bazelbuild/rules_foreign_cc/archive/0.7.1.tar.gz",
)
load("@rules_foreign_cc//foreign_cc:repositories.bzl", "rules_foreign_cc_dependencies")
rules_foreign_cc_dependencies()

# Load guile_register_toolchains from this project and setup the build environment
load("@rules_guile//guile:guile.bzl", "guile_repository")
guile_repository(
    name = "guile"
)
