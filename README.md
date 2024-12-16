# RubyRay

![Test workflow](https://github.com/cannikin/rubyray/actions/workflows/test.yml/badge.svg)

Implements a ray tracing engine as described in The Ray Tracer Challenge: https://pragprog.com/titles/jbtracer/the-ray-tracer-challenge/

<img src="https://user-images.githubusercontent.com/300/112259688-f494c080-8c25-11eb-8188-a9bb2e1f7311.png" width="300" alt="The Ray Tracer Challenge, by Jamis Buck" />

## Render

In the `examples` directory are subdirectories per chapter from the book. Invoke one with Ruby to render a .ppm file in the same directory:

```bash
ruby examples/chapter1/run.rb
```

You'll end up with `render-100x50.ppm` file which can be opened with Mac Preview.

To render at a larger size, set ENV vars:

```bash
WIDTH=640 HEIGHT=480 ruby examples/chapter1/run.rb
```

## Test Suite

Run the test suite with:

    rake

To have the test runner watch for changes (both in source files and tests) and automatically re-run, use
the `rerun` command. It executes with the options in the `.rerun` config file:

    rerun
