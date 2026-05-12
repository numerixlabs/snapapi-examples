<?php
// SnapAPI PHP quickstart — turn https://numerixlabs.com into a PDF.
// Docs: https://numerixlabs.com/docs

declare(strict_types=1);

function snapapi_screenshot(string $apiKey, string $url, string $out, string $format = 'pdf', int $width = 1280): string
{
    $ch = curl_init('https://api.numerixlabs.com/screenshot');
    curl_setopt_array($ch, [
        CURLOPT_POST => true,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_TIMEOUT => 60,
        CURLOPT_HTTPHEADER => [
            'Authorization: Bearer ' . $apiKey,
            'Content-Type: application/json',
        ],
        CURLOPT_POSTFIELDS => json_encode([
            'url' => $url,
            'format' => $format,
            'width' => $width,
        ]),
    ]);

    $body = curl_exec($ch);
    $status = curl_getinfo($ch, CURLINFO_RESPONSE_CODE);
    $err = curl_error($ch);
    curl_close($ch);

    if ($body === false) {
        throw new RuntimeException('cURL error: ' . $err);
    }
    if ($status < 200 || $status >= 300) {
        throw new RuntimeException("SnapAPI {$status}: {$body}");
    }

    file_put_contents($out, $body);
    return $out;
}

$apiKey = getenv('SNAPAPI_KEY');
if (!$apiKey) {
    fwrite(STDERR, "error: set SNAPAPI_KEY first (export SNAPAPI_KEY=sk_...)\n");
    fwrite(STDERR, "       grab a free trial key at https://numerixlabs.com/trial\n");
    exit(1);
}

try {
    $out = snapapi_screenshot($apiKey, 'https://numerixlabs.com', 'numerixlabs.pdf');
    echo "Saved {$out}\n";
} catch (Throwable $e) {
    fwrite(STDERR, $e->getMessage() . "\n");
    exit(1);
}
