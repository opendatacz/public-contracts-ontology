# Cookbook: Item #

## Resource type ##

  * `gr:Offering`

## Labels ##

  * **Preferred label:** item
  * **Non-preferred labels:** contracted product or service

## Description ##

Besides the official CPV codes it is also possible to characterize the specific products and/or services intended to be bought by the contracting authority as one or more instances of `gr:Offering` associated with the contract by the `pc:item` property. `gr:Offering` provides various constructs for a detailed characterization of the products or services intended to be bought. It also allows to exploit [Product Types Ontology](http://www.productontology.org/). For more details see [GoodRelations](http://www.heppnetz.de/projects/goodrelations/).

## Modelling patterns ##

We attach items through the `pc:item` property and instances of the `gr:Offering` class or its subclasses.

## Example (Turtle) ##

```
<http://www.example.com/resource/sample-contract>
  pc:item <http://www.example.com/resource/sample-contract/item/1> ;
  pc:item <http://www.example.com/resource/sample-contract/item/2> ;
  pc:item <http://www.example.com/resource/sample-contract/item/3> .

# Request to buy an anti-virus software
<http://www.example.com/resource/sample-contract/item/1>
  a gr:Offering ;
  gr:includes <http://www.example.com/resource/sample-contract/myObject> ;
  gr:hasBusinessFunction gr:Buy .

# Request to install an anti-virus software
<http://www.example.com/resource/sample-contract/item/2>
  a gr:Offering ;
  gr:includes <http://www.example.com/resource/sample-contract/myObject> ;
  gr:hasBusinessFunction gr:ConstructionInstallation .

# Request to administer (maintain) an anti-virus software
<http://www.example.com/resource/sample-contract/item/3>
  a gr:Offering ;
  gr:includes <http://www.example.com/resource/sample-contract/myObject> ;
  gr:hasBusinessFunction gr:Maintain .

<http://www.example.com/resource/sample-contract/myObject>
  a <http://www.productontology.org/id/Antivirus_software> ;
  a gr:SomeItems .

```