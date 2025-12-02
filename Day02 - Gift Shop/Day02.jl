function read_data(path::String)
    return [Tuple(parse.(Int, split(r, "-"))) for r ∈ eachsplit(read(path, String), ",")]
end

data = read_data("./Day02 - Gift Shop/data.txt")


function isinvalid(id::Int, n = nothing)
    d = Int(floor(log10(id))+1)
    for i ∈ range(2, isnothing(n) ? d : n)
        (d % i != 0) && (continue)
        v = id ÷ 10^(d - (d ÷ i))
        res = sum([v*10^x for x ∈ range(0, (d - (d ÷ i)), step = d ÷ i)])
        (res == id) && (return true)
    end
    return false
end


function part_one(data::Vector{Tuple{Int, Int}})
    return sum([i for r ∈ data for i ∈ range(r[1], r[2]) if isinvalid(i, 2)])
end
res = part_one(data)
@assert(res == 22062284697)
println("Part One: $res")


function part_two(data::Vector{Tuple{Int, Int}})
   return sum([i for r ∈ data for i ∈ range(r[1], r[2]) if isinvalid(i)])
end
res = part_two(data)
@assert(res == 46666175279)
println("Part Two: $res")
