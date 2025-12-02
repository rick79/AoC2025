function read_data(path::String)
    return [Tuple(parse.(Int, split(r, "-"))) for r ∈ eachsplit(read(path, String), ",")]
end

data = read_data("./Day02 - Gift Shop/data.txt")


# function isinvalid(id::Int)
#     d = Int(floor(log10(id))+1)
#     (d % 2 != 0) && (return false)
#     v = id ÷ 10^(d ÷ 2)
#     return ((v * 10^(d ÷ 2)) + v) == id
# end

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
    res = 0
    for r ∈ data
        for i ∈ range(r[1], r[2])
            if(isinvalid(i, 2))
                res = res + i
            end
        end
    end     
    return res   
end
res = part_one(data)
println("Part One: $res")

function part_two(data::Vector{Tuple{Int, Int}})
    res = 0
    for r ∈ data
        for i ∈ range(r[1], r[2])
            if(isinvalid(i))
                res = res + i
            end
        end
    end     
    return res   
end
res = part_two(data)
println("Part Two: $res")
