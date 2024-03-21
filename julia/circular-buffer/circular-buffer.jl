mutable struct CircularBuffer{T} <: AbstractVector{T}
    const capacity::Integer
    first::Integer
    length::Integer
    elems::Array{T}

    function CircularBuffer{T}(capacity::Integer) where {T}
        new(capacity, 1, 0, Array{T}(undef, capacity))
    end
end

function Base.push!(cb::CircularBuffer{T}, item::T; overwrite::Bool=false) where {T}

    if overwrite && isfull(cb)
        cb.elems[cb.first] = item
        cb.first = cb.first + 1
        if cb.first > cb.capacity
            cb.first = 1
        end
    elseif isfull(cb)
        throw(BoundsError())
    else
        next = cb.first + cb.length
        if next > cb.capacity
            next %= cb.capacity
        end
        cb.elems[next] = item
        cb.length += 1
    end

    cb
end

function Base.popfirst!(cb::CircularBuffer)
    cb.length == 0 && throw(BoundsError())

    item = cb.elems[cb.first]
    cb.length -= 1
    cb.first = cb.first + 1
    if cb.first > cb.capacity
        cb.first = 1
    end
    item
end

function Base.empty!(cb::CircularBuffer)
    cb.length = 0
    cb
end

function Base.length(cb::CircularBuffer)
    cb.length
end

function Base.size(cb::CircularBuffer)
    (length(cb),)
end

function capacity(cb::CircularBuffer)
    cb.capacity
end

function isfull(cb::CircularBuffer)
    cb.length == cb.capacity
end

function Base.getindex(cb::CircularBuffer, i::Int)
    (i > cb.length || i < 1) && throw(BoundsError())

    position = cb.first + i - 1
    if position > cb.capacity
        position %= cb.capacity
    end
    cb.elems[position]
end

function Base.setindex!(cb::CircularBuffer{T}, item::T, i::Int) where {T}
    (i > cb.length || i < 1) && throw(BoundsError())

    position = cb.first + i - 1
    if position > cb.capacity
        position %= cb.capacity
    end
    cb.elems[position] = item
end

function Base.append!(cb::CircularBuffer{T}, items::UnitRange{T}; overwrite::Bool=false) where {T}
    for item in items
        push!(cb, item; overwrite=overwrite)
    end
end

function Base.pushfirst!(cb::CircularBuffer{T}, item::T; overwrite::Bool=false) where {T}
    if overwrite && isfull(cb)
        new_first = cb.first - 1
        if new_first < 1
            new_first = cb.capacity
        end
        cb.elems[new_first] = item
        cb.first = new_first
    elseif isfull(cb)
        throw(BoundsError())
    else
        new_first = cb.first - 1
        if new_first < 1
            new_first = cb.capacity
        end
        cb.elems[new_first] = item
        cb.first = new_first
        cb.length += 1
    end

    cb
end

function Base.pop!(cb::CircularBuffer)
    (cb.length == 0) && throw(BoundsError())

    item = last(cb)
    cb.length -= 1
    item
end
