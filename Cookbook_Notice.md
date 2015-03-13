# Cookbook: Notice #

## Resource type ##

  * `pc:Notice`

## Labels ##

  * **Preferred label:** notice
  * **Non-preferred labels:** document, publication, contract

## Description ##

`pc:Notice` models a notice to a public contract. A notice informs about the status of a public contract in a certain stage of its life-cycle. For each stage there is a particular kind of notices. They are modelled as subclasses of `pc:Notice`:

  * `pc:PriorInformationNotice` - publishes information about an intended public contract
  * `pc:ContractNotice` - publishes information about a public contract opened for submitting tenders by interested suppliers
  * `pc:CancellationNotice` - publishes information that a public contract has been cancelled
  * `pc:ContractAwardNotice` - publishes information about awarding a chosen tender to a public contract
  * `pc:ContractAmendmentNotice` - publishes information about amending a public contract

## Modelling patterns ##

A notice is an instance of `pc:Notice` class. It is a resource with own HTTP(S) URI. It is possible to specify the publication date of the notice using the property `pc:publicationDate`. If there is a previous notice of the same resource type it is associated to the notice using the property `pc:previousNotice`. A notice usually has an identifier which can be specified using the `adms:identifier` property (see [Identifier](Cookbook_Identifier.md) for more details).

## Example (Turtle) ##

```
<http://www.example.com/resource/sample-contract>
  pc:notice <http://www.example.com/resource/contract-notice/x567432112354> ;
  pc:notice <http://www.example.com/resource/contract-award-notice/x426577312954> .

<http://www.example.com/resource/contract-notice/x567432112354>
  a pc:ContractNotice ;
  pc:publicationDate "2012-03-27"^^<http://www.w3.org/2001/XMLSchema#date>
  adms:identifier <http://www.example.com/resource/contract-notice/x567432112354/identifier/1>
  .

<http://www.example.com/resource/contract-award-notice/x426577312954>
  a pc:ContractAwardNotice ;
  pc:publicationDate "2012-07-27"^^<http://www.w3.org/2001/XMLSchema#date> ;
  pc:previousNotice <http://www.example.com/resource/contract-notice/x567432112354> ;
  adms:identifier <http://www.example.com/resource/contract-award-notice/x426577312954/identifier/1>
  .
```

## Advanced modelling patterns ##

Note that the previous style of modelling only allows to model that a notice exists and its publication date. However, it is not possible to explicitly express what data (i.e. what triples) were published by the notice. A notice about a public contract is nothing more than a view on part of the contract in a certain moment, i.e. a set of RDF triples describing this part.

If it is required to capture this in the published RDF data, we recommend to create an individual instance of `pc:Contract` with own HTTP(S) URI for each contract notice. This resource is the subject of all RDF triples which belong to the published part about the contract related to the notice. The particular URIs representing the contract can then be linked using the `owl:sameAs` property. As the result we recieve more different URIs representing the same contract. For each URI we have triples related to the view on the contract represented by the related contract notice. It is possible to easily aggregate all contract data using the `owl:sameAs` triples.

In many cases it is necessary to create such separate instance of `pc:Contract` for each notice because contracts are usually published only through notices. However, there may be no unique identifiers of the related contracts and, therefore, the separate instances must be created and linked later manually or using some heuristics.

## Advanced example (Turtle) ##

```
# Resource created on the base of contract notice x567432112354
<http://www.example.com/resource/sample-contract-1>
  pc:notice <http://www.example.com/resource/contract-notice/x567432112354> .
  # triples related to the notice x567432112354

<http://www.example.com/resource/contract-notice/x567432112354>
  a pc:ContractNotice ;
  pc:publicationDate "2012-03-27"^^<http://www.w3.org/2001/XMLSchema#date> .

# Resource created on the base of contract award notice x426577312954
<http://www.example.com/resource/sample-contract-2>
  pc:notice <http://www.example.com/resource/contract-award-notice/x426577312954> .
  # triples related to the notice x426577312954

<http://www.example.com/resource/contract-award-notice/x426577312954>
  a pc:ContractAwardNotice ;
  pc:publicationDate "2012-07-27"^^<http://www.w3.org/2001/XMLSchema#date> .

# owl:sameAs triple created later manually after it had been discovered that both contract resources represent the same contract
<http://www.example.com/resource/sample-contract-1> owl:sameAs <http://www.example.com/resource/sample-contract-2> .
```