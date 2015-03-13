# Cookbook for modelling data in the domain of public procurement #

The cookbook shows how to model resources in the domain of public procurement with the Public Contracts Ontology and related RDF vocabularies and ontologies. It covers the basic resources types that may be encountered in data describing this domain.

Throughout the cookbook we will use a fictive example of a public contract issued by a city in order to purchase whips and saddles for the police. Using this example, we describe classes from the ontology and their usage.

We use the following prefixes in the cookbook:

```
@prefix adms:     <http://www.w3.org/ns/adms#> .
@prefix c4n:      <http://vocab.deri.ie/c4n#> .
@prefix dcterms:  <http://purl.org/dc/terms/> .
@prefix foaf:     <http://xmlns.com/foaf/0.1/> .
@prefix gr:       <http://purl.org/goodrelations/v1#> .
@prefix irw:      <http://www.ontologydesignpatterns.org/ont/web/irw.owl#> .
@prefix loted:    <http://loted.eu/ontology#> .
@prefix owl:      <http://www.w3.org/2002/07/owl#> .
@prefix payment:  <http://reference.data.gov.uk/def/payment#> .
@prefix qb:       <http://purl.org/linked-data/cube#> .
@prefix rdf:      <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs:     <http://www.w3.org/2000/01/rdf-schema#> .
@prefix s:        <http://schema.org/> .
@prefix skos:     <http://www.w3.org/2004/02/skos/core#> . 
@prefix vann:     <http://purl.org/vocab/vann/> .
@prefix vcard:    <http://www.w3.org/2006/vcard/ns#> .
@prefix xsd:      <http://www.w3.org/2001/XMLSchema#> .

@prefix activities:  <http://purl.org/procurement/public-contracts-activities#> .
@prefix authkinds:   <http://purl.org/procurement/public-contracts-authority-kinds#> .
@prefix kinds:       <http://purl.org/procurement/public-contracts-kinds#> .
@prefix proctypes:   <http://purl.org/procurement/public-contracts-procedure-types#> .
@prefix criteria:    <http://purl.org/procurement/public-contracts-criteria#> .
@prefix pc:          <http://purl.org/procurement/public-contracts#> .
@prefix pcdt:        <http://purl.org/procurement/public-contracts-datatypes#> .
```

## Ontology diagram ##

![http://public-contracts-ontology.googlecode.com/hg/diagrams/public-contracts-uml.png](http://public-contracts-ontology.googlecode.com/hg/diagrams/public-contracts-uml.png)

## Resources covered ##

  * [Contract](Cookbook_Contract.md)
  * [Contracting authority](Cookbook_Contracting_authority.md)
  * [Contact](Cookbook_Contact.md)
  * [Identifier](Cookbook_Identifier.md)
  * [Location](Cookbook_Location.md)
  * [Price](Cookbook_Price.md)
  * [Subsidy](Cookbook_Subsidy.md)
  * [Item](Cookbook_Item.md)
  * [Criterion weighting](Cookbook_Award_criterion.md)
  * [Tender](Cookbook_Tender.md)
  * [Notice](Cookbook_Notice.md)
  * [Supplier](Cookbook_Supplier.md)

<a href='Hidden comment: 
'></a>

## Linking to external datasets ##

  * [Attachment](Linking_Attachment.md)
  * [Concept](Linking_Concept.md)
  * [Contracting authority](Linking_Contracting_authority.md)
  * [Legal regulation](Linking_Legal_regulation.md)
  * [Location](Linking_Location.md)
  * [Payment](Linking_Payment.md)
  * [Product or service](Linking_Product_or_service.md)
  * [Subsidy](Linking_Subsidy.md)
  * [Supplier](Linking_Supplier.md)

## Recommendations ##

  * [Identifier patterns](Cookbook_Identifier_patterns.md)

<a href='Hidden comment: 
== Complete examples ==

* [RDFa_recipe RDFa recipe]
* [http://public-contracts-ontology.googlecode.com/hg/examples/Contract23718455.ttl Contract23718455]
* [http://public-contracts-ontology.googlecode.com/hg/examples/Contract52478914.ttl Contract52478914]
* [http://public-contracts-ontology.googlecode.com/hg/examples/Contract62349981.ttl Contract62349981]
'></a>