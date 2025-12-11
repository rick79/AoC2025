function read_data(path::String)
    return Dict([string(match(r"[a-zA-Z]*(?=\:)", line).match) => string.(split(match(r"(?<=\: )([a-zA-Z]*\s*)*", line).match, " ")) for line ∈ readlines(path)])
end


function traverse(start::String, G::Dict{String, Vector{String}}, stop = "out", required = Set{String}())
    cache = Dict{Tuple{String, Set{String}}, Int64}()
    function traverse_inner(node::String, req::Set{String})
        haskey(cache, (node, req)) && return cache[(node, req)]
        (node == stop) && return length(req) == length(required) ? 1 : 0
        (node ∈ required) && push!(req, node)
        return (cache[(node, req)] = sum([traverse_inner(n, copy(req)) for n ∈ G[node]]))
    end
    return traverse_inner(start, Set{String}())
end

function part_one(data)
    res = traverse("you", data)
    println("Part One: $res")
end

function part_two(G)
    res = traverse("svr", G, "out", Set(["dac", "fft"]))
    println("Part Two: $res")
end


data = read_data("./Day11 - Reactor/data.txt")

using BenchmarkTools

#part_one(data)
@benchmark part_two(data)