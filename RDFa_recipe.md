# Recipe for describing public contracts in RDFa #

**Authors:**

  * [Jakub Klímek](http://purl.org/klimek#me)
  * [Tomáš Knap](http://purl.org/knap#me)
  * [Jindřich Mynarz](http://keg.vse.cz/resource/person/jindrich-mynarz)
  * [Martin Nečaský](http://www.ksi.mff.cuni.cz/~necasky)
  * [Josef Petrák](http://keg.vse.cz/resource/person/josef-petrak)

The aim of this document is to showcase how one can publish data about public contracts in a machine-readable form using the [Public Contracts Ontology](http://code.google.com/p/public-contracts-ontology/). The way of describing public contracts, documented in this text, is based on a typical HTML web page onto which machine-readable annotations are added. The web page is enriched with annotations in [RDFa](http://www.w3.org/TR/xhtml-rdfa-primer/), which enable to embed fully-fledged RDF into an HTML document. Adding RDFa does not influence the appearance of a page for human user, however, it weaves structured data into the page so that machines may use it.

The Public Contracts Ontology is an RDF vocabulary for describing public contracts on the Web. Due to differences among different countries the ontology is divided into separate parts. The [core part](http://public-contracts-ontology.googlecode.com/hg/public-contracts.ttl) contains the common features that are applicable in most legal systems. Then, there are _modules_ extending the core that contain country-specific features. Currently, there is only the [module for Czech Republic](http://public-contracts-ontology.googlecode.com/hg/public-contracts-czech.ttl).

The following is a step-by-step introduction of the core features and explanation of the technical aspects of the Public Contracts Ontology. It shows the typical uses of the ontology in examples that serve as templates that may be copied, customized, and pasted into your own web page.

## Syntax check ##

If you start creating an RDFa description of a public contract, you may use the syntax validators, such as [RDFa Distiller and Parser](http://www.w3.org/2007/08/pyRdfa/Shadow.html), to check if you have produced correct RDFa.

## Basic structure of a document describing public contract ##

In case you are using XHTML you need to modify the preamble and the root <tt>html</tt> element of your document to declare that you are using RDFa:

```html

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML+RDFa 1.1//EN" "http://www.w3.org/MarkUp/DTD/xhtml-rdfa-2.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en" version="XHTML+RDFa 1.1">
...


Unknown end tag for &lt;/html&gt;


```

In case of HTML (up to version 4) you need to provide similar declaration:

```html

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01+RDFa 1.1//EN"
"http://www.w3.org/MarkUp/DTD/html401-rdfa11-1.dtd">
<html lang="en">
...


Unknown end tag for &lt;/html&gt;


```

In case of HTML 5, you may omit the special declaration for RDFa and use the simple DOCTYPE:

```html
<!DOCTYPE html>```

## Namespaces ##

Add namespace declarations to the root <tt>html</tt> element using the <tt>prefix</tt> attribute (compatible with RDFa 1.1):

```html

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="cs" lang="cs" version="XHTML+RDFa 1.1"
prefix="rdf: http://www.w3.org/1999/02/22-rdf-syntax-ns#

rdfs: http://www.w3.org/2000/01/rdf-schema#

gr: http://purl.org/goodrelations/v1#

dcterms: http://purl.org/dc/terms/

pc: http://purl.org/procurement/public-contracts#

pccz: http://purl.org/procurement/public-contracts-czech#

cpv: http://purl.org/weso/pscs/cpv/2008/resource/

v: http://www.w3.org/2006/vcard/ns#

payment: http://reference.data.gov.uk/def/payment#

br: http://purl.org/business-register#

xsd: http://www.w3.org/2001/XMLSchema#

pcdt: http://purl.org/procurement/public-contracts-datatypes#">
...


Unknown end tag for &lt;/html&gt;


```

If you want to maintain compatibility with older RDFa 1.0 version, you need to use the XML namespaces with the <tt>xmlns</tt> attribute:

```html

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="cs" lang="cs" version="XHTML+RDFa 1.1"
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
xmlns:gr="http://purl.org/goodrelations/v1#"
xmlns:dc="http://purl.org/dc/terms/"
xmlns:pc="http://purl.org/procurement#"
xmlns:pccz="http://purl.org/procurement/czech#"
xmlns:cpv="http://purl.org/procurement/cpv/2008/"
xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
xmlns:pcdt="http://purl.org/procurement/public-contracts-datatypes#">
...


Unknown end tag for &lt;/html&gt;


```

For compatibility with both RDFa version 1.0 and 1.1 you may use redundant declaration in both presented ways.

**_Why do the examples use so many namespaces?_**
_Public Contracts Ontology builds significantly on other well-established and widely used RDF vocabularies and ontologies borrowing properties and classes from them. This ensures interoperability with data described with these vocabularies._






<h2>Specifying where the details about the public contract are</h2>

<p> Information about a public contract is closed in your HTML code into a single element, e.g. <tt>div</tt>, <tt>p</tt>. Then you have to specify that the content of this element relates to the public contract by RDFa <tt>typeof</tt> attribute with the value <tt>pc:Contract</tt>. Doing it that way, you say that the content represents an instance of the class <tt>Contract</tt> with the namespace prefix <tt>pc</tt> (i.e. the namespace of the public contracts ontology). </p>

```
<div typeof="pc:Contract">
  ...
</div>
```

<p> The above says that the public contract is an anonymous instance of the class <tt>Contract</tt>, i.e. it has no identifier. In RDFa it is possible to identify instances optionally via a URI, which allows you to refer to a contract from another location on the Web, where you have placed some more details about the given contract. This URI may be a physical URL, where the HTML page with a public contract is located. But it is important to ensure that the selected identification URI for this public contract will never change. </p>

```
<div about="http://www.mesto.cz/VZ/12345678" typeof="pc:Contract">
  ...
</div>
```

<p> The above says that the public contract is identified with URI <tt><a href='http://www.mesto.cz/VZ/12345678'>http://www.mesto.cz/VZ/12345678</a></tt>.</p>

<h2>Public contract details</h2>

<p>For each public contract, you should introduce its name (label). For public contract labels, we use in the public contracts ontology the RDF property <tt>dcterms:title</tt>. The label should be placed in the separated (X)HTML element, such as <tt>span</tt>. You can then use its RDFa attribute <tt>property</tt> with the value <tt>dcterms:title</tt> to state that the content of that element is the name (label) of the public contract.</p>

```
<div about="http://www.mesto.cz/VZ/12345678" typeof="pc:Contract">
   Label: <span property="dcterms:title">Horse Riding stuff of the municipal police</span>
</div>
```

<h3>Details about the contracting authority (public contract ordering party) </h3>

<p>Add information about the contracting authority by using the property <tt>pc:contractingAuthority</tt>. A contracting authority should be introduced as an anonymous instance of the class <tt>gr:BusinessEntity</tt>, i.e., in a separate element with RDFa attribute <tt>typeof</tt> with the value <tt>gr:BusinessEntity</tt>.</p>

```
<div about="http://www.mesto.cz/VZ/12345678" typeof="pc:Contract">
  ...
  <span rel="pc:contractingAuthority" typeof="gr:BusinessEntity">
  Contracting authority:
      ...                 	
  </span>
</div>
```

<p>Add contracting authority's name (the property <tt>gr:legalName</tt>), identification number (the property <tt>br:officialNumber</tt>) and a link to the authority's profile/general web site (using the property <tt>pc:buyerProfile</tt>). To specify the <tt>pc:buyerProfile</tt>, you should use RDFa attribute <tt>rel</tt>, because the value of that property is not a simple value (literal), but resource, with the URI specified within the attribute <tt>href</tt>. Since the identification number of the contracting authority is represented as a string, it is necessary to explicitly introduce that it is a literal in any particular language by using a language attribute <tt>lang</tt> with an empty value.</p>

```
<div about="http://www.mesto.cz/VZ/12345678" typeof="pc:Contract">
  ...
  <span rel="pc:contractingAuthority" typeof="gr:BusinessEntity">
  Contracting authority:
      ...                 	
      <span property="gr:legalName">City Město</span>,
      IČ <span property="br:officialNumber" lang="">987654321</span>,
      WWW: <a rel="pc:buyerProfile" href="http://www.mesto.cz">Web page of the city</a>
  </span>
</div>
```

<h4>Main contact</h4>

To indicate the main contact for this contract we use vocabulary [VCard](http://www.w3.org/Submission/vcard-rdf/). So you create an anonymous instance of the class<tt>v:VCard</tt> which will represent the "business card" of the contracting authority and assign it to the contract using the attribute <tt>rel</tt> with the value <tt>pc:contact</tt>. Business card has, for example, properties <tt>v:fn</tt> for a contact name, <tt>v:adr</tt> for an address,<tt>v:tel</tt> for the phone number and <tt>v:email</tt> for the email address of the contracting authority. For the address and telephone number we need to create additional anonymous instances of the classes <tt>v:Address</tt> and <tt>v:Tel</tt>. Please note the machine-readable representation of telephone numbers by using the the URI scheme <tt>tel:+420123456789</tt>. This representation of a phone number requires usage of FOAF ontology.

```
<div about="http://www.mesto.cz/VZ/12345678" typeof="pc:Contract">
  ...
  <div rel="pc:contact" typeof="v:VCard">
     <span property="v:fn">Jan Novák</span>
     <div rel="v:adr" typeof="v:Address">
        <span property="v:street-address">Václavské Náměstí 1</span> 
        <br/><span property="v:postal-code">110 00</span> 
        <span property="v:locality">Praha 1</span>
        <br/><span property="v:country-name">Czech Republic</span>
     </div>
     <br/>Phone: 
     <span rel="v:tel" typeof="v:Tel">
      <a rel="rdf:value" href="tel:+420212345678">+420212345678</a>
     </span>
     <br/>Email: <a rel="v:email" href="mailto:novak@priklad.cz">novak@priklad.cz</a>
  </div>
</div>
```

<h3>Procedural data</h3>
<p> The procedural data about the public contract include <tt>pc:referenceNumber</tt>. Since, the reference number is represented as a string, you have to explicitly state that it is not in any specific language using attribute <tt>lang</tt> with an empty value. </p>
```
<div about="http://www.mesto.cz/VZ/12345678" typeof="pc:Contract">
  ...
  Reference number: <span property="pc:referenceNumber" lang="">1234567890</span>
</div>
```

<p> Further, you should fill out detailed text description of the public contract by using the <tt>dcterms:description</tt>. </p>

```
<div about="http://www.mesto.cz/VZ/12345678" typeof="pc:Contract">
   ...
  Description: <span property="dcterms:description">The contract is about...because we really need ... and cannot live without that.</span> 
</div>     
```

<p> To set additional properties, for the sake of clarity we will refer to the shortened URIs of the resources using <a href='http://www.w3.org/TR/curie/'>SafeCURIE</a> - the value of attribute <tt>resource</tt> is enclosed in square brackets. The properties to be set are <tt>pc:kind</tt> and <tt>pc:procedureType</tt> for determining the type of the contract and the type of the contract management. In our example, the type of the contract <tt>pc:Supplies</tt> represents "supply" and the type of management <tt>pc:Open</tt> represents the open procedure. </p>

```
<div about="http://www.mesto.cz/VZ/12345678" typeof="pc:Contract">
  ...
  <br/>Type of contract: <span rel="pc:kind" resource="[pc:Supplies]">Supply</span>
  <br/>Type of contract management: <span rel="pc:procedureType" resource="[pc:Open]">Open</span>
</div>
```


> <tt>pc:kind</tt> can have one of these values:
> > <ul>
<blockquote><li><tt>pc:Supplies</tt> </li>
<li><tt>pc:Works</tt> </li>
<li><tt>pc:Services</tt> </li>
</blockquote><blockquote></ul></blockquote>


> <tt>pc:procedureType</tt> can have one of these values:
> > <ul>
<blockquote><li><tt>pc:Open</tt> </li>
<li><tt>pc:Restricted</tt> </li>
<li><tt>pc:AcceleratedRestricted</tt> </li>
<li><tt>pc:Negotiated</tt> </li>
<li><tt>pc:AcceleratedNegotiated</tt> </li>
<li><tt>pc:CompetitiveDialogue</tt> </li>
</blockquote><blockquote></ul></blockquote>


<p> Furter, you can represent the award criteria using the property <tt>pc:awardCriteriaCombination</tt>. You have two options. Either the value of the property will be <tt>[pc:AwardCriteriaLowestPrice]</tt> for the lowest price as the only criterion, or you create an anonymous instance of the class <tt>pc:AwardCriteriaCombination</tt> as in our example. That particular award criterias are then assigned using the property <tt>pc:awardCriterion</tt> with the value being an anonymous instance of the class <tt>pc:AwardCriterion</tt>. These instances have the property <tt>pc:criterionName</tt> with the name of the particular criterion and the property <tt>pc:criterionWeight</tt> holding the weight of the particular criteria in the range 0 to 100 percentages. You have to specify the data type "percentage" using the attribute <tt>datatype</tt> with the value <tt>pcdt:percentage</tt>. </p>

```
<div about="http://www.mesto.cz/VZ/12345678" typeof="pc:Contract">
  ...
  
  <br/>Award criteria: 
    <span rel="pc:awardCriteriaCombination" typeof="pc:AwardCriteriaCombination">
    The most economically advantageous.
    <br/>Criteria:
    <span rel="pc:awardCriterion" typeof="pc:AwardCriterion">
      <span property="pc:criterionName">The whip lenght</span>
      (Weight: <span property="pc:criterionWeight" datatype="pcdt:percentage">20</span>%)</span>,
    <span rel="pc:awardCriterion" typeof="pc:AwardCriterion">
      <span property="pc:criterionName">Saddle comfort</span>
      (Weight: <span property="pc:criterionWeight" datatype="pcdt:percentage">80</span>%)</span>
    </span>
</div>
```

<p> You can also publish specific information about a public contract particularized by the Czech legislation. We mean a limit of the public contract (using a property <tt>pccz: limit</tt>). This property is not part of the base module, but of the module for the Czech Republic, which we mentioned at the beginning.</p>

```
<div about="http://www.mesto.cz/VZ/12345678" typeof="pc:Contract">
   ...
  Limit: <span rel="pccz:limit" resource="[pccz:UnderLimit]">Under limit</span>
</div>
```

<p>The possible values of the property <tt> pccz: limit </tt>: </p>


> <tt>pccz:limit</tt> can have one of the following values:
> > <ul>
<blockquote><li><tt>pccz:SmallAmount</tt> </li>
<li><tt>pccz:UnderLimit</tt> </li>
<li><tt>pccz:AboveLimit</tt> </li>
</blockquote><blockquote></ul></blockquote>

<h3>Contract object</h3>

<p> Another information about the public contract is the object of the contract in the form of a CPV code. To search for CPV codes you can use a simple <a href='http://opendata.cz/vocabulary/cpv/2008"'>tool</a>. A public contract can have more objects. In our ontology we have RDF ​​properties <tt>pc:mainObject</tt> to hold core objects and <tt>pc:additionalObject</tt> to hold other objects of the contract. CPV codes are identified by its own URI. </p>

```
<div about="http://www.mesto.cz/VZ/12345678" typeof="pc:Contract">
   ...
  <br/>Main object: <span rel="pc:mainObject" resource="[cpv:18911000]">Saddles</span>
  <br/>Additional object: <span rel="pc:additionalObject" resource="[cpv:18913000]">Whips</span>
</div>      
```

<p> The second way how to represent contract objects is by using an ontology <a href='http://www.productontology.org/"'>The Product Types Ontology</a>. Because we have already displayed CPV codes to users, we only add RDFa descriptions visible to machines by using properties <tt>pc:item</tt> and <tt>typeof</tt>. We can further add more details of the items, such as the Czech name of the object by using <tt>rdfs:label</tt>.</p>

```
<div about="http://www.mesto.cz/VZ/12345678" typeof="pc:Contract">
   ...
  <span rel="pc:item" typeof="http://www.productontology.org/id/Saddle">
    <span property="rdfs:label" content="Saddle"/>
  </span>
  <span rel="pc:item" typeof="http://www.productontology.org/id/Whip">
    <span property="rdfs:label" content="Whip"/>
  </span>
</div>
```

<h3>Price</h3>

<p> Further you should fill in details about the contract price. You can choose between two options. Either you introduce the exact estimated price by using the property <tt>pc:estimatedPrice </tt> or you can specify the lower and upper bound for the expected price using the properties <tt>pc:estimatedPriceLower</tt> and <tt>pc:estimatedPriceUpper</tt>. The value of these properties is an anonymous instance of the class <tt>gr:PriceSpecification</tt> and its properties <tt>gr:hasCurrencyValue</tt> specifying the amount, <tt>gr:hasCurrency</tt> specifying the currency, and <tt>gr:valueAdedTaxIncluded</tt> specifying whether the price includes VAT - this value has a data type <tt>xsd:boolean</tt>. Since the currency codes are strings, you must explicitly state that they are not in any specific language using attribute <tt>lang</tt> with an empty value. </p>

```
<div about="http://www.mesto.cz/VZ/12345678" typeof="pc:Contract">
   ...
  <div rel="pc:estimatedPrice" typeof="gr:PriceSpecification">
    Estimated price:
    <span property="gr:hasCurrencyValue" content="1000000.0" datatype="xsd:float">1.000.000</span>
    <span property="gr:hasCurrency" content="CZK" lang="">Kč</span>
    (<span property="gr:valueAddedTaxIncluded" content="false" datatype="xsd:boolean">not including VAT</span>)            		
  </div>
</div>
```

<p>Or:</p>

```
<div about="http://www.mesto.cz/VZ/12345678" typeof="pc:Contract">
   ...
  <div rel="pc:estimatedPriceLower" typeof="gr:PriceSpecification">
    Estimated price lower:
    <span property="gr:hasCurrencyValue" content="500000.0" datatype="xsd:float">500.000</span>
    <span property="gr:hasCurrency" content="CZK" lang="">Kč</span>
    (<span property="gr:valueAddedTaxIncluded" content="false" datatype="xsd:boolean">not including VAT</span>)            		
  </div>
  <div rel="pc:estimatedPriceUpper" typeof="gr:PriceSpecification">
    Estimated price upper:
    <span property="gr:hasCurrencyValue" content="2000000.0" datatype="xsd:float">2.000.000</span>
    <span property="gr:hasCurrency" content="CZK" lang="">Kč</span>
    (<span property="gr:valueAddedTaxIncluded" content="false" datatype="xsd:boolean">not including VAT</span>)            		
  </div>  
</div>  
```

<h3>Deadlines</h3>

<p> Further you should introduce in the machine readable form the date of the publication of the public contract, the deadline for sending offers or requests to participate, start date and expected end date of the contract realization; for these sitations, we define in the ontology the properties <tt>pc:publicationDate</tt>, <tt>pc:tenderDeadline</tt>, <tt>pc:startDate</tt> and <tt>pc:estimatedEndDate</tt>. Enter each date in a single (X)HTML element, e.g. <tt>span</tt> having RDFa attribute <tt>property</tt>. But there is one major difference from previous use of attribute <tt>property</tt>. If the format of the date at the web site is different from the format allowed by the datatype <tt>xsd:date</tt> (from the XML Schema language), we have to specify the machine readable form of that date in the attribute <tt>content</tt>. </p>

```
<div about="http://www.mesto.cz/VZ/12345678" typeof="pc:Contract">
   ...
  Publication date: 
  <span property="pc:publicationDate" content="2010-01-01" datatype="xsd:date">1.1.2010</span>
  <br/>Tender deadline: 
  <span property="pc:tenderDeadline" content="2010-01-01" datatype="xsd:date">1.1.2010</span>
  <br/>Start date: 
  <span property="pc:startDate" content="2010-01-01" datatype="xsd:date">1. 1. 2010</span>
  <br/>End date: 
  <span property="pc:estimatedEndDate" content="2010-01-01" datatype="xsd:date">1. 1. 2010</span>
</div>
```

<p> We can also specify the duration of the contract in days by using the property <tt>pc:durationDays</tt> which has a datatype <tt>xsd:positiveInteger</tt>. </p>

```
<div about="http://www.mesto.cz/VZ/12345678" typeof="pc:Contract">
   ...
  <br/>Duration: 
  <span property="pc:durationDays" datatype="xsd:positiveInteger">31</span>
</div>
```

<h3>Other information</h3>

Other information about the public contract includes its separation to subcontracts. This can be expressed as a link from the contract to subcontract using a standard HTML element <tt>a</tt> with the attribute <tt>rel</tt> with the value <tt>pc:lot</tt>. In addition, you can also refer to the contract's attachment (such as a document with the contract specification) by using the attribute <tt>rel</tt> with the value <tt>pc:attachment</tt> and the desired URI (URL) of the attachment.

```
<div about="http://www.mesto.cz/VZ/12345678" typeof="pc:Contract">
   ...
  Subcontracts: <a rel="pc:lot" href="http://www.mesto.cz/VZ/12345678.html">Subcontract 1</a>,
  <a rel="pc:lot" href="http://www.mesto.cz/VZ/12345678.html">Subcontract 2</a>
  <br/><a rel="pc:attachment" href="http://www.mesto.cz/prilohy/1">Attachment 1</a>
</div>
```

You can always specify that the contract is cancelled by introducing a property <tt>pc:cancellationDate</tt> of the element <tt>div</tt> or <tt>span</tt> with the desired date when the contract was cancelled.

```
<div about="http://www.mesto.cz/VZ/12345678" typeof="pc:Contract">
   ...
<span property="pc:cancellationDate" content="2010-01-01" datatype="xsd:date">1. 1. 2010</span>
   ...
</div>
```

<h2>Public contract is awarded</h2>

<p> When the public contract is awarded, we can add more information - the number of offers (tenders) received using the property <tt>pc:numberOfTenders</tt>. The value is a data type <tt>xsd:nonNegativelnteger</tt>, which denotes the natural numbers and zero as the right values for that property. </p>

```
<div about="http://www.mesto.cz/VZ/12345678" typeof="pc:Contract">
   ...
  <h2>Number of tenders: <span property="pc:numberOfTenders" datatype="xsd:nonNegativeInteger">2</span></h2> 
</div>     
```

<p> The ontology also allows to publish the tenders as an instance of the class <tt>pc:Tender</tt>. The tenders can be assigned to the public contract by using the property <tt>pc:tender </tt>. </p>

```
<div about="http://www.mesto.cz/VZ/12345678" typeof="pc:Contract">
  ...
  Tenders:
  <div rel="pc:tender" typeof="pc:Tender">
      ...
  </div>
  <div rel="pc:tender" typeof="pc:Tender">
      ...
  </div>
</div>
```

<p>Every tender should be accompannied by the information about a company, which sends the offer, using the property <tt>pc:supplier</tt>. The company should be anonymous instance of the class <tt>gr:BusinessEntity</tt>, i.e. Add further information about the company, such as its name (the property <tt>gr:legalName</tt>) and identification number (the property <tt>br:officialNumber</tt>). Apart from the supplier's profile, you should introduce the offered price of that company by using property <tt>pc:offeredPrice</tt> in the similar way as was already explained - i.e. as an anonymous instance of the class <tt>gr:PriceSpecification</tt>. The particular price should be specified within the property <tt>gr:hasCurrencyValue</tt>), its currency within the property <tt>gr:hasCurrency</tt>) and you should also introduce whether VAT is included or not (the property <tt>gr:valueAddedTaxIncluded</tt>).</p>

```
<div about="http://www.mesto.cz/VZ/12345678" typeof="pc:Contract">
   ...
  <div rel="pc:tender" typeof="pc:Tender">
    <span rel="pc:supplier" typeof="gr:BusinessEntity">
      Suppliers:
      <span property="gr:legalName">Druhá pojízdná a.s.</span>, IČ
      <span property="br:officialNumber" lang="">24681012</span>
    </span>
    <span rel="pc:offeredPrice" typeof="gr:PriceSpecification">
      Offered price:
      <span property="gr:hasCurrencyValue" content="550000.0" datatype="xsd:float">55.000</span>
      <span property="gr:hasCurrency" content="EUR" lang="">€</span>
      <span property="gr:valueAddedTaxIncluded" content="false" datatype="xsd:boolean">not including VAT</span>      
    </span>

</div>
```

<p>The winning tender is associated with the contract by using property <tt>pc:awardedTender</tt>.</p>

```
<div about="http://www.mesto.cz/VZ/12345678" typeof="pc:Contract">
  ...
  Winning tender:
  <div rel="pc:awardedTender" typeof="pc:Tender">
      ...
  </div>
</div>
```

<p>Price agreed with the winning supplier (in the contract) can be introduced by using the property <tt>pc:pc:agreedPrice</tt>. Date, when the contract was awarded, should be specified using the property <tt>pc:awardDate</tt>.</p>

```
<div about="http://www.mesto.cz/VZ/12345678" typeof="pc:Contract">
  ...
  Date:
  <span property="pc:awardDate" content="2010-01-01" datatype="xsd:date">1.1.2010</span>
  
  <div rel="pc:agreedPrice" typeof="gr:PriceSpecification">
    Agreed price:
    <span property="gr:hasCurrencyValue" content="150000.0" datatype="xsd:float">150.000</span>
    <span property="gr:hasCurrency" content="CZK" lang="">Kč</span>           		
    (<span property="gr:valueAddedTaxIncluded" content="false" datatype="xsd:boolean">bez daně</span>)
  </div>
</div>
```

<h2>Public contract is finished</h2>
<p>When the contract is realized, you should add information about the actual price and the the actual end date of the realization.</p>
```
<div about="http://www.mesto.cz/VZ/12345678" typeof="pc:Contract">
  ...
  Actual end date: 
  <span property="pc:actualEndDate" content="2010-01-01" datatype="xsd:date">1. 1. 2010</span>

  <div rel="pc:actualPrice" typeof="gr:PriceSpecification">
    Actual price:
    <span property="gr:hasCurrencyValue" content="150000.0" datatype="xsd:float">150.000</span>
    <span property="gr:hasCurrency" content="CZK" lang="">Kč</span>           		
    (<span property="gr:valueAddedTaxIncluded" content="false" datatype="xsd:boolean">bez daně</span>)            		
  </div>
</div>
```

<p>Further, you can also introduce information about any subsidies (an amount of the actual price) used for the realization of the contract. Since a subsidy does not have the same semantics as price, we use <a href='http://data.gov.uk/resources/payments'>Payments Ontology</a> to specify any subsidy. In particular, we use RDF property <tt>pc:subsidy</tt> and its value - an anonymous instance of the class <tt>payment:Payment</tt> - to which you add, using the property <tt>payment:expenditureLine</tt>, another anonymous instance of class <tt>payment:ExpenditureLine</tt>. Finally, the property <tt>payment:netAmount</tt> of that instance holds machine readable information about the subsidy (the particular amount) by using the attribute <tt>content</tt> and the attribute <tt>datatype</tt> with the value <tt>xsd:decimal</tt>. Furthermore, you should introduce the currency of the subsidy by using the property <tt>payment:currency</tt> with the value - resource - representing the given currency.</p>
```
<div about="http://www.mesto.cz/VZ/12345678" typeof="pc:Contract">
  ...
  <div rel="pc:subsidy" typeof="payment:Payment">
    Subsidy:
    <span rel="payment:expenditureLine" typeof="payment:ExpenditureLine">
      <span property="payment:netAmount" content="2000000" datatype="xsd:decimal">2.000.000</span>
      <span rel="payment:currency" resource="http://dbpedia.org/resource/Czech_koruna">Kč</span>
    </span>            		
  </div>
```