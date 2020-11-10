using FindSteadyStates
using Documenter

makedocs(;
    modules=[FindSteadyStates],
    authors="= <stevengogogo4321@gmail.com> and contributors",
    repo="https://github.com/stevengogogo/FindSteadyStates.jl/",
    sitename="FindSteadyStates.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://stevengogogo.github.io/FindSteadyStates.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/stevengogogo/FindSteadyStates.jl.git",
    target = "build",
    push_preview = true,
)
