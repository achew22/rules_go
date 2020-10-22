# Copyright 2016 The Bazel Go Rules Authors. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

load(
    "@io_bazel_rules_go//go/private:context.bzl",
    "go_context",
)
load(
    "//go/private:providers.bzl",
    "CgoContextInfo",
    "GoConfigInfo",
)

def _stdlib_impl(ctx):
    go = go_context(ctx)
    source, library = go.toolchain.actions.stdlib(go)
    return [source, library, source.stdlib]

stdlib = rule(
    implementation = _stdlib_impl,
    attrs = {
        "cgo_context_data": attr.label(providers = [CgoContextInfo]),
        "_go_config": attr.label(
            default = "//:go_config",
            providers = [GoConfigInfo],
        ),
    },
    doc = """stdlib builds the standard library for the target configuration
or uses the precompiled standard library from the SDK if it is suitable.""",
    toolchains = ["@io_bazel_rules_go//go:toolchain"],
)
