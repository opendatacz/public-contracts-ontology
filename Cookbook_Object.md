# Cookbook: Object #

## Resource type ##

  * `skos:Concept`

## Labels ##

  * **Preferred label:** object
  * **Non-preferred labels:** subject, code, descriptor, topic

## Description ##

One way of describing the objects of the public contract is through concepts, such as the Common Procurement Vocabulary (CPV) codes.

## Modelling patterns ##

We can specify one `pc:mainObject` and multiple `pc:additionalObject` properties. The range is
`skos:Concept`. In Public Contracts Ontology we use CPV codes as can be seen in the example.

## Example (Turtle) ##

```
<http://www.praha.eu/id/contract/12345678> a pc:Contract ;
  pc:mainObject <http://purl.org/weso/pscs/cpv/2008/resource/18911000> ;
  pc:additionalObject <http://purl.org/weso/pscs/cpv/2008/resource/18913000>
  .
```