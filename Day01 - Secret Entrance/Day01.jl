function read_data(path::String)
    return [parse(Int, line[2:end]) * (line[1] == 'R' ? 1 : -1) for line ∈ readlines(path)]
end


function part_one(rotations::Array{Int}, state::Int)
    res = 0
    for r ∈ rotations
        state = mod(state + r, 100)
        (state == 0) && (res = res + 1)
    end
    @assert(res == 1081)
    println("Part One: $res")
end

function part_two(rotations::Array{Int}, state::Int)
    res = 0
    for r ∈ rotations
        newstate = state + (r % 100)
        ((state > 0 && newstate < 0) || newstate > 99 || newstate == 0) && (res = res + 1)
        state = mod(newstate, 100)
        res = res + abs(r ÷ 100)
    end
    @assert(res == 6689)
    println("Part Two: $res")
end


data = read_data("./Day01 - Secret Entrance/data.txt")

part_one(data, 50)
part_two(data, 50)


