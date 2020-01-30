# We need the "OffsetArrays" package for 0-based arrays to work
# Feel free to comment-out the following two lines once the package
# is installed
import Pkg
Pkg.add("OffsetArrays")

# Enable 0-based indexing
using OffsetArrays


# Number of doctors
D = 9

# Number of days
T = 365

# Day-of-the-week for first day
F = 4

# Daytime: We need 3 doctors every weekday during, 2 doctors on Sat-Sun
# Nighttime: We need 1 doctor every nighttime
Lday = fill(3, 0:6)
Lday[5:6] .= 2
Lnight = fill(2, 0:6)

# Availability: two doctors missing every day (taking turns)
A = fill(1, 0:(D-1), 0:(T-1))
for t in 0:T-1
	A[mod(t, D), t] = 0
	A[mod(t + 1, D), t] = 0
end

# Points:
#  Mon-Thu: 1, Fri-Sun: 4
#  Mon-Thu: 8, Fri-Sun: 12
Pday = fill(1, 0:6)
Pnight = fill(8, 0:6)
Pday[4:6] .= 4
Pnight[4:6] .= 12

# Setup the result arrays
daytime = fill(false, 0:(D-1), 0:(T-1))
nighttime = fill(false, 0:(D-1), 0:(T-1))

# Suppress output
nothing
