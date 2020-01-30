# We need the "OffsetArrays" package for 0-based arrays to work
# Feel free to comment-out the following two lines once the package
# is installed
import Pkg
Pkg.add("OffsetArrays")

# Enable 0-based indexing
using OffsetArrays


# Number of doctors
D = 7

# Number of days
T = 31

# Day-of-the-week for first day
F = 2

# Daytime: We need 3 doctors every weekday during, 2 doctors on Sat-Sun
# Nighttime: We need 2 doctors every nighttime
Lday = fill(3, 0:6)
Lday[5:6] .= 2
Lnight = fill(2, 0:6)

# Availability: one doctor missing every day (taking turns)
A = fill(1, 0:(D-1), 0:(T-1))
for t in 0:T-1
	A[mod(t, D), t] = 0
end

# Points:
#  Mon-Thu: 1, Fri-Sun: 2
#  Mon-Thu: 3, Fri-Sun: 5
Pday = fill(1, 0:6)
Pnight = fill(3, 0:6)
Pday[4:6] .= 2
Pnight[4:6] .= 5

# Setup the result arrays
daytime = fill(false, 0:(D-1), 0:(T-1))
nighttime = fill(false, 0:(D-1), 0:(T-1))

# Suppress output
nothing
