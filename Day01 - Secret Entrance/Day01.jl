function read_data(path::String)
    return [parse(Int, line[2:end]) * (line[1] == 'R' ? 1 : -1) for line ∈ readlines(path)]
end

data = read_data("./Day01 - Secret Entrance/data.txt")


function part_one(rotations::Array{Int}, state::Int)
    z = 0
    for r ∈ rotations
        state = mod(state + r, 100)
        (state == 0) && (z = z + 1)
    end
    return z
end
res = part_one(data, 50)
@assert(res == 1081)
println("Part One: $res")


function part_two(rotations::Array{Int}, state::Int)
    z = 0
    for r ∈ rotations
        newstate = state + (r % 100)
        ((state > 0 && newstate < 0) || newstate > 99 || newstate == 0) && (z = z + 1)
        state = mod(newstate, 100)
        z = z + abs(r ÷ 100)
    end
    return z
end
res = part_two(data, 50)
@assert(res == 6689)
println("Part Two: $res")
