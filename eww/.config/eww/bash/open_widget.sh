#!/bin/bash
WIN=$(eww active-windows)
if [[ $WIN == *"$1"* ]]
then 
	eww close $1
	else
	eww open "$@"
fi
