//%attributes = {}
var $AIClient : cs:C1710.AIKit.OpenAI
$AIClient:=cs:C1710.AIKit.OpenAI.new()
$AIClient.baseURL:="http://127.0.0.1:8080/v1"

var $options : cs:C1710.AIKit.OpenAIEmbeddingsParameters
$options:=cs:C1710.AIKit.OpenAIEmbeddingsParameters.new()

var $text : Text
$text:="Hello world"

/*
the first call may take some time!
*/

var $response : Object
$response:=$AIClient.embeddings.create($text; "nomic-embed-text-v1.5.f16.gguf"; $options)
