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

set n0 [$ns node]
set n1 [$ns node]

$ns duplex-link $n1 $n0 10mb 10ms DropTail
$ns queue-limit $n1 $n0 20

set tcp1 [new Agent/TCP] 
set sink [new Agent/TCPSink]


$ns attach-agent $n1 $tcp1
$ns attach-agent $n0 $sink


$ns connect $tcp1 $sink

set ftp [new Application/FTP]

$ftp attach-agent $tcp1
$ns at 0.2 "$ftp start"
$ns at 4.5 "$ftp stop"

$ns at 5.0 "finish"
$ns run
