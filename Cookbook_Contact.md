# Cookbook: Contact #

## Resource type ##

  * `vcard:VCard`

## Labels ##

  * **Preferred label:** contact

## Description ##

We use the [VCard](http://www.w3.org/Submission/vcard-rdf/) vocabulary to specify contact information for a public contract.

## Modelling patterns ##

A public contract has one or more contact points. A contact point usually consists of contacts to a certain contact person. Therefore, `vcard:VCard` is a natural candidate to represent such information. We use usual VCard properties to represent personal contact information, i.e. `vcard:email` or `vcard:fn` (full name). Note how telephone numbers are modelled. They are anonymous instances of classes like `vcard:Tel`, `vcard:Work`, or `vcard:Fax` and the actual telephone number is specified using their `rdf:value` property, where the value is specified as an URI in the tel URI scheme. Also note that the contact point can sometimes be described only textually in a non-structured form. We use `vcard:note` for this non-structured description.

Another VCard class is `vcard:Address` representing a contact postal address. Instances of this class are attached to the VCard instances using `vcard:adr` property and have properties for specific values such as `vcard:country-name`, `vcard:locality`, etc.

## Example (Turtle) ##

```
<http://www.example.com/resource/sample-contract>
  a pc:Contract ;
  pc:contact <http://www.example.com/resource/sample-contract/contact> .

<http://www.example.com/resource/sample-contract/contact> a vcard:VCard ;
  vcard:note "Krajské ředitelství Liberec, Sokolská 1383/37, 460 01 Liberec 1"^^<http://www.w3.org/2001/XMLSchema#string> ;
  vcard:fn "Peter Example"^^<http://www.w3.org/2001/XMLSchema#string> ;
  vcard:email <mailto:peter@example.com> ;
  vcard:tel [
    a vcard:Work ;
    rdf:value "+42012356784321"^^<http://www.w3.org/2001/XMLSchema#string> 
  ] ;
  vcard:tel [
    a vcard:Fax ;
    rdf:value "+42012356784321"^^<http://www.w3.org/2001/XMLSchema#string> 
  ] ;
  vcard:adr [ 
    a vcard:Address ;
    vcard:country-name "Czech Republic"@en ;
    vcard:locality "Liberec"@cs ;
    vcard:postal-code "460 01"@cs ;
    vcard:street-address "Sokolská 1383/37"@cs
  ] .
```