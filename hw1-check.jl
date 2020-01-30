using Printf

wd = fill("", 0:6)
wd[0] = "Mon"
wd[1] = "Tue"
wd[2] = "Wed"
wd[3] = "Thu"
wd[4] = "Fri"
wd[5] = "Sat"
wd[6] = "Sun"
for t in 0:(T-1)
	@printf(" %s %3d ||", wd[mod(t + F, 7)], t)
	
	for d in 0:(D-1)
		@printf("  %s%s%s  |",
			(A[d, t] >= 1.0) ? " " : "x",
			daytime[d, t] ? "D" : " ",
			nighttime[d, t] ? "N" : " ")
	end
	
	kday = Lday[mod(t + F, 7)]
	knight = Lnight[mod(t + F, 7)]
	
	@printf("| D(%2d) N(%2d)", kday, knight)
	
	nday = sum(daytime[d, t] ? 1 : 0 for d in 0:(D-1))
	nnight = sum(nighttime[d, t] ? 1 : 0 for d in 0:(D-1))
	
	if (nday != kday)
		@printf(" Day:%d/%d", nday, kday)
	end
	
	if (nnight != knight)
		@printf(" Night:%d/%d", nnight, knight)
	end
	
	@printf("\n")
end

@printf(" Points  ||")

for d in 0:(D-1)
	@printf(" %4.0f  |",
		sum(
			(daytime[d, t] ? Pday[mod(t + F, 7)] : 0) +
			(nighttime[d, t] ? Pnight[mod(t + F, 7)] : 0)
			for t in 0:(T-1)))
end

@printf("|\n")
