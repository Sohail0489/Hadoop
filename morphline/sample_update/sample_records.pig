A = LOAD '/warehouse/made/work/solr/goldenrecordcollection' using PigStorage('\t');
B = FILTER A BY $390 IS NOT NULL;
C = LIMIT B 10;
D = STORE C into '/warehouse/made/work/solr/sample_collection_11' using PigStorage('\t');

