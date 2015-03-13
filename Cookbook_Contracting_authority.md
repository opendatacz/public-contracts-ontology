# Cookbook: Contracting authority #

## Resource type ##

  * `gr:BusinessEntity`

## Labels ##

  * **Preferred label:** contracting authority
  * **Non-preferred labels:** buyer, public sector body, procurer

## Description ##

The contracting authority specifies the business entity which issues the contract.

## Modelling patterns ##

We model the contracting authority information as `gr:BusinessEntity`. We use the property `pc:contractingAuthority` to assign the authority to the contract. It is also possible that there is another contracting authority which acts on behalf of the contracting authority. This authority is assigned to the contract by the property `pc:onBehalfOf`.

We specify the authority’s name by the property `gr:legalName`. An official identification number (if any) is specified for the authority using the property `adms:identifier` (for more details see Cookbook\_Identifier). A postal address of the authority is specified using the property `s:address` (for more details see Cookbook\_Address). The URL of the general website of the authority is specified with the property `foaf:page` and the URL of the website where the authority informs about its public contracts is specified with the property `pc:buyerProfile`.

It is also possible to specify the kind of the authority with `pc:authorityKind` property. A value of this property is a SKOS concept from `authkinds:` SKOS concept scheme. When the kind of main activity of the authority can be characterized then the property `pc:mainActivity` should be used. A value of this property is a SKOS concept from `activities:` SKOS concept scheme.

It is also possible that the kind of the authority or the kind of its main activity is characterized but no suitable SKOS concept can be found. Then, a new SKOS concept in the appropriate SKOS concept scheme should be created.

Let us note that any other property with `gr:BusinessEntity` as a domain defined by other vocabularies, e.g., GoodRelations, can be used as well.

## Example (Turtle) ##

```
<http://www.example.com/resource/sample-contract>
  a pc:Contract ;
  pc:contractingAuthority <http://www.example.com/resource/sample-authority> ;
  pc:onBehalfOf <http://www.example.com/resource/another-sample-authority> .

<http://www.example.com/resource/sample-authority> a gr:BusinessEntity ;
  gr:legalName "Very special local authority"^^<http://www.w3.org/2001/XMLSchema#string> ;
  adms:identifier <http://www.example.com/resource/sample-authority/identifier/1> ;
  s:address <http://www.example.com/resource/sample-authority/address> ;
  foaf:page <http://www.sample-authority-web.com> ;
  pc:buyerProfile <http://www.sample-authority-web.com/public-contracts> ;
  pc:authorityKind authkinds:LocalAuthority ;
  pc:mainActivity activities:a4394a893-61ed-4c6f-82c2-05697c702b2c . 

activities:a4394a893-61ed-4c6f-82c2-05697c702b2c a skos:Concept ;
  skos:inScheme activities: ;
  skos:prefLabel "very special kind of activity"@cs ;
  skos:topConceptOf activities:
  .
  
<http://www.example.com/resource/another-sample-authority> a gr:BusinessEntity ;
  gr:legalName "Small local authority"^^<http://www.w3.org/2001/XMLSchema#string> ;
  adms:identifier <http://www.example.com/resource/another-sample-authority/identifier/1> ;
  s:address <http://www.example.com/resource/another-sample-authority/address> ;
  pc:authorityKind authkinds:LocalAuthority ;
  pc:mainActivity activities:Environment . 
```