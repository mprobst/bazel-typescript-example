load(":ts_library.bzl", "ts_library")

ts_library(
    name = "date",
    srcs = ["date.ts"],
)

ts_library(
    name = "user",
    srcs = [
        "name_formatting.ts",
        "user.ts",
    ],
    deps = [":date"],
)

ts_library(
    name = "birthday_card",
    srcs = ["birthday.ts"],
    deps = [
        ":date",
        ":user",
    ],
)
