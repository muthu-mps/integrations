{{- $timestamp := generate "timestamp" -}}
{{- $formattedTimestamp := $timestamp.Format "2006/01/02 15:04:05" -}}
{{- $sourceAddress := generate "SourceAddress" -}}
{{- $destinationAddress := generate "DestinationAddress" -}}
{{- $natSourceIp := generate "NatSourceIp" -}}
{{- $natDestinationIp := generate "NatDestinationIp" -}}
{{- $ruleName := generate "RuleName" -}}
{{- $sourceUser := generate "SourceUser" -}}
{{- $destinationUser := generate "DestinationUser" -}}
{{- $application := generate "Application" -}}
{{- $virtualSystem := generate "VirtualSystem" -}}
{{- $zone := generate "Zone" -}}
{{- $interface := generate "Interface" -}}
{{- $logAction := generate "LogAction" -}}
{{- $sessionId := generate "SessionId" -}}
{{- $repeatCount := generate "RepeatCount" -}}
{{- $sourcePort := generate "SourcePort" -}}
{{- $destinationPort := generate "DestinationPort" -}}
{{- $natSourcePort := generate "NatSourcePort" -}}
{{- $natDestinationPort := generate "NatDestinationPort" -}}
{{- $flags := generate "Flags" -}}
{{- $protocol := generate "Protocol" -}}
{{- $action := generate "Action" -}}
{{- $bytes := generate "Bytes" -}}
{{- $bytesReceived := generate "BytesReceived" -}}
{{- $bytesSent := generate "BytesSent" -}}
{{- $packets := generate "Packets" -}}
{{- $elapsedTime := generate "ElapsedTime" -}}
{{- $category := generate "Category" -}}
{{- $sequenceNumber := generate "SequenceNumber" -}}
{{- $sourceLocation := generate "SourceLocation" -}}
{{- $destinationLocation := generate "DestinationLocation" -}}
{{- $packetsSent := generate "PacketsSent" -}}
{{- $packetsReceived := generate "PacketsReceived" -}}
{{- $sessionEndReason := generate "SessionEndReason" -}}
{{- $threatType := generate "ThreatType" -}}
{{- $fileUrl := generate "FileUrl" -}}
{{- $threatId := generate "ThreatId" -}}
{{- $severity := generate "Severity" -}}
{{- $direction := generate "Direction" -}}
{{- $contentType := generate "ContentType" -}}
{{- $userAgent := generate "UserAgent" -}}
{{- $referer := generate "Referer" -}}
Oct 30 09:46:12 1,{{$formattedTimestamp}},01606001116,THREAT,{{$threatType}},1,{{$formattedTimestamp}},{{$sourceAddress}},{{$destinationAddress}},{{$natSourceIp}},{{$natDestinationIp}},{{$ruleName}},{{$sourceUser}},{{$destinationUser}},{{$application}},{{$virtualSystem}},{{$zone}},{{$zone}},{{$interface}},{{$interface}},{{$logAction}},{{$formattedTimestamp}},{{$sessionId}},{{$repeatCount}},{{$sourcePort}},{{$destinationPort}},{{$natSourcePort}},{{$natDestinationPort}},{{$flags}},{{$protocol}},{{$action}},"{{$fileUrl}}",{{$threatId}},{{$category}},{{$severity}},{{$direction}},0,0x0,{{$sourceLocation}},{{$destinationLocation}},0,{{$contentType}},0,,,1,{{$userAgent}},,,{{$referer}},,,,0,0,267,24,19,0,,de-fwpm1-spelle,,,,post,0,,0,2022/11/29 12:59:46,N/A,unknown,AppThreat-0-0,0x0,0,4294967295,,"computer-and-internet-info,low-risk",9d9738ea-f704-4b0f-90cf-a62bcbad0236,542331861,,,,,,,,,,,,,,,,,,,,,,,,,,,,,0,2022-11-29T13:00:01.051+01:00,,,,general-business,saas,browser-based,1,"pervasive-use,is-saas,is-fedramp,is-hipaa,is-soc1,is-soc2,is-ip-based-restrictions",windows-azure,windows-azure-base,yes,no