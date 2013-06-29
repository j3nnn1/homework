This is the version of OHSUMED corpus as used during TREC-9 filtering track. The corpus can
be obtained from this page:

	http://trec.nist.gov/data/t9_filtering.html

Please see the original OHSU_TREC9-README.txt for detailed information about the corpus.

The build process builds two corpora from this collection: one that uses the trec9-train/
data, and the other that uses trec9-test data.

There are two types of topics (queries) in this collection, and they are significantly
different. The MeSH topics contain just the MeSH concept in the title, which quite often
doesn't occur in the relevant documents - instead these documents match terms
from the topic's "description" field. The OHSU topics often use colloquial and
inconsistent abbreviations such as "60 yo" for "60 year old" (but often also
"60 y o" or "60 yr old"). In this case as well, the matching terms appear only in
the description field of the topic and not in the title.

The description of the TREC filtering track underlines that qrels are NOT ranked by
relevance, instead they simply list relevant documents in random order. Therefore any
metrics that assume a ranked retrieval will require either some preprocessing step
(such as sorting of qrels by relevance+docId) or may be inapplicable to this corpus.
