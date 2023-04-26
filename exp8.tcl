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

set udp1 [new Agent/UDP]
set udp2 [new Agent/UDP]

$ns attach-agent $n1 $udp1
$ns attach-agent $n1 $udp2

set sink1 [new Agent/Null]
set sink2 [new Agent/Null]

$ns attach-agent $n2 $sink1

$ns connect $udp1 $sink1

set cbr1 [new Application/Traffic/CBR]

$cbr1 attach-agent $udp1
$cbr1 set packetSize_ 500
$cbr1 set interval_ 0.005

$ns at 0.2 "$cbr1 start"
$ns at 4.5 "$cbr1 stop"

$ns at 5.0 "finish"
$ns run
