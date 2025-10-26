![version](https://img.shields.io/badge/version-21%2B-3B69E9)
![platform](https://img.shields.io/static/v1?label=platform&message=mac-intel%20|%20mac-arm%20|%20win-64&color=blue)
[![license](https://img.shields.io/github/license/miyako/4d-example-local-inference-LocalAI)](LICENSE)

# 4d-example-local-inference-LocalAI
Use LocalAI from 4D

## List Models

```4d
var $LocalAI : cs.LocalAI.models
$LocalAI:=cs.models.new()

var $models : Collection
$models:=$LocalAI.list()
```

## List Backends

```4d
var $LocalAI : cs.LocalAI.backends
$LocalAI:=cs.backends.new()

var $backends : Collection
$backends:=$LocalAI.list()
```

## Install Model

```4d
#DECLARE($params : Object)

Case of 
	: (Count parameters=0)
		
		CALL WORKER(1; Current method name; {})
		
	Else 
		
		var $LocalAI : cs.LocalAI.models
		$LocalAI:=cs.LocalAI.models.new()
		
		/*
			models_path: mandatory
			model: name of model to install
			data : string passed to callback in $2.content 
			pass a subclass of _LocalAI_Controller to cs.models.new() above 
			to process onData, onDataError, etc.
		*/
		
		var $models : Collection
		$models:=[]
		$models.push({\
		model: "localai@nomic-embed-text-v1.5"; \
		data: "installed nomic-embed-text-v1.5"; \
		models_path: Folder(fk desktop folder).folder("models")})
		
		$LocalAI.install($models; Formula(onInstall))
		
End case 
```

## Install Backend

```4d
#DECLARE($params : Object)

Case of 
	: (Count parameters=0)
		
		CALL WORKER(1; Current method name; {})
		
	Else 
		
		var $LocalAI : cs.LocalAI.backends
		$LocalAI:=cs.LocalAI.backends.new()
		
		/*
			backends_path: mandatory
			backend: name of backend to install
			data : string passed to callback in $2.content 
			pass a subclass of _LocalAI_Controller to cs.backends.new() above 
			to process onData, onDataError, etc.
		*/
		
		var $backends : Collection
		$backends:=[]
		
		Case of 
			: (Is macOS) && (Not(Get system info.macRosetta))
				$backends.push({\
				backend: "localai@metal-llama-cpp"; \
				data: "installed metal-llama-cpp"; \
				backends_path: Folder(fk desktop folder).folder("backends")})
			Else 
				$backends.push({\
				backend: "localai@cpu-llama-cpp"; \
				data: "installed cpu-llama-cpp"; \
				backends_path: Folder(fk desktop folder).folder("backends")})
		End case 
		
		$LocalAI.install($backends; Formula(onInstall))
		
End case 
```

## Start

```4d
var $LocalAI : cs.LocalAI.server
$LocalAI:=cs.LocalAI.server.new()

$isRunning:=$LocalAI.isRunning()

/*
	mandatory
	models_path,backends_path
*/

$LocalAI.run({\
models_path: Folder(fk desktop folder).folder("models"); \
backends_path: Folder(fk desktop folder).folder("backends"); \
disable_web_ui: False; \
address: "127.0.0.1:8080"; \
threads: 4; \
context_size: 2048})
```

## Terminate

```4d
var $LocalAI : cs.LocalAI.server
$LocalAI:=cs.LocalAI.server.new()
$LocalAI.terminate()
```
