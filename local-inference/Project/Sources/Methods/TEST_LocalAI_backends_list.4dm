//%attributes = {"invisible":true}
var $LocalAI : cs:C1710.LocalAI.backends
$LocalAI:=cs:C1710.LocalAI.backends.new()

var $backends : Collection
$backends:=$LocalAI.list()