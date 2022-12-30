# RubyRay

![Test workflow](https://github.com/cannikin/rubyray/actions/workflows/test.yml/badge.svg)

Implements a ray tracing engine as described in The Ray Tracer Challenge: https://pragprog.com/titles/jbtracer/the-ray-tracer-challenge/

<img src="https://user-images.githubusercontent.com/300/112259688-f494c080-8c25-11eb-8188-a9bb2e1f7311.png" width="300" alt="The Ray Tracer Challenge, by Jamis Buck" />

## Test Suite

Run the test suite with:

    rake

To have the test runner watch for changes (both in source files and tests) and automatically re-run, use
the `rerun` command. It executes with the options in the `.rerun` config file:

    rerun
