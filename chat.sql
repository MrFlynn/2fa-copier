SELECT text
	FROM message
	WHERE cache_has_attachments IS NOT 1
	ORDER BY date DESC 
	LIMIT 1;
