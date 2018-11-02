TypeScriptInfo = provider(fields=["dts", "js"])

def outfile(ctx, s, ext):
    return ctx.actions.declare_file(s.short_path.replace(".ts", ext))

def _ts_library_impl(ctx):
    js = [outfile(ctx, s, ".js") for s in ctx.files.srcs]
    dts = [outfile(ctx, s, ".d.ts") for s in ctx.files.srcs]
    deps_dts = [dep[TypeScriptInfo].dts for dep in ctx.attr.deps]
    deps_js = [dep[TypeScriptInfo].js for dep in ctx.attr.deps]

    inputs = depset(ctx.files.srcs, transitive=deps_dts)
    outputs = js + dts
    ctx.actions.run(
        executable = ctx.executable._node,
        progress_message = "Compiling TypeScript",
        inputs = depset(ctx.files.srcs + ctx.files._tsc, transitive=deps_dts),
        outputs = outputs,
        arguments = [
            ctx.file._tsc.path,
            "--declaration", "--outDir", ctx.bin_dir.path
        ] + [i.path for i in inputs],
    )

    return [
        DefaultInfo(files=depset(js+dts)),
        TypeScriptInfo(
            dts=depset(dts, transitive=deps_dts),
            js=depset(js, transitive=deps_js),
        )
    ]

ts_library = rule(
    implementation = _ts_library_impl,
    attrs = {
        "srcs": attr.label_list(allow_files=True),
        "deps": attr.label_list(),
        "_node": attr.label(
            doc = """The node entry point target.""",
            default = Label("@nodejs//:node"),
            allow_files = True,
            executable = True,
            cfg = "host",
            single_file = True),
        "_tsc": attr.label(
            # executable = True,
            cfg = "host",
            allow_files = True,
            single_file = True,
            default = Label("//:node_modules/typescript/lib/tsc.js"),
        ),
    },
)
