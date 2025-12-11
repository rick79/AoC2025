using JuMP
using Cbc


function read_data(path::String)
    data = Vector{Tuple{Int64, Vector{Int64}, Vector{Vector{Int64}}, Vector{Int64}}}()
    for line ∈ readlines(path)
        light_diagram = string(match(r"(?<=\[)[\#|\.]*(?=\])", line).match)
        wiring_schematic_bits = Vector{Int64}()
        wiring_schematic_ints = Vector{Vector{Int64}}()
        for m ∈ eachmatch(r"(?<=\()(\d+,?)*(?=\))", line)
            r = 0
            for i ∈ parse.(Int64, split(m.match, ",")) .+ 1
                r = r | (1 << (length(light_diagram) - i))
            end
            push!(wiring_schematic_bits, r)
            push!(wiring_schematic_ints, parse.(Int64, split(m.match, ",")) .+ 1)
        end
        push!(data, (parse(Int64, replace(light_diagram, "." => "0", "#" => "1"), base = 2), wiring_schematic_bits, wiring_schematic_ints, parse.(Int64, split(match(r"(?<=\{)(\d+,?)*(?=\})", line).match, ","))))
    end
    return data
end


function solve(diagram::Int64, buttons::Vector{Int64})
    cache = Dict{Tuple{Int64, Set{Int64}}, Int}()
    function solve_inner(s, bs::Set{Int64})
        haskey(cache, (s, bs)) && return cache[(s, bs)]
        s == diagram && return length(buttons) - length(bs)
        length(bs) == 0 && return typemax(Int64)
        return (cache[(s, bs)] = min([solve_inner(s ⊻ b, delete!(copy(bs), b)) for b ∈ bs]...))
    end
    return solve_inner(0, Set(buttons))
end


function solve_lin(diagram::Vector{Int64}, buttons::Vector{Vector{Int64}})
    A = zeros(Int64, (length(diagram), length(buttons)))
    for (i, button) ∈ enumerate(buttons)
        for j ∈ button
            A[j, i] += 1
        end
    end
    model = Model(Cbc.Optimizer)
    set_silent(model)
    @variable(model, x[i=1:length(buttons)], Int)
    @constraint(model, con_vector, A * x == diagram)
    @constraint(model, con_scalar, x >= 0)
    @objective(model, Min, sum(x))
    optimize!(model)
    return Int(sum(value.(x)))
end


function part_one(data)
    res = sum([solve(line[1], line[2]) for line ∈ data])
    println("Part One: $res")
end

function part_two(data)
    res = sum([solve_lin(line[4], line[3]) for line ∈ data])
    println("Part Two: $res")
end


data = read_data("./Day10 - Factory/data.txt")
using BenchmarkTools
part_one(data)
@benchmark part_two(data)



