#!/bin/bash
################################################################################
set +f
GLOBIGNORE=*
typeset st=$(date +%s)
typeset et=$(date +%s)
typeset tt=0
################################################################################
typeset -a gr=(0 1 2 3 4 5 6 7 8 9 A B C D E)
typeset -a gd=(0 1)
typeset -a gs=(A B C D)
typeset -a gz=(000H)
typeset -r of="tmp.card"
typeset -a gh
typeset ga=2
typeset gb
typeset a
typeset b
typeset c
typeset -a d
typeset e
typeset -a f
typeset g
typeset h
typeset -a i
typeset j
typeset k
typeset -A x
typeset y
typeset z
################################################################################
log(){
	echo "Start Time (Sec)  : ${st}"
	echo "End Time (Sec)    : ${et}"
	echo "Total Time (Sec)  : ${tt}"
	echo "Loop Count        : ${c}"
	echo "Array Count       : ${#a[@]}"
	echo "Array Position    : ${b}"
	echo "Array Symbol      : ${a[${b}]}"
	echo "Working Card      : ${z}"
	echo "Card Symbol       : ${e:0:2}"
	echo "Card Direction    : ${e:2:1}"
	echo "Card Next Card    : ${e:3:1}"
	echo "Array             : ${a[@]}"
}
################################################################################
card_build(){
	hper(){
		if [ ${#2} == 2 ]; then
			if [ ${2:0:1} == 6 ] || [ ${2:0:1} == 7 ]; then
				gh=(${gh[@]} ${2})
			fi
		fi
		if [ ${ga} != 0 ]; then
			for h in ${gr[@]}; do
				ga=$((${1}-1))
				gb=${2}${h}
				hper ${ga} ${gb}
			done
		else
			return;
		fi
	}
	hper ${ga}
	
	for a in ${gh[@]}; do
		for b in ${gs[@]}; do
			c=${b}${a}
			d=(${d[@]} ${c})
		done
	done
	typeset -r g=${#d[@]}
	unset a
	unset b
	unset c
	
	for a in ${gh[@]}; do
		for b in ${gd[@]}; do
			for c in ${gs[@]}; do
				e=${a}${b}${c}
				f=(${f[@]} ${e})
			done
		done
	done
	typeset -r f=(${f[@]} ${gz[@]})
	typeset -r h=${#f[@]}
	unset a
	unset b
	unset c
	unset e
	
	echo "States         :${#gs[@]}"
	echo "Symbols        :${#gh[@]}"
	echo "char_set       :${gr[@]}"
	echo "direction_set  :${gd[@]}"
	echo "state_set      :${gs[@]}"
	echo "halt_set       :${gz[@]}"
	echo "hexchar_set    :${gh[@]}"
	echo "array_key_set  :${d[@]}"
	echo "array_key_set_size"
	echo "hexset:${#gh[@]} * state_set:${#gs[@]} ="
	echo "${g}"
	echo ""
	echo "array_potential_value_set"
	echo "${f[@]}"
	echo ""
	echo "array_potential_value_set_size"
	echo "hexset:${#gh[@]} * direction_set:${#gd[@]} * state_set:${#gs[@]} + 1 ="
	echo "${h}"
	echo ""
	
	a=${g}
	b=${h}
	while [ ${a} != 0 ]; do
		while [ ${a} != 0 ]; do
			c=$(($RANDOM % ${b}))
			e=${f[${c}]}
			i=(${i[@]} ${e})
			((a--))
		done
		j=${i[@]//[^H]}
		if [ ${#j} != 1 ]; then
			unset i
			a=${g}
		elif [ ${i[0]} == "000H" ]; then
			unset i
			a=${g}
		fi
	done
	unset a
	unset b
	unset c
	unset e
	
	echo "random_instruction_set"
	echo "${i[@]}"
	echo ""
	
	y=0
	for z in ${d[@]}; do
		x[${z}]=${i[${y}]}
		((y++))
	done
	unset y
	unset z
	
	echo "final_instruction_set"
	echo ""
	echo "Do you want to output it pretty? (z/x)"
	read -n 1 k
	echo ""
	
	y=0
	if [ ${k:0:1} == z ]; then
		echo "Might have to scroll... sorry"
		for z in ${d[@]}; do
			a=${x[${z}]}
			echo "${z} - ${a}"
		done
	else
		echo "Could be a bit random looking... sorry"
		echo "${!x[@]}"
		echo "${x[@]}"
	fi
	echo ""
	unset a
	unset k
	
	echo "#!/bin/sh" > ./${of}
	echo "c2(){" >> ./${of}
	for z in ${d[@]}; do
		a=${x[${z}]}
		echo "    c[${z}]=\"${x[${z}]}\"" >> ./${of}
	done
	echo "}" >> ./${of}
	echo "" >> ./${of}
	
	echo "Ready to run it?"
	read -n 1 k
	echo ""
}
################################################################################
run_turing(){
	typeset a=([0]=60)
	typeset b=0
	typeset c=0
	typeset e="600A"
	st=$(date +%s)
	while [ ${e:3:1} != H ];do
		z=${e:3:1}${a[${b}]:-60}
		e=${x[${z}]}
		a[${b}]=${e:0:2}
		b=$((${b}+${e:2:1}))
		if [ ${e:2:1} == 0 ];then
			if [ ${b} == 0 ];then
				a=(60 ${a[@]})
			else
				((b--))
			fi
		fi
		((c++))
		r=$(echo ${a[@]} | xxd -r -p)
		echo "${r}"
	done
	et=$(date +%s)
	tt=$((${et}-${st}))
	echo "HALT"
	log
}
################################################################################
clear
card_build
run_turing
exit 0;
