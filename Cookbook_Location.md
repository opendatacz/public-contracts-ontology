# Cookbook: Location #

## Resource type ##

  * `s:Place` (`<http://schema.org/Place>`)

## Labels ##

  * **Preferred label:** location
  * **Non-preferred labels:** place, site, address

## Description ##

Location specifies the place where the contracted product or service is delivered.

## Modelling patterns ##

We attach the location using the `pc:location` property. The range is `s:Place`, which means that any more specific subclass of `s:Place` defined by the `schema.org` vocabulary can be used.

Moreover, we add a property `pceu:hasParentRegion` to explicitly asociate the place with a NUTS region. This is meaningful only for public contracts delivered in European Union and, therefore, it is introduced by the `pceu:` module of the Public Contract Ontology. We use the resources representing NUTS regions defined in `http://ec.europa.eu/eurostat/ramon/rdfdata/nuts2008/`.

## Example (Turtle) ##

```
<http://www.example.com/resource/sample-contract>
  pc:location <http://www.example.com/resource/sample-location> .
  
<http://www.example.com/resource/sample-location>
  a s:City ;
  s:description "Hlavní město Praha"@cs, "Capital city of Prague"@en ;
  pceu:hasParentRegion <http://ec.europa.eu/eurostat/ramon/rdfdata/nuts2008/CZ010> .
```