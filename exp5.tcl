#Aim:-exp5
set ns [new Simulator]
set nf [open out.nam w]
$ns namtrace-all $nf

proc finish {} {
global ns nf
$ns flush-trace
close $nf
exec nam out.nam &
exit 0
}

set n1 [$ns node]
set n2 [$ns node]

$ns duplex-link $n1 $n2 10Mb 10ms DropTail
$ns queue-limit $n1 $n2 20

$ns at 5.0 "finish"
$ns run
