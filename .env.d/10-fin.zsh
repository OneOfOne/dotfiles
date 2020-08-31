zmodload zsh/mathfunc
function perc {
	local val="$1"
	local p="${2:-25}"
	(( p < 1 )) && p=$(( p * 100.0 ))
	let pp=$(( val * (p/100.0) ));
	printf "%g%% of %g = %g | [+] %g | [-] %g\n" $p $val $pp $(( val + pp )) $(( val - pp ))
}
