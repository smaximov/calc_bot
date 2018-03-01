[
  inputs: ["mix.exs", "{config,lib,test}/**/*.{ex,exs}"],
  import_deps: [:plug, :absinthe],
  locals_without_parens: [
    payload: 1,
    payload: 2
  ]
]
