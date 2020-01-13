# FAQ

## General

### Where can I start my journey into the OCR-D ecosphere?

### Who is the target audience of OCR-D?

### Where can I get support on OCR-D?

### What is the difference between OCR-D and ABBYY?

### What is the difference between OCR-D and Tesseract?

### What is the difference between OCR-D and TRANSKRIBUS?

### What is the difference between OCR-D and ocrd4all?

### Is OCR-D production-ready?

### Which formats are supported by OCR-D?

### Why does OCR-D need METS files? How can I process images without METS?

<!-- @wrznr: Not possible, not desired. The METS file is actually not needed but rather provided by the framework. -->

### How much does it cost to deploy OCR-D?

### What are the system requirements for OCR-D-software?

## CLI

### How can I find out the version of OCR-D software?

### How do I get help on specific CLI commands?

Every command and subcommand supports the `--help` option to print a description, arguments and options:

```sh
ocrd --help
ocrd workspace --help
ocrd workspace add --help
```

### How can I specify parameters on the command line?

### How do I specify multiple input/output file groups?

### How to configure logging?

## OCR-D module project software

### Where can I find official OCR-D module project software?

### Which third-party OCR-D-compatible software exists?

### Which processors are available?

## Workflows and processors

### How can I define workflows?

### Where can I find sample workflows to experiment with?

### How to handle failing workflows?

### Why do some processors have multiple input or output file groups?

### Where can I learn about the input and output file groups of a processor?

### How can I validate my workflow is correctly wired?

### Where can I learn about the parameters of a processor?

## `ocrd_all`

### What is `ocrd_all`?

### How to update `ocrd_all`?

### How to debug `ocrd_all` problems?

### I used `sudo` and now everything is broken

## Training

### I want to train a custom OCR model. Where do I start?

## OCR-D-Ground Truth

### Which of the three transcription levels specified in the [Transcription Guidelines] (https://ocr-d.github.io/gt//trans_documentation/transkription.html) was used for the GT of OCR-D?

### Are the three transcription levels designed hierarchically? Meaning, does level 3 include level 2 and level 1?

### I want to make some GT myself. Which level should I use? Can I mix levels?

### I have some transcriptions of early modern books, but I didn't stick to the OCR-D GT guidelines. Would my transcriptions still be useful for OCR-D?
