repro
========

Minimal example of an issue where a `local_repository` that is
used as a `CROSSTOOL` seemingly does not execute the `WORKSPACE`
of the repo.

Expectation
------------

When running:

```
$ cd proj
$ bazel build -s --config=clang //...
```

the `clang` archive is downloaded, extracted, and used as a
`CROSSTOOL` as defined in the included `bazel_clang` "repo".



Findings
----------

Instead, the archive (`@ubuntu_archive`) is not downloaded,
and the references to the workspace that are in the `BUILD`
come up as errors (because it does not exist).


Furthermore, it seems the `bazel_clang/WORKSPACE` file is never
even parsed. Typing random garbage (syntax error) does not
trigger a _new_ error, just the missing workspace error.




Reproduction
-------------

This is agnostic to OS (just have to change URL and SHA hash).
Tested on Ubuntu and MacOS.

```
# cd into this repo

$ cd $REPO_DIR

# cd into the dependent project

$ cd proj

# build with the default toolchain to confirm
# a working setup and baseline

$ bazel build -s //...

# clean and rebuild with `clang` config
# -- THIS SHOULD ERROR --

$ bazel clean --expunge
$ bazel build -s --config=clang //...

# cd to the crosstool dir/repo

$ cd ../bazel_clang

# build with default to re-confirm

$ bazel build -s /...

# now try with clang
# -- THIS SHOULD SUCCEED --

$ bazel build -s --config=clang //...
```
