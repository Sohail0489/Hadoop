<?xml version="1.0" encoding="UTF-8"?>
<!-- Solr managed schema - automatically generated - DO NOT EDIT -->
<schema name="gold" version="1.5">
  <uniqueKey>LoyaltyCardNumber</uniqueKey>
  <types>
    <fieldType name="alphaOnlySort" class="solr.TextField" sortMissingLast="true" omitNorms="true">
      <analyzer>
        <tokenizer class="solr.KeywordTokenizerFactory"/>
        <filter class="solr.LowerCaseFilterFactory"/>
        <filter class="solr.TrimFilterFactory"/>
        <filter class="solr.PatternReplaceFilterFactory" replace="all" replacement="" pattern="([^a-z])"/>
      </analyzer>
    </fieldType>
    <fieldType name="ancestor_path" class="solr.TextField">
      <analyzer type="index">
        <tokenizer class="solr.KeywordTokenizerFactory"/>
      </analyzer>
      <analyzer type="query">
        <tokenizer class="solr.PathHierarchyTokenizerFactory" delimiter="/"/>
      </analyzer>
    </fieldType>
    <fieldType name="binary" class="solr.BinaryField"/>
    <fieldType name="boolean" class="solr.BoolField" sortMissingLast="true"/>
    <fieldType name="currency" class="solr.CurrencyField" precisionStep="8" currencyConfig="currency.xml" defaultCurrency="USD"/>
    <fieldType name="date" class="solr.TrieDateField" precisionStep="0" positionIncrementGap="0"/>
    <fieldType name="descendent_path" class="solr.TextField">
      <analyzer type="index">
        <tokenizer class="solr.PathHierarchyTokenizerFactory" delimiter="/"/>
      </analyzer>
      <analyzer type="query">
        <tokenizer class="solr.KeywordTokenizerFactory"/>
      </analyzer>
    </fieldType>
    <fieldType name="double" class="solr.TrieDoubleField" precisionStep="0" positionIncrementGap="0"/>
    <fieldType name="float" class="solr.TrieFloatField" precisionStep="0" positionIncrementGap="0"/>
    <fieldType name="ignored" class="solr.StrField" multiValued="true" indexed="false" stored="false"/>
    <fieldType name="int" class="solr.TrieIntField" precisionStep="0" positionIncrementGap="0"/>
    <fieldType name="location" class="solr.LatLonType" subFieldSuffix="_coordinate"/>
    <fieldType name="location_rpt" class="solr.SpatialRecursivePrefixTreeFieldType" distErrPct="0.025" geo="true" maxDistErr="0.000009" units="degrees"/>
    <fieldType name="long" class="solr.TrieLongField" precisionStep="0" positionIncrementGap="0"/>
    <fieldType name="lowercase" class="solr.TextField" positionIncrementGap="100">
      <analyzer>
        <tokenizer class="solr.KeywordTokenizerFactory"/>
        <filter class="solr.LowerCaseFilterFactory"/>
      </analyzer>
    </fieldType>
    <fieldType name="string_low_controlled" class="solr.TextField" sortMissingLast="true">
      <analyzer type="index">
        <tokenizer class="solr.KeywordTokenizerFactory"/>
        <filter class="solr.LowerCaseFilterFactory"/>
        <filter class="solr.TrimFilterFactory"/>
      </analyzer>
      <analyzer type="query">
        <tokenizer class="solr.KeywordTokenizerFactory"/>
        <filter class="solr.LowerCaseFilterFactory"/>
        <filter class="solr.TrimFilterFactory"/>
      </analyzer>
	  </fieldType>
    <fieldType name="string_low_trim" class="solr.TextField" sortMissingLast="true">
      <analyzer type="index">
        <tokenizer class="solr.KeywordTokenizerFactory"/>
        <filter class="solr.SynonymFilterFactory" expand="false" synonyms="synonyms.txt" ignoreCase="true"/>
        <filter class="solr.LowerCaseFilterFactory"/>
        <filter class="solr.TrimFilterFactory"/>
      </analyzer>
      <analyzer type="query">
        <tokenizer class="solr.KeywordTokenizerFactory"/>
        <filter class="solr.SynonymFilterFactory" expand="false" synonyms="synonyms.txt" ignoreCase="true"/>
        <filter class="solr.LowerCaseFilterFactory"/>
        <filter class="solr.TrimFilterFactory"/>
      </analyzer>
	  </fieldType>
    <fieldType name="string_low_trim_employment" class="solr.TextField" sortMissingLast="true">
      <analyzer type="index">
        <tokenizer class="solr.KeywordTokenizerFactory"/>
        <filter class="solr.SynonymFilterFactory" expand="false" synonyms="synonyms-employment.txt" ignoreCase="true"/>
        <filter class="solr.LowerCaseFilterFactory"/>
        <filter class="solr.TrimFilterFactory"/>
      </analyzer>
      <analyzer type="query">
        <tokenizer class="solr.KeywordTokenizerFactory"/>
        <filter class="solr.SynonymFilterFactory" expand="false" synonyms="synonyms-employment.txt" ignoreCase="true"/>
        <filter class="solr.LowerCaseFilterFactory"/>
        <filter class="solr.TrimFilterFactory"/>
      </analyzer>
	  </fieldType>
	  <fieldType name="payloads" class="solr.TextField" indexed="true" stored="false">
      <analyzer>
        <tokenizer class="solr.WhitespaceTokenizerFactory"/>
        <filter class="solr.DelimitedPayloadTokenFilterFactory" encoder="float"/>
      </analyzer>
    </fieldType>
    <fieldType name="pdate" class="solr.DateField" sortMissingLast="true"/>
    <fieldType name="pdouble" class="solr.DoubleField"/>
    <fieldType name="pfloat" class="solr.FloatField"/>
    <fieldType name="phonetic" class="solr.TextField" indexed="true" stored="false">
      <analyzer>
        <tokenizer class="solr.StandardTokenizerFactory"/>
        <filter class="solr.DoubleMetaphoneFilterFactory" inject="false"/>
      </analyzer>
    </fieldType>
    <fieldType name="pint" class="solr.IntField"/>
    <fieldType name="plong" class="solr.LongField"/>
    <fieldType name="point" class="solr.PointType" dimension="2" subFieldSuffix="_d"/>
    <fieldType name="random" class="solr.RandomSortField" indexed="true"/>
    <fieldType name="string" class="solr.StrField" sortMissingLast="true"/>

	<fieldType name="tdate" class="solr.TrieDateField" precisionStep="6" positionIncrementGap="0"/>
    <fieldType name="tdouble" class="solr.TrieDoubleField" precisionStep="8" positionIncrementGap="0"/>
    <fieldType name="text_ar" class="solr.TextField" positionIncrementGap="100">
      <analyzer>
        <tokenizer class="solr.StandardTokenizerFactory"/>
        <filter class="solr.LowerCaseFilterFactory"/>
        <filter class="solr.StopFilterFactory" words="lang/stopwords_ar.txt" ignoreCase="true"/>
        <filter class="solr.ArabicNormalizationFilterFactory"/>
        <filter class="solr.ArabicStemFilterFactory"/>
      </analyzer>
    </fieldType>
    <fieldType name="text_bg" class="solr.TextField" positionIncrementGap="100">
      <analyzer>
        <tokenizer class="solr.StandardTokenizerFactory"/>
        <filter class="solr.LowerCaseFilterFactory"/>
        <filter class="solr.StopFilterFactory" words="lang/stopwords_bg.txt" ignoreCase="true"/>
        <filter class="solr.BulgarianStemFilterFactory"/>
      </analyzer>
    </fieldType>
    <fieldType name="text_ca" class="solr.TextField" positionIncrementGap="100">
      <analyzer>
        <tokenizer class="solr.StandardTokenizerFactory"/>
        <filter class="solr.ElisionFilterFactory" articles="lang/contractions_ca.txt" ignoreCase="true"/>
        <filter class="solr.LowerCaseFilterFactory"/>
        <filter class="solr.StopFilterFactory" words="lang/stopwords_ca.txt" ignoreCase="true"/>
        <filter class="solr.SnowballPorterFilterFactory" language="Catalan"/>
      </analyzer>
    </fieldType>
    <fieldType name="text_cjk" class="solr.TextField" positionIncrementGap="100">
      <analyzer>
        <tokenizer class="solr.StandardTokenizerFactory"/>
        <filter class="solr.CJKWidthFilterFactory"/>
        <filter class="solr.LowerCaseFilterFactory"/>
        <filter class="solr.CJKBigramFilterFactory"/>
      </analyzer>
    </fieldType>
    <fieldType name="text_cz" class="solr.TextField" positionIncrementGap="100">
      <analyzer>
        <tokenizer class="solr.StandardTokenizerFactory"/>
        <filter class="solr.LowerCaseFilterFactory"/>
        <filter class="solr.StopFilterFactory" words="lang/stopwords_cz.txt" ignoreCase="true"/>
        <filter class="solr.CzechStemFilterFactory"/>
      </analyzer>
    </fieldType>
    <fieldType name="text_da" class="solr.TextField" positionIncrementGap="100">
      <analyzer>
        <tokenizer class="solr.StandardTokenizerFactory"/>
        <filter class="solr.LowerCaseFilterFactory"/>
        <filter class="solr.StopFilterFactory" words="lang/stopwords_da.txt" format="snowball" ignoreCase="true"/>
        <filter class="solr.SnowballPorterFilterFactory" language="Danish"/>
      </analyzer>
    </fieldType>
    <fieldType name="text_de" class="solr.TextField" positionIncrementGap="100">
      <analyzer>
        <tokenizer class="solr.StandardTokenizerFactory"/>
        <filter class="solr.LowerCaseFilterFactory"/>
        <filter class="solr.StopFilterFactory" words="lang/stopwords_de.txt" format="snowball" ignoreCase="true"/>
        <filter class="solr.GermanNormalizationFilterFactory"/>
        <filter class="solr.GermanLightStemFilterFactory"/>
      </analyzer>
    </fieldType>
    <fieldType name="text_el" class="solr.TextField" positionIncrementGap="100">
      <analyzer>
        <tokenizer class="solr.StandardTokenizerFactory"/>
        <filter class="solr.GreekLowerCaseFilterFactory"/>
        <filter class="solr.StopFilterFactory" words="lang/stopwords_el.txt" ignoreCase="false"/>
        <filter class="solr.GreekStemFilterFactory"/>
      </analyzer>
    </fieldType>
    <fieldType name="text_en" class="solr.TextField" positionIncrementGap="100">
      <analyzer type="index">
        <tokenizer class="solr.StandardTokenizerFactory"/>
        <filter class="solr.StopFilterFactory" words="lang/stopwords_en.txt" ignoreCase="true"/>
        <filter class="solr.LowerCaseFilterFactory"/>
        <filter class="solr.EnglishPossessiveFilterFactory"/>
        <filter class="solr.KeywordMarkerFilterFactory" protected="protwords.txt"/>
        <filter class="solr.PorterStemFilterFactory"/>
      </analyzer>
      <analyzer type="query">
        <tokenizer class="solr.StandardTokenizerFactory"/>
        <filter class="solr.SynonymFilterFactory" expand="true" synonyms="synonyms.txt" ignoreCase="true"/>
        <filter class="solr.StopFilterFactory" words="lang/stopwords_en.txt" ignoreCase="true"/>
        <filter class="solr.LowerCaseFilterFactory"/>
        <filter class="solr.EnglishPossessiveFilterFactory"/>
        <filter class="solr.KeywordMarkerFilterFactory" protected="protwords.txt"/>
        <filter class="solr.PorterStemFilterFactory"/>
      </analyzer>
    </fieldType>
    <fieldType name="text_en_splitting" class="solr.TextField" positionIncrementGap="100" autoGeneratePhraseQueries="true">
      <analyzer type="index">
        <tokenizer class="solr.WhitespaceTokenizerFactory"/>
        <filter class="solr.StopFilterFactory" words="lang/stopwords_en.txt" ignoreCase="true"/>
        <filter class="solr.WordDelimiterFilterFactory" generateNumberParts="1" splitOnCaseChange="1" catenateWords="1" generateWordParts="1" catenateAll="0" catenateNumbers="1"/>
        <filter class="solr.LowerCaseFilterFactory"/>
        <filter class="solr.KeywordMarkerFilterFactory" protected="protwords.txt"/>
        <filter class="solr.PorterStemFilterFactory"/>
      </analyzer>
      <analyzer type="query">
        <tokenizer class="solr.WhitespaceTokenizerFactory"/>
        <filter class="solr.SynonymFilterFactory" expand="true" synonyms="synonyms.txt" ignoreCase="true"/>
        <filter class="solr.StopFilterFactory" words="lang/stopwords_en.txt" ignoreCase="true"/>
        <filter class="solr.WordDelimiterFilterFactory" generateNumberParts="1" splitOnCaseChange="1" catenateWords="0" generateWordParts="1" catenateAll="0" catenateNumbers="0"/>
        <filter class="solr.LowerCaseFilterFactory"/>
        <filter class="solr.KeywordMarkerFilterFactory" protected="protwords.txt"/>
        <filter class="solr.PorterStemFilterFactory"/>
      </analyzer>
    </fieldType>
    <fieldType name="text_en_splitting_tight" class="solr.TextField" positionIncrementGap="100" autoGeneratePhraseQueries="true">
      <analyzer>
        <tokenizer class="solr.WhitespaceTokenizerFactory"/>
        <filter class="solr.SynonymFilterFactory" expand="false" synonyms="synonyms.txt" ignoreCase="true"/>
        <filter class="solr.StopFilterFactory" words="lang/stopwords_en.txt" ignoreCase="true"/>
        <filter class="solr.WordDelimiterFilterFactory" generateNumberParts="0" catenateWords="1" generateWordParts="0" catenateAll="0" catenateNumbers="1"/>
        <filter class="solr.LowerCaseFilterFactory"/>
        <filter class="solr.KeywordMarkerFilterFactory" protected="protwords.txt"/>
        <filter class="solr.EnglishMinimalStemFilterFactory"/>
        <filter class="solr.RemoveDuplicatesTokenFilterFactory"/>
      </analyzer>
    </fieldType>
    <fieldType name="text_es" class="solr.TextField" positionIncrementGap="100">
      <analyzer>
        <tokenizer class="solr.StandardTokenizerFactory"/>
        <filter class="solr.LowerCaseFilterFactory"/>
        <filter class="solr.StopFilterFactory" words="lang/stopwords_es.txt" format="snowball" ignoreCase="true"/>
        <filter class="solr.SpanishLightStemFilterFactory"/>
      </analyzer>
    </fieldType>
    <fieldType name="text_eu" class="solr.TextField" positionIncrementGap="100">
      <analyzer>
        <tokenizer class="solr.StandardTokenizerFactory"/>
        <filter class="solr.LowerCaseFilterFactory"/>
        <filter class="solr.StopFilterFactory" words="lang/stopwords_eu.txt" ignoreCase="true"/>
        <filter class="solr.SnowballPorterFilterFactory" language="Basque"/>
      </analyzer>
    </fieldType>
    <fieldType name="text_fa" class="solr.TextField" positionIncrementGap="100">
      <analyzer>
        <charFilter class="solr.PersianCharFilterFactory"/>
        <tokenizer class="solr.StandardTokenizerFactory"/>
        <filter class="solr.LowerCaseFilterFactory"/>
        <filter class="solr.ArabicNormalizationFilterFactory"/>
        <filter class="solr.PersianNormalizationFilterFactory"/>
        <filter class="solr.StopFilterFactory" words="lang/stopwords_fa.txt" ignoreCase="true"/>
      </analyzer>
    </fieldType>
    <fieldType name="text_fi" class="solr.TextField" positionIncrementGap="100">
      <analyzer>
        <tokenizer class="solr.StandardTokenizerFactory"/>
        <filter class="solr.LowerCaseFilterFactory"/>
        <filter class="solr.StopFilterFactory" words="lang/stopwords_fi.txt" format="snowball" ignoreCase="true"/>
        <filter class="solr.SnowballPorterFilterFactory" language="Finnish"/>
      </analyzer>
    </fieldType>
    <fieldType name="text_fr" class="solr.TextField" positionIncrementGap="100">
      <analyzer>
        <tokenizer class="solr.StandardTokenizerFactory"/>
        <filter class="solr.ElisionFilterFactory" articles="lang/contractions_fr.txt" ignoreCase="true"/>
        <filter class="solr.LowerCaseFilterFactory"/>
        <filter class="solr.StopFilterFactory" words="lang/stopwords_fr.txt" format="snowball" ignoreCase="true"/>
        <filter class="solr.FrenchLightStemFilterFactory"/>
      </analyzer>
    </fieldType>
    <fieldType name="text_ga" class="solr.TextField" positionIncrementGap="100">
      <analyzer>
        <tokenizer class="solr.StandardTokenizerFactory"/>
        <filter class="solr.ElisionFilterFactory" articles="lang/contractions_ga.txt" ignoreCase="true"/>
        <filter class="solr.StopFilterFactory" words="lang/hyphenations_ga.txt" ignoreCase="true"/>
        <filter class="solr.IrishLowerCaseFilterFactory"/>
        <filter class="solr.StopFilterFactory" words="lang/stopwords_ga.txt" ignoreCase="true"/>
        <filter class="solr.SnowballPorterFilterFactory" language="Irish"/>
      </analyzer>
    </fieldType>
    <fieldType name="text_general" class="solr.TextField" positionIncrementGap="100">
      <analyzer type="index">
        <tokenizer class="solr.StandardTokenizerFactory"/>
        <filter class="solr.SynonymFilterFactory" expand="true" synonyms="synonyms.txt" ignoreCase="true"/>
        <filter class="solr.StopFilterFactory" words="stopwords.txt" ignoreCase="true"/>
        <filter class="solr.LowerCaseFilterFactory"/>
      </analyzer>
      <analyzer type="query">
        <tokenizer class="solr.StandardTokenizerFactory"/>
        <filter class="solr.StopFilterFactory" words="stopwords.txt" ignoreCase="true"/>
        <filter class="solr.SynonymFilterFactory" expand="true" synonyms="synonyms.txt" ignoreCase="true"/>
        <filter class="solr.LowerCaseFilterFactory"/>
      </analyzer>
    </fieldType>
    <fieldType name="text_general_rev" class="solr.TextField" positionIncrementGap="100">
      <analyzer type="index">
        <tokenizer class="solr.StandardTokenizerFactory"/>
        <filter class="solr.StopFilterFactory" words="stopwords.txt" ignoreCase="true"/>
        <filter class="solr.LowerCaseFilterFactory"/>
        <filter class="solr.ReversedWildcardFilterFactory" maxFractionAsterisk="0.33" withOriginal="true" maxPosQuestion="2" maxPosAsterisk="3"/>
      </analyzer>
      <analyzer type="query">
        <tokenizer class="solr.StandardTokenizerFactory"/>
        <filter class="solr.SynonymFilterFactory" expand="true" synonyms="synonyms.txt" ignoreCase="true"/>
        <filter class="solr.StopFilterFactory" words="stopwords.txt" ignoreCase="true"/>
        <filter class="solr.LowerCaseFilterFactory"/>
      </analyzer>
    </fieldType>
    <fieldType name="text_gl" class="solr.TextField" positionIncrementGap="100">
      <analyzer>
        <tokenizer class="solr.StandardTokenizerFactory"/>
        <filter class="solr.LowerCaseFilterFactory"/>
        <filter class="solr.StopFilterFactory" words="lang/stopwords_gl.txt" ignoreCase="true"/>
        <filter class="solr.GalicianStemFilterFactory"/>
      </analyzer>
    </fieldType>
    <fieldType name="text_hi" class="solr.TextField" positionIncrementGap="100">
      <analyzer>
        <tokenizer class="solr.StandardTokenizerFactory"/>
        <filter class="solr.LowerCaseFilterFactory"/>
        <filter class="solr.IndicNormalizationFilterFactory"/>
        <filter class="solr.HindiNormalizationFilterFactory"/>
        <filter class="solr.StopFilterFactory" words="lang/stopwords_hi.txt" ignoreCase="true"/>
        <filter class="solr.HindiStemFilterFactory"/>
      </analyzer>
    </fieldType>
    <fieldType name="text_hu" class="solr.TextField" positionIncrementGap="100">
      <analyzer>
        <tokenizer class="solr.StandardTokenizerFactory"/>
        <filter class="solr.LowerCaseFilterFactory"/>
        <filter class="solr.StopFilterFactory" words="lang/stopwords_hu.txt" format="snowball" ignoreCase="true"/>
        <filter class="solr.SnowballPorterFilterFactory" language="Hungarian"/>
      </analyzer>
    </fieldType>
    <fieldType name="text_hy" class="solr.TextField" positionIncrementGap="100">
      <analyzer>
        <tokenizer class="solr.StandardTokenizerFactory"/>
        <filter class="solr.LowerCaseFilterFactory"/>
        <filter class="solr.StopFilterFactory" words="lang/stopwords_hy.txt" ignoreCase="true"/>
        <filter class="solr.SnowballPorterFilterFactory" language="Armenian"/>
      </analyzer>
    </fieldType>
    <fieldType name="text_id" class="solr.TextField" positionIncrementGap="100">
      <analyzer>
        <tokenizer class="solr.StandardTokenizerFactory"/>
        <filter class="solr.LowerCaseFilterFactory"/>
        <filter class="solr.StopFilterFactory" words="lang/stopwords_id.txt" ignoreCase="true"/>
        <filter class="solr.IndonesianStemFilterFactory" stemDerivational="true"/>
      </analyzer>
    </fieldType>
    <fieldType name="text_it" class="solr.TextField" positionIncrementGap="100">
      <analyzer>
        <tokenizer class="solr.StandardTokenizerFactory"/>
        <filter class="solr.ElisionFilterFactory" articles="lang/contractions_it.txt" ignoreCase="true"/>
        <filter class="solr.LowerCaseFilterFactory"/>
        <filter class="solr.StopFilterFactory" words="lang/stopwords_it.txt" format="snowball" ignoreCase="true"/>
        <filter class="solr.ItalianLightStemFilterFactory"/>
      </analyzer>
    </fieldType>
    <fieldType name="text_ja" class="solr.TextField" positionIncrementGap="100" autoGeneratePhraseQueries="false">
      <analyzer>
        <tokenizer class="solr.JapaneseTokenizerFactory" mode="search"/>
        <filter class="solr.JapaneseBaseFormFilterFactory"/>
        <filter class="solr.JapanesePartOfSpeechStopFilterFactory" tags="lang/stoptags_ja.txt"/>
        <filter class="solr.CJKWidthFilterFactory"/>
        <filter class="solr.StopFilterFactory" words="lang/stopwords_ja.txt" ignoreCase="true"/>
        <filter class="solr.JapaneseKatakanaStemFilterFactory" minimumLength="4"/>
        <filter class="solr.LowerCaseFilterFactory"/>
      </analyzer>
    </fieldType>
    <fieldType name="text_lv" class="solr.TextField" positionIncrementGap="100">
      <analyzer>
        <tokenizer class="solr.StandardTokenizerFactory"/>
        <filter class="solr.LowerCaseFilterFactory"/>
        <filter class="solr.StopFilterFactory" words="lang/stopwords_lv.txt" ignoreCase="true"/>
        <filter class="solr.LatvianStemFilterFactory"/>
      </analyzer>
    </fieldType>
    <fieldType name="text_nl" class="solr.TextField" positionIncrementGap="100">
      <analyzer>
        <tokenizer class="solr.StandardTokenizerFactory"/>
        <filter class="solr.LowerCaseFilterFactory"/>
        <filter class="solr.StopFilterFactory" words="lang/stopwords_nl.txt" format="snowball" ignoreCase="true"/>
        <filter class="solr.StemmerOverrideFilterFactory" dictionary="lang/stemdict_nl.txt" ignoreCase="false"/>
        <filter class="solr.SnowballPorterFilterFactory" language="Dutch"/>
      </analyzer>
    </fieldType>
    <fieldType name="text_no" class="solr.TextField" positionIncrementGap="100">
      <analyzer>
        <tokenizer class="solr.StandardTokenizerFactory"/>
        <filter class="solr.LowerCaseFilterFactory"/>
        <filter class="solr.StopFilterFactory" words="lang/stopwords_no.txt" format="snowball" ignoreCase="true"/>
        <filter class="solr.SnowballPorterFilterFactory" language="Norwegian"/>
      </analyzer>
    </fieldType>
    <fieldType name="text_pt" class="solr.TextField" positionIncrementGap="100">
      <analyzer>
        <tokenizer class="solr.StandardTokenizerFactory"/>
        <filter class="solr.LowerCaseFilterFactory"/>
        <filter class="solr.StopFilterFactory" words="lang/stopwords_pt.txt" format="snowball" ignoreCase="true"/>
        <filter class="solr.PortugueseLightStemFilterFactory"/>
      </analyzer>
    </fieldType>
    <fieldType name="text_ro" class="solr.TextField" positionIncrementGap="100">
      <analyzer>
        <tokenizer class="solr.StandardTokenizerFactory"/>
        <filter class="solr.LowerCaseFilterFactory"/>
        <filter class="solr.StopFilterFactory" words="lang/stopwords_ro.txt" ignoreCase="true"/>
        <filter class="solr.SnowballPorterFilterFactory" language="Romanian"/>
      </analyzer>
    </fieldType>
    <fieldType name="text_ru" class="solr.TextField" positionIncrementGap="100">
      <analyzer>
        <tokenizer class="solr.StandardTokenizerFactory"/>
        <filter class="solr.LowerCaseFilterFactory"/>
        <filter class="solr.StopFilterFactory" words="lang/stopwords_ru.txt" format="snowball" ignoreCase="true"/>
        <filter class="solr.SnowballPorterFilterFactory" language="Russian"/>
      </analyzer>
    </fieldType>
    <fieldType name="text_sv" class="solr.TextField" positionIncrementGap="100">
      <analyzer>
        <tokenizer class="solr.StandardTokenizerFactory"/>
        <filter class="solr.LowerCaseFilterFactory"/>
        <filter class="solr.StopFilterFactory" words="lang/stopwords_sv.txt" format="snowball" ignoreCase="true"/>
        <filter class="solr.SnowballPorterFilterFactory" language="Swedish"/>
      </analyzer>
    </fieldType>
    <fieldType name="text_th" class="solr.TextField" positionIncrementGap="100">
      <analyzer>
        <tokenizer class="solr.StandardTokenizerFactory"/>
        <filter class="solr.LowerCaseFilterFactory"/>
        <filter class="solr.ThaiWordFilterFactory"/>
        <filter class="solr.StopFilterFactory" words="lang/stopwords_th.txt" ignoreCase="true"/>
      </analyzer>
    </fieldType>
    <fieldType name="text_tr" class="solr.TextField" positionIncrementGap="100">
      <analyzer>
        <tokenizer class="solr.StandardTokenizerFactory"/>
        <filter class="solr.TurkishLowerCaseFilterFactory"/>
        <filter class="solr.StopFilterFactory" words="lang/stopwords_tr.txt" ignoreCase="false"/>
        <filter class="solr.SnowballPorterFilterFactory" language="Turkish"/>
      </analyzer>
    </fieldType>
    <fieldType name="text_ws" class="solr.TextField" positionIncrementGap="100">
      <analyzer>
        <tokenizer class="solr.WhitespaceTokenizerFactory"/>
      </analyzer>
    </fieldType>
       <fieldType name="text_syw_del1" class="solr.TextField" positionIncrementGap="5">
       <analyzer type="index">
                       <!-- delimter is either " || " or "~" -->
       <tokenizer class="solr.PatternTokenizerFactory" pattern="\s\|\|\s|~" group="-1"/>
       <filter class="solr.LowerCaseFilterFactory"/>
       </analyzer>
       <analyzer type="query">
       <tokenizer class="solr.KeywordTokenizerFactory"/>
       <filter class="solr.LowerCaseFilterFactory"/>
       </analyzer>
       </fieldType>

    <fieldType name="tfloat" class="solr.TrieFloatField" precisionStep="8" positionIncrementGap="0"/>
    <fieldType name="tint" class="solr.TrieIntField" precisionStep="8" positionIncrementGap="0"/>
    <fieldType name="tlong" class="solr.TrieLongField" precisionStep="8" positionIncrementGap="0"/>
  </types>
  <fields>
        <field name="Key" type="string" indexed="true" stored="true" multiValued="false" required="true"/>
        <field name="Source" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="true"/>
        <field name="LoyaltyCardNumber" type="string" indexed="true" stored="true" multiValued="false" required="true"/>
        <field name="ProfileLastUpdateDate" type="date" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="SearchLastUpdateDate" type="date" indexed="true" stored="true" multiValued="false" default="NOW"/>
        <field name="Birthday" type="date" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="Gender" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="Ethnicity" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="AboutMe" type="text_general" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="Language" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="LanguageFluency" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="ElementrySchoolName" type="string_low_trim" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="ElementrySchoolCity" type="string_low_trim" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="ElementrySchoolState" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="ElementrySchoolCountry" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="ElementrySchoolFromDate" type="date" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="ElementrySchoolToDate" type="date" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="MiddleSchoolName" type="string_low_trim" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="MiddleSchoolCity" type="string_low_trim" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="MiddleSchoolState" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="MiddleSchoolCountry" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="MiddleSchoolFromDate" type="date" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="MiddleSchoolToDate" type="date" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="HighSchoolName" type="string_low_trim" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="HighSchoolCity" type="string_low_trim" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="HighSchoolState" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="HighSchoolCountry" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="HighSchoolFromDate" type="date" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="HighSchoolToDate" type="date" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="UndergraduateMajor" type="string_low_trim" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="UndergraduateName" type="string_low_trim" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="UndergraduateCity" type="string_low_trim" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="UndergraduateState" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="UndergraduateCountry" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="UndergraduateFromDate" type="date" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="UndergraduateToDate" type="date" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="GraduateMajor" type="string_low_trim" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="GraduateName" type="string_low_trim" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="GraduateCity" type="string_low_trim" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="GraduateState" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="GraduateCountry" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="GraduateFromDate" type="date" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="GraduateToDate" type="date" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="PostGraduateMajor" type="string_low_trim" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="PostGraduateName" type="string_low_trim" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="PostGraduateCity" type="string_low_trim" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="PostGraduateState" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="PostGraduateCountry" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="PostGraduateFromDate" type="date" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="PostGraduateToDate" type="date" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="AreyouSelfEmployed" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="EmploymentPosition" type="string_low_trim_employment" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="EmploymentCompany" type="string_low_trim_employment" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="EmploymentCity" type="string_low_trim" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="EmploymentState" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="EmploymentCountry" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="EmploymentFromDate" type="date" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="EmploymentToDate" type="date" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="EmploymentIndustry" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="ProfessionalSkills" type="string_low_trim_employment" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="Preferecofriendlyproducts" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="Preferlocallymanufacturedproducts" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="GeneralNutritionalPreferences" type="string_low_trim" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="CookingExpertise" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="AlcoholDrinkingHabits" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="FavoriteRestaurants" type="string_low_trim" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="HostGuestsFrequency" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="FavoriteDishes" type="string_low_trim" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="CookingFor" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="CookingReason" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="FavoriteMusicArtists" type="string_low_trim" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="FavoriteMusicStyles" type="string_low_trim" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="FavoriteMusicStores" type="string_low_trim" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="OnlineMusicServices" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="FavoriteMovies" type="string_low_trim" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="FavoriteGenres" type="string_low_trim" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="CinemaVisitFrequency" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="MovieRentingFrequency" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="MagazineSubscriptions" type="string_low_trim" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="NumberOfBooksReadAnnualy" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="FavoriteAuthors" type="string_low_trim" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="FavoriteBooks" type="string_low_trim" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="TravelFrequency" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="VacationFrequency" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="PreferableVacationMonths" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="PreferableVacationDestination" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="PreferableVacationType" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="PetType" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="PetBreed" type="string_low_trim" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="PetWeight" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="PetBirthday" type="date" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="ElectricityCompany" type="string_low_trim" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="GasCompany" type="string_low_trim" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="InternetServiceProvider" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="MobileNetworkProvider" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="PrimaryGroceryStore" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="PrimaryDrugStore" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="TelephoneCompany" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="WasteManagementCompany" type="string_low_trim" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="WaterCompany" type="string_low_trim" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="MembershipAirlineClub" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="MembershipRentalCarClub" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="MembershipAARP" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="Religion" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="PoliticalParty" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="CharityName" type="string_low_trim" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="CharityKeyContact" type="string_low_trim" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="CharityTimeOfYear" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="TypeOfHome" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="NumberofBedrooms" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="NumberofBathrooms" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="MattressesSize" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="HomeSizeSquareFeet" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="PrimaryBuildingMaterial" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="HomeOwnershipType" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="TimeOfResidence" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="Typeofyard" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="YardSquareFootage" type="string_low_trim" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="YardGarage" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="YardShed" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="YardTrees" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="TVProvider" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="TVSubscriptionPackages" type="string_low_trim" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="FavoriteTVChannels" type="string_low_trim" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="FavoriteTVShows" type="string_low_trim" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="NetflixSubscription" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="OwnAppleTV" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="CarMake" type="string_low_trim" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="CarModel" type="string_low_trim" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="CarYear" type="int" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="CarWarrantyExpiration" type="date" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="CarLastMaintenanceDate" type="date" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="CarMilege" type="string_low_trim" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="MotorbikeMake" type="string_low_trim" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="MotorbikeModel" type="string_low_trim" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="MotorbikeYear" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="MotorbikeWarrantyExpiration" type="date" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="MotorbikeLastMaintenanceDate" type="date" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="MotorbikeMilege" type="string_low_trim" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="Height" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="Weight" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="BodyShape" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="TShirtSize" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="ShoeSize" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="Bust" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="Waist" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="Hip" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="FavoriteClothingStyle" type="string_low_trim" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="FavoriteShirtColors" type="string_low_trim" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="FavoritePantsColor" type="string_low_trim" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="FavoriteShoeColors" type="string_low_trim" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="FavoriteHatStyles" type="string_low_trim" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="WorkDressCode" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="FavoriteApprelBrands" type="string_low_trim" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="ArtsCrafts" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="CollectionHobbies" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="Games" type="string_low_trim" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="MartialArts" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="OutdoorActivities" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="PerformingArts" type="string_low_trim" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="ScienceElectronics" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="IndividualSports" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="RacketSports" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="TeamSports" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="WaterSports" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="WheeledSports" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="WinterSports" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="Other" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="IndoorHobbies" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="IndoorCompetitiveHobbies" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="OutdoorHobbies" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="ObservationHobbies" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="OutdoorCompetitiveHobbies" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="RelationshipStatus" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="SpouseGender" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="SpouseBirthDate" type="date" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="SpouseAnniversary" type="date" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="ChildGender" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="ChildBirthDate" type="date" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="ChildAnniversary" type="date" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="ExpectingBaby" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="ExpectedBabyGender" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="ExpectedBabyDueDate" type="date" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="FatherBirthday" type="date" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="MotherBirthday" type="date" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="ParentsAnniversary" type="date" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="SiblingsGender" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="SiblingAnniversary" type="date" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="SiblingBirthDay" type="date" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="DoYouWearCorrectiveLenses" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="CorrectiveLensesLeftEyePrescription" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="CorrectiveLensesRightEyePrescription" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="DoYouExerciseAtGym" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="GymClub" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="MonthlyCostOfGym" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="HealthIssues" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="ExerciseFrequency" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="TryingToLoseWeight" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="UseSupplementsOrVitamins" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="SmokingHabits" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="WearableComputingGadgets" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="HomeAddressCity" type="string_low_trim" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="HomeAddressStateCode" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="HomeAddressStateName" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="HomeAddressCityStateCode" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="HomeAddressCountry" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="HomeAddressZIPCode" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="WorkAddressCity" type="string_low_trim" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="WorkAddressStateName" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="WorkAddressStateCode" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="WorkAddressCountry" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="WorkAddressZIPCode" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="ParentsAddressCity" type="string_low_trim" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="ParentsAddressState" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="ParentsAddressCountry" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="ParentsAddressZIPCode" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="HomePhoneNumber" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="CellPhoneNumber" type="string_low_trim" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="WorkPhoneNumber" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="BankName" type="string_low_trim" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="BankCity" type="string_low_trim" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="BankState" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="BankCountry" type="string_low_trim" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="BankZipCode" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="PrimaryCreditCard" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="CreditCardsInUse" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="AverageCarMileagePeryear" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="PreferredBeautyProducts" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="BeautyProductsRange" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="BeautyServicesFrequency" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="CarUsage" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="ChildRoom" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="ChildrenExtraCurricularActivities" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="ChildrenSportsRelatedActivities" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="DecorUpdateFrequency" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="ExerciseReasons" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="FurnitureStyleTheme" type="string_low_trim" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="GarageType" type="string_low_trim" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="PreferredHomeFurnishingShop" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="HomeMaintenance" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="ResidenceDuration" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="ThingsToLookInaNewCar" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="NumberOfTVsInHome" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="OtherRoomsType" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="OwnGoogleGlass" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="BalconyPatioSize" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="PersonalBeautyActivities" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="PreferredYardActivities" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="PreferredWeatherForOutdoorActivities" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="PreferredSmartPhoneType" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="ChildrenSchoolUniform" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="PreferredSmartPhoneFeatures" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="InterestedInSportingGoodsProducts" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="ActivitiesToStayInShape" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="VehicleCare" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="VehicleRelatedActivities" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="SocialMediaProfiles" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="EmailDomain" type="string_low_trim" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="TripperBucket" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="OnlineActvInd" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="RedeemerInd" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="SrsCCUserInd" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="SywMaxInd" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="SywrVIPInd" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="EmailInd" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="SpendBucket" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="BirthdayMonth" type="int" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="BirthdayYear" type="int" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="CollegeSchoolNames" type="text_general" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="CollegeToDates" type="date" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="CollegeFromDates" type="date" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="EventBirthdayDates" type="date" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="EventAnniversaryDates" type="date" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="EventAnniversaryMonth" type="int" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="ActiveMembership" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="AssociateInd" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="PhoneOptinInd" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="CraftsmanClubInd" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="MembershipKidAdvantageInd" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="EnrollDate" type="date" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="Enrollsource" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="EnrollLocation" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="HouseholdIncome" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="Occupation" type="string_low_trim" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="HomeValue" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="HomeAddressMoveinDate" type="date" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="HomeConstructionYear" type="int" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="HomeAddressLatitudeDegrees" type="double" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="HomeAddressLongitudeDegrees" type="double" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="HomeAddressLatitudeRadians" type="double" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="HomeAddressLongitudeRadians" type="double" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="ResidentsinHousehold" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="HobbiesGeneral" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="SportsParticipantHobbies" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="SportsSpectatorHobbies" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="GadgetsElectronicsHobbies" type="string_low_trim" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="HealthnWellnessHobbies" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="FamilyHobbies" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="VehicleCount" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="TruckOwnerInd" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="MotorcycleOwnerInd" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="RecreationalVehicleownerInd" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="OwnsComputerInd" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="InternetServiceInd" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="PersonalComputerOperatingSystem" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="CollegeGraduateInd" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="EmptyNesterInd" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="EnteringAdulthoodInd" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="VehicleIntendtoPurchaseInd" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="NewlywedInd" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="RecentDivorceInd" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="ChildNearHighSchoolGraduationinHHInd" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="RecentHomeBuyerInd" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="RecentMortgageBorrowerInd" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="NewMoverInd" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="NewParentInd" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="HomeEquityAvailableRangeCode" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="SquareFootage" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="MobilePhoneDeviceInd" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="CreditCards" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="CharitableGivings" type="string_low_trim" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="Veteran" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="HomeExteriorCode" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="HomeHeatSourceCode" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="HomeRoofTypeCode" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="HomeRoomQuantity" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="SwimmingPoolInd" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="AnimalRelatedHobbies" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="AllHobbies" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="VAPP" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="SYWSegments" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="EducationLevel" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="HasChildren" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="MemberAge" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="HomeAddress" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="HomePurchasePrice" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="MortgagePayments" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="MonthlyRent" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="YearlyIncome" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="InteractionType7Day" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="InteractionDetail7Day" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="InteractionType12Month" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="InteractionDetail12Month" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="ShoppedSearsBU12Month" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="ShoppedKmartBU12Month" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="ShoppedSHCBU12Month" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="ShoppedSearsKV12Month" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="ShoppedKmartKV12Month" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="ShoppedSearsBUDiv12Month" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="ShoppedKmartBUDiv12Month" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="ShoppedSearsBUDivLine12Month" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="ShoppedKmartBUDivLine12Month" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="LastTransactionDate" type="date" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="PetOwnerInd" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="SYWProfileInd" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="Birthday_SYW" type="date" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="Gender_SYW" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="Ethnicity_SYW" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="Language_SYW" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="PetType_SYW" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="PoliticalParty_SYW" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="TypeOfHome_SYW" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="HomeSizeSquareFeet_SYW" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="HomeOwnershipType_SYW" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="RelationshipStatus_SYW" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="ResidenceDuration_SYW" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="SocialMediaProfiles_SYW" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="BirthdayMonth_SYW" type="int" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="BirthdayYear_SYW" type="int" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="AllHobbies_SYW" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="EducationLevel_SYW" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="HasChildren_SYW" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="MemberAge_SYW" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="HomeAddress_SYW" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="PetOwnerInd_SYW" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="PrimaryStoreSears" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="PrimaryStoreKmart" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="TotalSalesSears" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalTripsSears" type="int" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="PrimaryStoreTopMemberSearsInd" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="TotalSalesKmart" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="TotalTripsKmart" type="int" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="PrimaryStoreTopMemberKmartInd" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="ExpectingBaby_SYW" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="ActiveMember" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="TotalSalesSHC" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="BirthdayDayOfMonth" type="int" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="BirthdayDayOfMonth_SYW" type="int" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="WebTraitsSiteTypeVerticals7Day" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="ShoppedSearsBUDivLineItem12Month" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="ShoppedKmartBUDivLineItem12Month" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="ShoppedStore12Month" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="MSMScorePercentBucket" type="string_low_controlled" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="PrimaryShoppingMonth" type="int" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="ShoppedHolidayWeek" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="ShoppedOnlineInstore" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="TotalTripsSHC" type="int" indexed="true" stored="true" multiValued="false" required="false"/>
        <field name="ShoppedSearsKVSubNm12Month" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="ShoppedKmartKVSubNm12Month" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="ShoppedSearsKVSubNmItem12Month" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="ShoppedKmartKVSubNmItem12Month" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="BirthdayMonthDay" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
        <field name="BirthdayMonthDay_SYW" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>         
        <field name="FieldSource" type="string_low_controlled" indexed="true" stored="true" multiValued="true" required="false"/>
	<field name="TotalSalesSears_101_apparelaccessories" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesSears_102_apparelchildrens" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesSears_103_apparelintimates" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesSears_104_apparelmens" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesSears_105_apparelwomens" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesSears_106_appliances" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesSears_107_automotive" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesSears_108_drug" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesSears_109_electronics" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesSears_110_food" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesSears_111_footwear" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesSears_112_giftcard" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesSears_113_homegoodsfashion" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesSears_114_homebigtickets" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesSears_115_homeserviceprotection" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesSears_116_jewelry" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesSears_117_landsend" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesSears_118_licensedbusiness" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesSears_119_other" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesSears_120_outdoorliving" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesSears_122_lawngarden" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesSears_123_seasonal" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesSears_124_sportinggoods" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesSears_125_toolspaint" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesSears_126_toys" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesKmart_201_apparelaccessories" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesKmart_202_apparelchildrens" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesKmart_203_apparelintimates" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesKmart_204_apparelmens" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesKmart_205_apparelwomens" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesKmart_206_appliances" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesKmart_207_automotive" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesKmart_208_drug" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesKmart_209_electronics" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesKmart_210_food" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesKmart_211_footwear" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesKmart_213_home" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesKmart_216_jewelry" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesKmart_219_other" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesKmart_220_outdoorliving" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesKmart_221_pharmacy" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesKmart_222_lawngarden" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesKmart_223_seasonal" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesKmart_224_sportinggoods" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesKmart_225_toolspaint" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesKmart_226_toys" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesKmart_227_sywbrands" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesSHC_unknown" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesSHC_900_shcappareltotal" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesSHC_901_shcapparelaccessories" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesSHC_902_shcapparelchildrens" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesSHC_903_shcapparelintimates" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesSHC_904_shcapparelmens" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesSHC_905_shcapparelwomens" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesSHC_906_shcappliances" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesSHC_907_shcautomotive" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesSHC_908_shcdrug" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesSHC_909_shcelectronics" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesSHC_910_shcfood" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesSHC_911_shcfootwear" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesSHC_913_shchome" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesSHC_914_shchomebigtickets" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesSHC_915_shchomeserviceprotection" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesSHC_916_shcjewelry" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesSHC_917_shclandsend" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesSHC_918_shclicensedbusiness" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesSHC_919_shcother" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesSHC_920_shcoutdoorliving" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesSHC_921_shcpharmacy" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesSHC_922_shclawngarden" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesSHC_923_shcseasonal" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesSHC_924_shcsportinggoods" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesSHC_925_shctoolspaint" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesSHC_926_shctoys" type="float" indexed="true" stored="true" multiValued="false" required="false"/>
	<field name="TotalSalesSHC_927_shcsywbrands" type="float" indexed="true" stored="true" multiValued="false" required="false"/>


	<!--DERIVED FIELDS-->
	<field name="_version_" type="long" indexed="true" stored="true"/>
	<field name="AllFields" type="text_general"  indexed="true"  stored="false"  multiValued="true" required="false"/>
	<field name="EventBirthdateDates" type="date"  indexed="true"  stored="true"  multiValued="true"/>
	<field name="WebTraitsSiteTypeVerticals7Day_s" type="text_syw_del1"  indexed="true"  stored="false"  multiValued="true" required="false"/>
	<field name="ShoppedStore12Month_s" type="text_syw_del1"  indexed="true"  stored="false"  multiValued="true" required="false"/>
	<field name="MSMScorePercentBucket_s" type="text_syw_del1"  indexed="true"  stored="false"  multiValued="true" required="false"/>
	<field name="ShoppedHolidayWeek_s" type="text_syw_del1"  indexed="true"  stored="false"  multiValued="true" required="false"/>
	
	</fields>
	 
	<!-- COPY FIELDS -->

	 <copyField source="*" dest="AllFields"/>
         <copyField source="UndergraduateName" dest="CollegeSchoolNames"/>
         <copyField source="GraduateName" dest="CollegeSchoolNames"/>
         <copyField source="PostGraduateName" dest="CollegeSchoolNames"/>
         <copyField source="UndergraduateFromDate" dest="CollegeFromDates"/>
         <copyField source="GraduateFromDate" dest="CollegeFromDates"/>
         <copyField source="PostGraduateFromDate" dest="CollegeFromDates"/>
         <copyField source="Birthday" dest="EventBirthdayDates"/>
         <copyField source="SpouseBirthDate" dest="EventBirthdayDates"/>
         <copyField source="FatherBirthday" dest="EventBirthdayDates"/>
         <copyField source="MotherBirthday" dest="EventBirthdayDates"/>
         <copyField source="SiblingBirthDay" dest="EventBirthdayDates"/>
         <copyField source="ChildBirthDate" dest="EventBirthdayDates"/>
	<copyField source="UndergraduateToDate" dest="CollegeToDates"/>
	<copyField source="GraduateToDate" dest="CollegeToDates"/>
	<copyField source="PostGraduateToDate" dest="CollegeToDates"/>

	<copyField source="WebTraitsSiteTypeVerticals7Day" dest="WebTraitsSiteTypeVerticals7Day_s"/>
	<copyField source="ShoppedStore12Month" dest="ShoppedStore12Month_s"/>
	<copyField source="MSMScorePercentBucket" dest="MSMScorePercentBucket_s"/>
	<copyField source="ShoppedHolidayWeek" dest="ShoppedHolidayWeek_s"/>

	
	<!-- field for the QueryParser to use when an explicit fieldname is absent -->
	<defaultSearchField>AllFields</defaultSearchField>

</schema>
