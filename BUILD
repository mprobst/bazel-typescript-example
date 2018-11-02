load(":ts_library.bzl", "ts_library")

ts_library(name = "user",
           srcs = ["user.ts", "name_formatting.ts"])

ts_library(name = "date", srcs = ["date.ts"])

ts_library(
    name = "birthday_card",
    srcs = ["birthday.ts"],
    deps = [":user", ":date"],
)
