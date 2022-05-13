# guile_binary rule enables executing methods inside a specified guile source file
# this is essentially a wrapper around running `guile -s file.scm -e method <arguments>`
# using the guile_toolchain
def guile_binary_impl(ctx):
    toolchain = ctx.toolchains["@rules_guile//:toolchain_type"]

    args = ctx.actions.args
    args.add("-s", ctx.file.src)
    args.add("-e", ctx.attr.method)
    args.add_joined(
        arg_name_or_values = ctx.attr.binary_args,
        join_with = " ",
    )

    ctx.actions.run(
        outputs = [ctx.outputs.executable],
        inputs = [ctx.file.src],
        executable = toolchain.guile,
        arguments = args,
    )

guile_binary = rule(
    attrs = {
        "src": attr.label(
            allow_single_file = [
                ".scm",
                ".sls",
                ".ss",
            ],
            mandatory = True,
            doc = "the file to execute",
        ),
        "method": attr.string(
            default = "main",
            doc = "name of the method in src file to run",
        ),
        "binary_args": attr.string_list(
            allow_empty = True,
            doc = "any arguments to pass to the method"
        ),
    },
    implementation = guile_binary_impl,
    toolchains = ["@rules_guile//:toolchain_type"],
    executable = True,
)

# guile_library allows us to import a guile module/library from a git repository
# the module is added to the configured site-dir from the guile toolchain
# see https://www.gnu.org/software/guile/manual/html_node/Installing-Site-Packages.html
def guile_library_impl(ctx):
    toolchain = ctx.toolchains["@rules_guile//:toolchain_type"]

    pass

guile_library = rule(
    attrs = {
        "library": attr.string(
            doc = "name of the guile library to add",
            mandatory = True,
        ),
        "url": attr.string(
            doc = "url for the library git repository",
            mandatory = True,
        ),
        "sha256": attr.string(
            doc = "git sha for the library",
            mandatory = True,
        ),
    },
    implementation = guile_library_impl,
    toolchains = ["@rules_guile//:toolchain_type"],
)

# TODO: this should implement a test suite runner for srfi-64
# see https://srfi.schemers.org/srfi-64/srfi-64.html for more
def guile_test_impl(ctx):
    toolchain = ctx.toolchains["@rules_guile//:toolchain_type"]

    pass

guile_test = rule(
    attrs = {
        "test": attr.label(
            mandatory = True,
            doc = "a name for the test(s)"
        ),
        "srcs": attr.label_list(
            allow_files = [
                ".scm",
                ".sls",
                ".ss",
            ],
            mandatory = True,
            doc = "list of file(s) with the test(s) to run"
        ),
    },
    implementation = guile_test_impl,
    toolchains = ["@rules_guile//:toolchain_type"],
    test = True,
)
