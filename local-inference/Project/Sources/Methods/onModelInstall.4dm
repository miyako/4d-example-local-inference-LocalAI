//%attributes = {"invisible":true}
#DECLARE($worker : 4D:C1709.SystemWorker; $params : Object)

If ($params.type="response") && ($params.context#Null:C1517)
	ALERT:C41($params.context)
End if 

TEST_LocalAI_backends_install