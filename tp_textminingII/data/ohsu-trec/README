This README file describes all the data files associated with the
OHSUMED document collection as it was used for the TREC-9
Filtering Track.  Please see "The TREC-9 Filtering Track Final
Report" by Stephen Robertson and David A. Hull in the TREC-9
proceedings for a description of the tasks performed in the track.

(A) Description of the OHSUMED document collection (files: ohsumed.*)

The OHSUMED test collection is a set of 348,566 references from
MEDLINE, the on-line medical information database, consisting of
titles and/or abstracts from 270 medical journals over a five-year
period (1987-1991). The available fields are title, abstract, MeSH
indexing terms, author, source, and publication type. The National
Library of Medicine has agreed to make the MEDLINE references in the
test database available for experimentation, restricted to the
following conditions:

1. The data will not be used in any non-experimental clinical,
library, or other setting.
2.  Any human users of the data will explicitly be told that the data
is incomplete and out-of-date.

The OHSUMED document collection was obtained by William Hersh
(hersh@OHSU.EDU) and colleagues for the experiments described in the
papers below:

Hersh WR, Buckley C, Leone TJ, Hickam DH, OHSUMED: An interactive
retrieval evaluation and new large test collection for research, 
Proceedings of the 17th Annual ACM SIGIR Conference, 1994, 192-201.

Hersh WR, Hickam DH, Use of a multi-application computer workstation
in a clinical setting, Bulletin of the Medical Library Association,
1994, 82: 382-389.

Here are the field definitions:

 .I      sequential identifier 
	 (important note: documents should be processed in this order)
 .U      MEDLINE identifier (UI) 
	 (<DOCNO> used for relevance judgements)
 .M      Human-assigned MeSH terms (MH)
 .T      Title (TI)
 .P      Publication type (PT)
 .W      Abstract (AB)
 .A      Author (AU)
 .S      Source (SO)

Note: some abstracts are truncated at 250 words and some references
have no abstracts at all (titles only). We do not have access to the
full text of the documents.

(B) Description of the topic statements (files: query.*)

There were three different sets of filtering topics for the
TREC-9 Filtering track: 
(1) a subset of 63 of the original query set developed by Hersh et al.xi
    for their IR experiments (OHSUMED),
(2) a set of 4904 MeSH terms and their definitions (MSH), and
(3) a subset of 500 of the MeSH terms (MSH-SMP).
 
The existing OHSUMED topics describe actual information needs, but the
relevance judgements probably do not have the same coverage provided
by the TREC pooling process. The MeSH terms do not directly represent
information needs, rather they are controlled indexing terms. However,
the assessment should be more or less complete and there are a lot of
them, so this provides an unusual opportunity to work with a very
large topic sample.

The topic statements are provided in the standard TREC format and
consist of <title> and <desc> (= description) fields only. The meaning
of these fields is slightly different for each query type.

(1) OHSUMED topics (files: query.ohsu.*)

<title> = patient description
<desc>  = information request

The test collection was built as part of a study assessing the use of
MEDLINE by physicians in a clinical setting (Hersh and Hickam, above).
Novice physicians using MEDLINE generated 106 queries. Only a subset
of these queries were used in the TREC-9 Filtering Track. Before
they searched, they were asked to provide a statement of information
about their patient as well as their information need.

(2) MeSH topics (files: query.mesh.*)

<title> = MeSH concept name
<desc> = MeSH scope note, a definition of the concept (source: MeSH 2000)

The National Library of Medicine has authorized us to use a subset of
the MeSH 2000 scope notes for Filtering Track experiments with the
OHSUMED collection. If you wish to use the MeSH scope notes for any
other purpose, please visit the NLM Web Site,
		http://www.nlm.nih.gov/mesh/
sign the attached Memorandum of Understanding, and download the full
MeSH 2000 database directly from the source.

The subset of the MeSH topics used for the MSH-SMP runs is defined
by the file "sample.map".  The perl script mesh-sample.prl will
produce a file containing only the 500 topics in the subset
from the file containing the full set of 4904 topics.

(3) Use of MeSH term field (.M) during filtering

TREC-9 filtering track participants were allowed to use
the MeSH term field (.M) during the filtering of the
OHSU topic set provided the use of the field was noted in 
the run description.  The entire MeSH term field was *not*
allowed to be accessed during the filtering of the MeSH topic set.
Information on the presence or absence of the specific MeSH term
represented in the filtering topic is contained in the relevant
document files described below (simulating human judgement).

(C) Description of the relevance judgements (files: qrels.*)

The format of the relevance judgements is slightly different for the
two topic sets.

(1) OHSUMED relevance judgements (files: qrels.ohsu.*)

Format: <topic-ID> \t <DOCNO> \t <Relevant> \n

<DOCNO> - MEDLINE identifier (.U/UI)
<Relevant> - 1 = possibly relevant, 2 = definitely relevant

Each query was replicated by four searchers, two physicians
experienced in searching and two medical librarians.  The results were
assessed for relevance by a different group of physicians, using a
three point scale: definitely, possibly, or not relevant.  The list of
documents explicitly judged to be not relevant is not provided here.
Over 10% of the query-document pairs were judged in duplicate to
assess inter-observer reliability.  For evaluation, all documents
judged here as either possibly or definitely relevant were
considered relevant.  TREC-9 systems were allowed to distinguish
between these two categories during the learning process if desired.

(2) MeSH relevance judgments (files: qrels.mesh.*)

Format: <topic-ID> \t <DOCNO> \n

<DOCNO> - MEDLINE identifier (.U/UI)

A document is considered "relevant" to a MeSH "topic" if the MeSH
concept name is listed in the MeSH term field (.M) of the document.
Please note that the MeSH concepts form a hierarchy. It is common
practice to index a document *only* by the most specific MeSH concept
that is relevant.

(D) Description of the ohsu-trec directories

Here we describe the contents of the three sub-directories of
ohsu-trec.

(1) pre-test - directory of material for preliminary system testing

 ohsumed.87@ - MEDLINE references from 1987 (note: this is a symbolic
               link to the actual document file located in trec9-train)

 query.ohsu.test.1-43  - set of 43 OHSU test topics
 query.mesh.test.1-119 - set of 119 MeSH test topics

 qrels.ohsu.test.87 - relevance judgements for OHSU test topics (1987)
 qrels.mesh.test.87 - relevance judgements for MeSH test topics (1987)

This directory is intended for people interested in doing some
preliminary testing of their filtering system on this domain.
Important note: the test topics available here are *not* an unbiased
sample of the TREC-9 topics. In particular, they are the ones that
were specifically rejected from the official runs for a variety of
reasons (usually because they had too many or too few relevance
judgments). Therefore, they should not be used for optimizing system
parameters, just for general tests to make sure that the system is
functioning properly.

(2) trec9-train - directory of TREC-9 training material

 ohsumed.87 - MEDLINE references from 1987

 query.ohsu.1-63     - set of 63 TREC-9 OHSU topics
 query.mesh.1-4904   - set of 4904 TREC-9 MeSH topics

 qrels.ohsu.adapt.87 - training qrels / OHSU / adaptive filtering (1987)
 qrels.ohsu.batch.87 - training qrels / OHSU / batch filtering (1987)
 qrels.mesh.adapt.87 - training qrels / MeSH / adaptive filtering (1987)
 qrels.mesh.batch.87 - training qrels / MeSH / batch filtering (1987)

This directory contains all the training material for the TREC-9
filtering task. Routing systems should use the same data as the batch
filtering systems. The 1987 OHSUMED documents are intended for
training purposes only. The batch filtering qrels files contain all
the evaluated documents for the 1987 collection. The OHSU qrels for
adaptive filtering contain two documents judged definitely relevant
for each topic. The MeSH qrels for adaptive filtering contain four
documents assigned to each topic. In both case, the training samples
extracted for adaptive filtering were selected by random sampling.
TREC-9 participants were allowed to use the 1987 OHSUMED collection
for generating collection summary statistics (such as IDF) or other
purposes (for adaptive filtering runs such use had to be declared).

(3) trec9-test  - directory of TREC-9 test material

 ohsumed.88-91 - MEDLINE references from 1988-1991

 qrels.ohsu.88-91 - relevance judgements for OHSU topics
 qrels.mesh.88-91 - relevance judgements for MeSH topics

This directory contains the documents and relevance judgements used
to run the official TREC-9 Filtering Track experiments.  TREC-9
participants were allowed to use the relevance judgement for a
document only after that document was retrieved.  Relevance
judgements from documents not retrieved were never accessed
(except for the final evaluation).
