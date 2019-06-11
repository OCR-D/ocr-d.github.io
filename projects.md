# OCR-D Module Projects (MP)

The coordination project [OCR-D](http://ocr-d.de/) is developing
[specifications](https://ocr-d.github.io/) and a [reference
implementation](https://github.com/OCR-D/core) for the development of methods
of Optical Character Recognition (OCR) for printed historical material.

In addition, eight module projects develop prototype implementations for
various workflow steps.

The module project descriptions are taken from the database entries in GEPRIS, the
database of research funded by Deutsche Forschungsgemeinschaft (DFG).

## [MP1] Scalable Methods of Text and Structure Recognition for the Full-Text Digitization of Historical Prints, Part 1.B: Image Optimization

The project “Skalierbare Verfahren der Text- und Strukturerkennung für die
Volltextdigitalisierung historischer Drucke” has the goal of developing a
complete OCR-Workflow for a high quality mass digitization of historical prints
from the 17th-18th century. For each step in the workflow, innovative methods
should be made available as tools. Module 1.B: Bildoptimierung is the basis on
which high quality OCR provided [sic]. For each optimization, step there are a wide
variety of algorithms available, however not all of them are suitable to the
specific challenges of this projects. On the basis of prior experience and
work, the DFKI plans the identification, development and integration of
suitable methods.

* Partner(s): 
  * Deutsches Forschungszentrum für Künstliche Intelligenz (DFKI)
* URL:
  * GEPRIS: http://gepris.dfg.de/gepris/projekt/394343055?language=en
* GitHub: 
  * https://github.com/syedsaqibbukhari/docanalysis

## [MP2] Scalable Methods of Text and Structure Recognition for the Full-Text Digitization of Historical Prints, Part 2: Layout Analysis

The project “Skalierbare Verfahren der Text- und Strukturerkennung für die
Volltextdigitalisierung historischer Drucke” has the goal of developing a
complete OCR-Workflow for a high quality mass digitization of historical prints
from the 16th-18th century. For each step in the workflow, innovative methods
should be made available as tools. Module 2: Layouterkennung is next to OCR
itself the most important step. It improves the OCR results directly, but also
improves the general understanding of the digitized document by providing
insights to the layout and relations between the document components. For each
optimization step, there are a wide variety of algorithms available, however not
all of them are suitable to the specific challenges of this projects. On the
basis of prior experience and work, the DFKI plans the identification,
development and integration of suitable methods.

* Partner(s): 
  * Deutsches Forschungszentrum für Künstliche Intelligenz (DFKI)
* URL:
  * GEPRIS: http://gepris.dfg.de/gepris/projekt/394346204?language=en
* GitHub: 
  * https://github.com/mjenckel/LAYoutERkennung

## [MP3] Development of a semi-automatic open source tool for layout analysis and region extraction and region classificiation (LAREX) of early prints

The goal of the proposal is the further development of our efficient,
semi-automatic and easy-to-use open-source segmentation tool LAREX und its
integration in the open source workflow of the OCR-D functional model. The
preliminary work LAREX (Layout Analysis and Region EXtraction) allows both a
coarse segmentation by separation of text and non-text and a fine segmentation
by detection and classification of different textual entites. LAREX utilizes an
efficient implementation of the connected component approach. It has been used
in the digitalization of different early prints und enables a qualitative good
page segmentation with significantly less time than conventional alternatives.
The main goal of the further development of LAREX is to reduce the degree of
manual work. Therefore, a more robust segmentation und a further development of
the rule and constraint language are necessary. The basic configurations should
be easily adaptable to the peculiarities of a particular early print by both
the users and learning algorithms. Furthermore, the comfortable GUI of LAREX
for correction of single segmentation errors should be improved. This component
is also necessary for defining a ground truth for learning algorithms and for
evaluation. The overall goal is to find an optimal combination between manual
and automatic methods. The tool and the process model will be substantially
evaluated with various cooperation partners, in particular in the context of
the digitalization of early prints within the OCR-D function model including
the subsequent OCR by the linkage of external tools.

* Partner(s): 
  * Julius-Maximilians-Universität Würzburg, Institut für Informatik: Lehrstuhl für Künstliche Intelligenz und angewandte Informatik
* URL: 
  * GEPRIS: http://gepris.dfg.de/gepris/projekt/394329162?language=en
* GitHub: 
  * https://github.com/ocr-d-modul-2-segmentierung/segmentation-runner
  * https://github.com/ocr-d-modul-2-segmentierung/page-segmentation

## [MP4] NN/FST - Unsupervised OCR-Postcorrection based on Neural Networks and Finite-state Transducers

The project aims to develop a ready to use software für modul 3 (text
optimization) of the OCR-D architecture. The focus of development is in area
3.B (postcorrection) where we plan to also evaluate some up-to-date OCR systems
(area 3.A). The main technologies that we plan to use are neural nets (NN)
combined with finite-state transducers (FST) to decode recognized lines of text
within a noisy-channel model.

* Partner(s): 
  * Universität Leipzig, Institut für Informatik: Abteilung Automatische Sprachverarbeitung
* URL: 
  * GEPRIS: http://gepris.dfg.de/gepris/projekt/394341797?language=en
* GitHub: 
  * https://github.com/ocr-d-modul-2-segmentierung/segmentation-runner

## [MP5] Optimized use of OCR methods – Tesseract as a component of the OCR-D workflow

Tesseract is a free software for text recognition (optical character
recognition, OCR). This software has a history of more than 30 years of
continuous development and improvements. In the small group of open source
products for OCR Tesseract belongs to the programs with the best recognition
rates. Since end of 2016 Tesseract supports state-of-the-art text recognition by
neural networks (LSTM). The context of OCR-D requires well defined interfaces
for OCR software. The project will actively contribute to the definition of
such interfaces. It will implement them for Tesseract to allow inclusion of
Tesseract in an OCR workflow. We also strive to improve the stability,
performance and practical usability of Tesseract.

* Partner(s): 
  * Universität Mannheim, Universitätsbibliothek Mannheim
* URL: 
  * GEPRIS: http://gepris.dfg.de/gepris/projekt/394264782?language=en
* GitHub: 
  * https://github.com/OCR-D/ocrd_tesserocr

## [MP6] Automated postcorrection of OCRed historical printings with integrated optional interactive postcorrection

The obvious need to improve current methods for full-text digitalization of
historical printings represents the general background of the DFG-program
"Skalierbare Verfahren der Text- und Strukturerkennung für die
Volltextdigitalisierung historischer Drucke". Module 3 of this program in
particular explains the need for high-level postcorrection of the OCR output.
In our team we developed over several years a specialized system "PoCoTo" for
the interactive postcorrection of OCRed historical printings. Still, in the
context of mass digitization for obvious reasons systems for automated
postcorrection are clearly preferable. The main problem for automated
postcorrection is to avoid a replacement of correct OCR-tokens that are not
covered by the background correction dictionary. Building up on PoCoTo we want
to develop an advanced system for automated postcorrection that largely avoids
such 'infelicitous correction steps. To this end, the PoCoTo background
technology will be substantially extended. Since a fully automated
postcorrection will not always reach the very high quality standards needed,
the automated correction can be completed by an optional semi-automated or
interactive postcorrection. Methods for semi-automated or interactive
postcorrection that take advantage of all data and insights from the automated
correction phase will be directly integrated as part of the system.

* Partner(s): 
  * Ludwig-Maximilians-Universität München, Centrum für Informations- und Sprachverarbeitung (CIS) 
* URL: 
  * GEPRIS: http://gepris.dfg.de/gepris/projekt/393215159?language=en
* GitHub: 
  * https://github.com/cisocrgroup/ocrd-postcorrection

## [MP7] Development of a Repository for OCR Models and an Automatic Font Recognition tool in OCR-D

The project addresses the problem of strongly fluctuating recognition rates of
OCR for 16th to 18th century historical prints, limiting the full-text
digitization of material created by the VD16, VD17, and VD18
programs. Recognition models trained on modern corpora lacking the specifics of
historical prints or historic material without thorough bibliographic analysis,
retard recognition rates in comparison to the accuracy now routinely achieved
for scans of modern prints. The creation of font-specific corpora on the basis
of manual tagging is unrealistic, since both non-trivial knowledge of printing
history is necessary and the scalability of such an approach would be
insufficient. Due to the repetitiveness of the task, such an approach is also
very error-prone. The project will enable the humanities to use OCR in a
font-specific manner with limited effort. In order to achieve this the project
has three main objectives: The development of an online training infrastructure
that allows specific models to be trained for these font groups and at the same
time for different OCR software. Development of a tool for the automatic
recognition of fonts in digitizations of historical prints. In this case, an
algorithm for the recognition of fonts in incunabula is first trained using the
ground truth found in the Typenrepertorium der Wiegendrucke. In a second step
the fonts are grouped according to their similarity in order to get as few
groups as possible while maintaining OCR accuracy. Provision of a model
repository, in which developed font-specific OCR models are made available to
the public.

* Partner(s): 
  * Universität Leipzig,   Institut für Informatik: Lehrstuhl für Digital Humanities
  * Friedrich-Alexander-Universität Erlangen-Nürnberg, Department Informatik: Lehrstuhl für Informatik 5: Mustererkennung
  * Johannes Gutenberg-Universität Mainz, Gutenberg-Institut für Weltliteratur und schriftorientierte Medien: Abteilung Buchwissenschaft 
* URL: 
  * GEPRIS: http://gepris.dfg.de/gepris/projekt/394448308?language=en
* GitHub: 
  * https://github.com/seuretm/ocrd_typegroups_classifier
  * https://github.com/Doreenruirui/okralact

## [MP8] DPO-HP - Digital Preservation of OCR-D data for historical printings

In order to provide high-quality and comprehensive research in the field of
historical sciences, unrestricted access to historical sources is mandatory.
Numerous images of historical prints from the 16th to the 19th century are now
available by means of several cataloging and digitization projects. Not only
the serial cataloging, but also the mass digitization of titles has been
improved especially in the context of the “Verzeichnisse Deutscher Drucke”. The
processed works have been cataloged not only according to national
bibliographic standards, but have also been digitized to a large extent. The
bibliographic metadata standard of these images already meets the scientific
requirements. For further research, it is crucial to be able to specifically
search and use the full texts of digitized works as well. The techniques of
Optical Character Recognition (OCR) allow the mass creation of full texts. For
an immediate usage in libraries, archives and other institutions, however, the
methods used so far were not suitable, since the texts show too many
orthographic differences. There has been intensive work on easily transferable
applications that allow a high-quality mass-processing of all historical prints
from the 16th to the 19th century. This will increase the number of OCR texts
rapidly. For further usage, a sustainable preservation and identification of the
images, the bibliographic metadata as well as the encoded full texts and their
versions is obligatory. A standardized concept must be created in order to
ensure this purpose. In addition, the availability and citation of the OCR
texts is an important prerequisite for the verifiability of scientific results.
Hence OCR texts must be added to the existing archive of a digital object along
with its structure and metadata and images. Different versions of the same
starting material are created through intellectual efforts, improvements
especially in the OCR process or the usage of various OCR techniques, which
bear a new challenge for persistent identification and long-term preservation.
This problem contains aspects related to research data management and also
requires the consideration of methods and strategies for dealing with research
data. The above requirements must be conceptually prepared, integrated into an
extended context, and implemented as a technical solution in order to meet the
requirements of the data holders as well as the users. Based on this initial
situation, this project defines the necessary steps for the realization of a
solution for long-term preservation and persistent identification of OCR texts.

* Partner(s): 
  * Georg-August-Universität Göttingen, Niedersächsische Staats- und Universitätsbibliothek
  * Gesellschaft für Wissenschaftliche Datenverarbeitung mbH Göttingen 
* URL: 
  * GEPRIS: http://gepris.dfg.de/gepris/projekt/394410994?language=en
* GitHub: 
  * https://github.com/subugoe/OLA-HD-IMPL
