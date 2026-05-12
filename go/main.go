// SnapAPI Go quickstart — turn https://numerixlabs.com into a PDF.
// Docs: https://numerixlabs.com/docs
package main

import (
	"bytes"
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"os"
)

const apiURL = "https://api.numerixlabs.com/screenshot"

type request struct {
	URL    string `json:"url"`
	Format string `json:"format"`
	Width  int    `json:"width"`
}

func screenshot(apiKey, url, out string) error {
	body, err := json.Marshal(request{URL: url, Format: "pdf", Width: 1280})
	if err != nil {
		return err
	}

	req, err := http.NewRequest(http.MethodPost, apiURL, bytes.NewReader(body))
	if err != nil {
		return err
	}
	req.Header.Set("Authorization", "Bearer "+apiKey)
	req.Header.Set("Content-Type", "application/json")

	resp, err := http.DefaultClient.Do(req)
	if err != nil {
		return err
	}
	defer resp.Body.Close()

	if resp.StatusCode < 200 || resp.StatusCode >= 300 {
		msg, _ := io.ReadAll(resp.Body)
		return fmt.Errorf("SnapAPI %d: %s", resp.StatusCode, msg)
	}

	f, err := os.Create(out)
	if err != nil {
		return err
	}
	defer f.Close()

	_, err = io.Copy(f, resp.Body)
	return err
}

func main() {
	apiKey := os.Getenv("SNAPAPI_KEY")
	if apiKey == "" {
		fmt.Fprintln(os.Stderr, "error: set SNAPAPI_KEY first (export SNAPAPI_KEY=sk_...)")
		fmt.Fprintln(os.Stderr, "       grab a free trial key at https://numerixlabs.com/trial")
		os.Exit(1)
	}

	if err := screenshot(apiKey, "https://numerixlabs.com", "numerixlabs.pdf"); err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}
	fmt.Println("Saved numerixlabs.pdf")
}
