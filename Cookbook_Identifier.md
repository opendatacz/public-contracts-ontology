# Cookbook: Identifier #

## Resource type ##

  * `adms:Identifier`

## Labels ##

  * **Preferred label:** identifier
  * **Non-preferred labels:** identity, official number

## Description ##

For all kinds of identifiers of public contracts, notices, contracting authorities, suppliers, etc. we use instance of the class `adms:Identifier`.

## Modelling patterns ##

Any identifier is modelled as an instance of the class `adms:Identifier`. It is a resource with own HTTP(S) URI. It is associated with the identified resource (e.g., a public contract or contracting authority) by the property `adms:identifier`. We use the property `skos:notation` to express the identifier value, `dcterms:creator` to associate the identifier with the issuer of the identifier, and `adms:schemeAgency` to express the name of the issuer. This corresponds to the [Asset Description Metadata Schema (ADMS)](http://www.w3.org/ns/adms). Other properties defined by ADMS can be used as well.

## Example (Turtle) - Identifiers of a public contract ##

```
<http://www.example.com/resource/sample-contract>
  a pc:Contract ;
  adms:identifier <http://www.example.com/resource/sample-contract/identifier/1> ;
  adms:identifier <http://www.example.com/resource/sample-contract/identifier/2> .

<http://www.example.com/resource/sample-contract/identifier/1> # Official identifier issued by the Ministry for Regional Development of Czech Republic. (The ministry issues official identifier of all public contracts issued by Czech contracting authorities)
  a adms:Identifier ;
  skos:notation "x128233"^^<http://www.w3.org/2001/XMLSchema#string> ;
  dcterms:creator <http://ld.opendata.cz/resource/business-entity/CZ66002222> ; # The issuer is the ministry in LD infrastructure of Czech Republic
  adms:schemeAgency "Ministerstvo pro místní rozvoj" .
  
<http://www.example.com/resource/sample-contract/identifier/2> # Local identifier issued by the contractor for its internal purposes. 
  a adms:Identifier ;
  skos:notation "MF-24866/2012/23-232/T"^^<http://www.w3.org/2001/XMLSchema#string> ;
  dcterms:creator <http://www.example.com/resource/sample-authority> . # The issuer is the contracting authority itself
```