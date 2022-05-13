GuileInfo = provider(
    doc = "information about guile directories for libraries, compiled cache, and extensions",
    fields = {
        "site_dir": "path to guile site path for adding libraries",
        "ccache_dir": "path to compiled guile programs",
        "extensions_dir": "path to directory with C shared object files",
    },
)

def guile_toolchain_impl(ctx):
    toolchain_info = platform_common.ToolchainInfo(
        # main executables, the guile program and the guild compiler
        guile = ctx.file.guile,
        compiler = ctx.file.compiler,
        # directories for guile modules, compiled code, and C extensions
        # see https://www.gnu.org/software/guile/manual/html_node/Installing-Site-Packages.html
        guile_info = GuileInfo(
            site_dir = ctx.attr.site_dir,
            ccache_dir = ctx.attr.ccache_dir,
            extensions_dir = ctx.attr.extensions_dir,
        ),
    )
    return [toolchain_info]

guile_toolchain = rule(
    attrs = {
        "guile": attr.label(
            mandatory = True,
            allow_single_file = True,
            cfg = "exec",
            doc = "the guile executable program",
        ),
        "compiler": attr.label(
            mandatory = True,
            allow_single_file = True,
            cfg = "exec",
            doc = "the guild compiler",
        ),
        "site_dir": attr.string(
            mandatory = True,
            doc = "path to guile site path for adding libraries",
        ),
        "ccache_dir": attr.string(
            mandatory = True,
            doc = "path to compiled guile programs",
        ),
        "extensions_dir": attr.string(
            mandatory = True,
            doc = "path to directory with C shared object files"
        )
    },
    implementation = guile_toolchain_impl,
)
