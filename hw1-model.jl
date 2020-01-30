using JuMP
using Cbc

md = Model(with_optimizer(Cbc.Optimizer))

# Variables
@variable(md, x[d in 0:(D-1), t in 0:(T-1)])
@variable(md, y[d in 0:(D-1), t in 0:(T-1)])
@variable(md, Pmax >= 0)

# Model
@objective(md, Min, Pmax)

@constraint(md, [d in 0:(D-1)], sum(x[d,t]*Pday[mod(F+t,7)] for t in 0:(T-1)) + sum(x[d,t]*Pnight[mod(F+t,7)] for t in 0:(T-1)) <= Pmax)

@constraint(md, [t in 0:(T-1)], sum(x[d,t] for d in 0:(D-1)) >= Lday[mod(F+t,7)])

@constraint(md, [t in 0:(T-1)], sum(y[d,t] for d in 0:(D-1)) >= Lnight[mod(F+t,7)])

@constraint(md, [d in 0:(D-1), t in 0:(T-1)], x[d,t] <= A[d,t])

@constraint(md, [d in 0:(D-1), t in 0:(T-1)], y[d,t] <= A[d,t])

@constraint(md, [t in 0:(T-2), d in 0:(D-1)], y[d,t] + x[d,t+1] <= 1)

@constraint(md, [t in 0:(T-3), d in 0:(D-1)], 2*y[d,t] + y[d,t+1] + y[d,t+2] <= 2)

# Solve Model
optimize!(md)

# Generate printable Variables
for d in 0:(D-1)
        for t in 0:(T-1)
                if value(x[d,t]) > 0.5
                        daytime[d,t] = true
                end

                if value(y[d,t]) > 0.5
                        nighttime[d,t] = true
                end
        end
end
