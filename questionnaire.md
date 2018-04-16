# OCR-D Questionnaire for MP

## Personnel

Please list the members of your project, specify their roles (e.g. project leader, staff etc.)
and name a contact person for

  - Technical questions
  - Administrative issues
  - Project background (i.e. content-related aspects)

## Technical Stack

### CPU / GPU

  - [ ] x86_64
  - [ ] i386
  - [ ] ARM
  - [ ] Our software requires a dedicated GPU to run
  - [ ] Our software CANNOT be run in a virtual environment
  - [ ] Our software MUST NOT be run in a virtual environment


### What Programming Language is your tool implemented in?

  - [ ] Java
  - [ ] Python
  - [ ] C++
  - [ ] Shell Script
  - [ ] Javascript
  
### Which libraries/APIs is your software using?

Please list the external software libraries and APIs you use for various tasks:

  - **Graphics** (e.g. opencv, graphicsmagick...): `____________________`
  - **Testing** (e.g. Boost.Test, mocha, unittests): `____________________`
  - **Machine Learning** (e.g. Tensorflow, torch ...): `____________________`
  - **Other** (e.g. Boost, Spring Boot, Node.JS): `____________________`

### Database

Does your tool require a database to be running?

#### Which database? How is it set up?

### Interactivity

The tools provided by MP should be exectuable in a mass digitization context. For the preparation/training/configuration, interactivity can be required. In what form does your software require user intervention:

- [ ] Web interface
- [ ] Editing config files
- [ ] Local application

How can these applications be installed?


## Licensing

### Will executing the software require non-free components?

  - [ ] nope
  - [ ] yes, these: `_____________________________`
  - [ ] if yes, please specify which free alternatives are available: `_____________________________`
  
### Will extending the software require non-free components?

For example, if one needs a commercial product to generate/train models

  - [ ] nope
  - [ ] yes, these: `_____________________________`
  - [ ] if yes, please specify which free alternatives are available: `_____________________________`
  
## Input data

### If your software expects descriptive metadata (related to the content), in what file format?
  * [ ] METS/MODS 
  * [ ] JSON-LD
  
### How do you intend to encode technical image metadata?
  * [ ] Not at all.
  * [ ] XMP
  * [ ] EXIF
  * [ ] MIX (http://www.loc.gov/standards/mix/)
  
### What kind of **input files** does your algorithm expect?
  * [ ] unprocessed images
  * [ ] preprocessed images
    * [ ] cropped
    * [ ] despeckled
    * [ ] dewarped
    * [ ] binarized 
  * [ ] text
    * [ ] plain text
    * [ ] line-by-line
  * [ ] layout information
    * [ ] print space
    * [ ] print space + columns
    * [ ] print space + columns + regions
    * [ ] print space + columns + regions + lines

### What kind of **non-input-file resources** does your algorithm expect?

  * [ ] data primitives (strings, ints, floats, booleans ...)
  * [ ] binary structured data (image masks, trained models etc.)\
  * [ ] textual structured data (JSON data files eg.)
  * [ ] Other: `________`

### What **file formats** does your algorithm consume?

* text
  * [ ] PAGE (any version specific features you need)
  * [ ] ALTO
  * [ ] Abbyy XML
  * [ ] hOCR
  * [ ] TEI
  * [ ] text/plain
  * [ ] other: `________`
* image
  * [ ] PNG
  * [ ] JPEG
  * [ ] TIFF
  * [ ] JPEG2000
  
### What is the **cardinality of inputs** to your algorithm?

  * [ ] no input file
  * [ ] one input file
  * [ ] multiple input files of the same type
  * [ ] multiple input files, of different type


### Do you intend to use your algorithm within the context of a digitization workflow software? If yes, which one?

  * [ ] Kitodo.Production
  * [ ] Goobi
  * [ ] ZEND
  * [ ] VisualLibrary
  * [ ] docWORKS
  * [ ] dwork
  * [ ] MyCoRe
  * [ ] Other: `__________________`


###  Are there additional information you are interested in?
  - [ ] Page segmentation
  - [ ] Line segmentation
  - [ ] Segmentation Classification
  - [ ] Used Fonts
  - [ ] OCR Model (for which algorithm)
  - [ ] ...
  
## Output data

### What **file formats** does your algorithm produce?

* text
  * [ ] PAGE (any version specific features you need)
  * [ ] ALTO
  * [ ] Abbyy XML
  * [ ] hOCR
  * [ ] TEI
  * [ ] text/plain
  * [ ] other: `________`
* image
  * [ ] PNG
  * [ ] JPEG
  * [ ] TIFF
  * [ ] JPEG2000

### What is the **cardinality of outputs** to your algorithm?

  * [ ] no output file
  * [ ] one output file
  * [ ] multiple output files of the same type
  * [ ] multiple output files, of different type

### What kind of **non-output-file resources** does your algorithm produce?

(such as models, training data, characterization/profiling results....)

`_______________`

### Which Pixel density (PPI/DPI) does your algorithm expect?

  - [ ] A fixed value: `____________`
  - [ ] At least `__________` at most `________`
  - [ ] Flexible, depending on input
  
Is your algorithm aware of pixel density, does it change the pixel density, i.e. does it resize images?

## Logging and Provenance

### Do you use a logging library?

  - [ ] java.util.logging
  - [ ] log4j
  - [ ] logback
  - [ ] slf4j
  - [ ] Python's `logging`
  - [ ] Other: `_______________`

### Where do you log?

  - [ ] STDOUT/STDERR
  - [ ] Log file
  - [ ] Web service (e.g. logstash): `_______`
  - [ ] Other: `_______________`

### Would capturing STDOUT/STDERR as logging data be a problem?

  - [ ] Nope
  - [ ] Yes, because `_________________`

### In which format do you log messages?

  - [ ] Free-form text
  - [ ] Patterned text
  - [ ] jUnit XML
  - [ ] JSON

### How do you intend to encode proveneance metadata (information about the inputs, outputs, result, runtime etc. of the process)?

  * [ ] Not at all.
  * [ ] ProvONE
  * [ ] prov-o
  * [ ] PMD
  * [ ] Other: `___________________`
    
## Runtime

### How long do you expect the algorithm to run?

Please give the estimate in seconds for minimal input (and define "minimal input" for your algorithm):

`_____________`

Please give the estimate in seconds for typical input (and define "typical input" for your algorithm):

`_____________`

### What is the maximum input your algorithm can handle on reasonable hardware?

(I.e. how many files of what size, concurrently)

`_______________________`
  
### Which errors may occur during execution?

## Ground Truth

### What kind of ground truth do you need?
- [ ] only images 
- [ ] images with text
    - [ ] plain text
    - [ ] line-by-line
- [ ] images with text and layout element
    - [ ] print space
    - [ ] print space + columns
    - [ ] print space + columns + regions
    - [ ] print space + columns + regions + lines
- [ ] images without text but with text regions
    - [ ] print space
    - [ ] print space + columns
    - [ ] print space + columns + regions
    - [ ] print space + columns + regions + lines
 - [ ] word list(s)
 - [ ] other `_____________`

### Which image format do you need?
- [ ] Tiff (uncompressed)
- [ ] Tiff (compressed)
- [ ] JPG2000

### What is the ground truth size? How many samples (images, images+text, images+region) do you need for your application?
`_____________`

