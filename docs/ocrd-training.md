# Running start for OCR-D Training infrastructure

## General links

* OCR-related: https://github.com/kba/awesome-ocr
* OCR ground truth related: https://github.com/cneud/ocr-gt

## Ground truth

* PAGE ground truth: http://www.ocr-d.de/daten
* Test assets in real-life form (METS + BagIt): https://github.com/OCR-D/assets

## OCR engines

In order of preference

* Tesseract 4
  * https://github.com/OCR-D/ocrd-train 
* kraken / ketos
  * https://github.com/mittagessen/kraken
  * https://github.com/OCR-D/ocrd_kraken
* Ocropus
  * https://github.com/tmbdev/ocropy
  * https://github.com/OCR-D/ocrd_ocropy
* Calamari
  * https://github.com/Calamari-OCR/calamari
  * https://github.com/kba/ocrd_calamari

## Line and page ground truth

* All engines can be trained by providing
  * line images
  * line transcription
  * configuration

* Different engines have different conventions (e.g. `foo.png <-> foo.txt` or `foo.gt.txt <-> foo.gt.png`)

* Our ground truth is PAGE

=> Convert page data to line ground truth

## Exchange format for ground truth

* Since all engine training is essentially similar (line GT), it would be very useful to have a common exchange format

* Based on BagIt

* Metadata
  * provenance: generated from page GT, naming scheme
  * bibliographic: Work, author, year, language, rights
  * technical: image preprocessing, color depth

## Common API for training engines

* Input configuration file:
    * ZIP archive of BagIt of line ground truth
    * Output format
    * which engine + version to use
    * engine configuration
    * Deterministic dividing up training and evaluation data
* Process
  * Progress output with custom prefix and specified log format, e.g.
    * Character error rate
    * Epoch
    * ...
    * time-stamped for graphing / analysis
  * Potentially docker-ized
  * Uniform CLI
* Output ZIP archive containing
  * the trained model/snapshot in whatever configuration
  * log data
  * description of the final state of the training

## Additional tools

* PAGE-to-LineGT (see above)
* model-info (input: trained model, output: information about that model)
* Docker wrapper around CLI to make engine training wrappers scalable
