function read_data(path::String)
    return [parse.(Int, split(line, "")) for line ∈ readlines(path)]
end

data = read_data("./Day03 - Lobby/data.txt")

function turnon(bank::Vector{Int}, n::Int)
    joltage = 0
    p = 1
    for i ∈ range(n, 1, step = -1)
        b = 0
        Δp = 0
        for (i, j) ∈ enumerate(bank[p:(end-i+1)])
            if(j > b)
                b = j
                Δp = i
            end                  
        end
        joltage = joltage*10+b
        p = p + Δp
    end
    return joltage
end

function part_one(banks::Vector{Vector{Int}})
    res = sum([turnon(bank, 2) for bank ∈ banks])
    @assert(res == 17311)
    println("Part One: $res")
end

function part_two(banks::Vector{Vector{Int}})
    res = sum([turnon(bank, 12) for bank ∈ banks])
    @assert(res == 171419245422055)
    println("Part Two: $res")
end

part_one(data)
part_two(data)
