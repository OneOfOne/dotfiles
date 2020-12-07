zmodload zsh/mathfunc
function perc {
	local val="$1"
	local p="${2:-25}"
	(( p < 1 )) && p=$(( p * 100.0 ))
	let pp=$(( val * (p/100.0) ));
	printf "%g%% of %g = %g | [+] %g | [-] %g\n" $p $val $pp $(( val + pp )) $(( val - pp ))
}

function percopt {
	local optPrice="$1"
	local cnt="${2:-1}"
	local p="${3:-20}"
	local optFee="${4:-0.65}"
	local val=$(( ((optPrice * 1000) + ((cnt * (optFee * 1000))/1000) ) / 1000 ))
	(( p < 1 )) && p=$(( p * 100.0 ))
	let pp=$(( val * (p/100.0) ));
	printf "%g%% of %g + %g fee x %g = %g | [+] %g | [-] %g\n" $p $(( optPrice * 100 )) $(( optFee * cnt )) $cnt $pp $(( val + pp )) $(( val - pp ))
}
