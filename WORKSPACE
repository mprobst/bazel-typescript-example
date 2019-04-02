load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "build_bazel_rules_nodejs",
    sha256 = "213dcf7e72f3acd4d1e369b7a356f3e5d9560f380bd655b13b7c0ea425d7c419",
    urls = ["https://github.com/bazelbuild/rules_nodejs/releases/download/0.27.9/rules_nodejs-0.27.9.tar.gz"],
)

load("@build_bazel_rules_nodejs//:defs.bzl", "node_repositories")

node_repositories(package_json = ["//:package.json"])
