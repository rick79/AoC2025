function read_data1(path::String)
    lines = readlines(path)
    return (stack([parse.(Int, eachsplit(line, " ", keepempty=false)) for line ∈ lines[1:end-1]]), [string(x) for x ∈ eachsplit(lines[end], keepempty=false)])
end

function read_data2(path::String)
    lines = readlines(path)
    indices = first.(findall(r"(\+|\*)", lines[end]))
    rows = Vector{Vector{Int}}()
    li = length(indices)
    le = length(lines[end])
    for i ∈ axes(indices[1:end], 1)
        numbers = zeros(Int, 0)
        for x ∈ range(indices[i], i < li ? indices[i+1]-2 : le)
            n = ""
            for y ∈ range(1, last(axes(lines, 1))-1)
                (lines[y][x] != ' ') && (n = n * lines[y][x])
            end
            append!(numbers, parse(Int, n))
        end
        push!(rows, numbers)
    end
    return (rows, [string(x) for x ∈ eachsplit(lines[end], keepempty=false)])
end


function read_data3(path::String)
    lines = readlines(path)
    m = [lines[y][x] for y ∈ eachindex(lines), x ∈ eachindex(lines[1])]
    cols = Vector{Vector{Int64}}()
    col = Vector{Int64}()
    for x ∈ axes(m, 2)
        if(all(f -> isspace(f), m[1:end - 1, x]))
            push!(cols, col)
            col = Vector{Int64}()
            continue
        end
        push!(col, parse(Int64, join(m[1:end - 1, x])))
    end
    push!(cols, col)
    return (cols, [string(x) for x ∈ eachsplit(lines[end], keepempty=false)])
end


function part_one(data::Tuple{Matrix{Int}, Vector{String}})
    res = 0
    for y ∈ axes(data[1], 1)
        (data[2][y] == "+") && (res += sum(data[1][y,1:end]))
        (data[2][y] == "*") && (res += prod(data[1][y,1:end]))
    end
    @assert(res == 7326876294741)
    println("Part One: $res")
end


function part_two(data::Tuple{Vector{Vector{Int}}, Vector{String}})
   res = 0
    for y ∈ axes(data[1], 1)
        (data[2][y] == "+") && (res += sum(data[1][y]))
        (data[2][y] == "*") && (res += prod(data[1][y]))
    end
    @assert(res == 10756006415204)
    println("Part Two: $res")
end


data1 =  read_data1("./Day06 - Trash Compactor/data.txt")
data2 =  read_data2("./Day06 - Trash Compactor/data.txt")

part_one(data1)
part_two(data2)
