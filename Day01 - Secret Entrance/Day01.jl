function read_data(path::String)
    return [parse(Int, line[2:end]) * (line[1] == 'R' ? 1 : -1) for line ∈ readlines(path)]
end

data = read_data("./Day01 - Secret Entrance/data.txt")


function part_one(rotations::Array{Int}, state::Int)
    z = 0
    for r ∈ rotations
        (state = (state + r) % 100) < 0 && (state = (state % 100) + 100)
        (state == 0) && (z = z + 1)
    end
    return z
end
res = part_one(data, 50)
println("Part One: $res")

#= Brute force... 
function part_two(rotations::Array{Int}, state::Int)
    z = 0
    for r ∈ rotations
        s = sign(r)
        for i ∈ range(s, r % 100, step = s)
            state = state + s
            (state == 100) && (state = 0)
            (state == -1) && (state = 99)
            (state == 0) && (z = z + 1)
        end
        z = z + abs(r ÷ 100)        
    end
    return z
end
res = part_two(data, 50)
println("Part Two: $res")
=#

function part_two(rotations::Array{Int}, state::Int)
    z = 0
    for r ∈ rotations
        newstate = state + (r % 100)
        ((state > 0 && newstate < 0) || newstate > 99 || newstate == 0) && (z = z + 1)
        (state = newstate % 100) < 0 && (state = (state % 100) + 100)
        z = z + abs(r ÷ 100)
    end
    return z
end
res = part_two(data, 50)
println("Part Two: $res")

#6689