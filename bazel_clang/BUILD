package(default_visibility = ['//visibility:public'])

cc_toolchain_suite(
    name = "clang",
    toolchains = {
         "k8|clang": ":clang_linux",
    },
)

filegroup(name = "empty")

filegroup(
    name = "clang_ubuntu_binaries",
    srcs = ["@ubuntu_archive//:binaries"] + glob(["wrappers/*.sh"]),
)
filegroup(
    name = "clang_ubuntu_files",
    srcs = [
        ":clang_ubuntu_binaries",
        "@ubuntu_archive//:includes",
        "@ubuntu_archive//:runtime_libs",
    ],
)

cc_toolchain(
    name = "clang_linux",
    cpu = "k8",

    all_files = ":clang_ubuntu_files",
    compiler_files = ":clang_ubuntu_binaries",
    dwp_files = ":clang_ubuntu_binaries",
    dynamic_runtime_libs = [":empty"],
    linker_files = ":clang_ubuntu_binaries",
    objcopy_files = ":clang_ubuntu_binaries",
    static_runtime_libs = [":empty"],
    strip_files = ":empty",
    supports_param_files = 0,
)





###
### EXAMPLE TO SHOW IT WORKS IN LOCAL WORKSPACE
###

alias(
    name = "bin",
    actual = "//src/bin:bin",
    visibility = ["//visibility:public"],
)

alias(
    name = "lib",
    actual = "//src/lib:lib",
    visibility = ["//visibility:public"],
)
