function RangeFloat(from, to)
    return {
        type = "RangeFloat",
        from = from,
        to = to,
        random = function(self)
            return (self.to - self.from) * love.math.random() + self.from
        end
    }
end

function RangeInt(from, to)
    return {
        type = "RangeInt",
        from = from,
        to = to,
        random = function(self)
            return love.math.random(from, to)
        end
    }
end
