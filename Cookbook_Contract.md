# Cookbook: Contract #

## Resource type ##

  * `pc:Contract`

## Labels ##

  * **Preferred label:** contract
  * **Non-preferred labels:** request for proposal, request for pricing, request for quotation, invitation to tender, request for tender, public procurement notice, invitation to tender, invitation for bids, call for bids, statement of work

## Description ##

A basic class for public contract description during all stages of its existence.

## Modelling patterns ##

A public contract is always represented as an instance of `pc:Contract` class. It is a resource with own HTTP(S) URI. The contract data modeled as instances of different classes is described in the following sections. The data properties of `pc:Contract` are described here.

```
<http://www.example.com/resource/sample-contract>
  a pc:Contract .
```

### Title and description ###

We assign a contract title as `dcterms:title` and `rdfs:label`. Its description is assigned as `dcterms:description`.

```
<http://www.example.com/resource/sample-contract>
  dcterms:title "Zajištění antivirové a antispamové ochrany"@cs, "Providing anti-virus and anti-spam protection"@en ;
  rdfs:label "Zajištění antivirové a antispamové ochrany"@cs, "Providing anti-virus and anti-spam protection"@en ;
  dcterms:description "Předmětem veřejné zakázky je dodávka komplexního Systému antivirové ochrany spočívající v pořízení SW včetně projektu, implementace a správy pro antivirovou a antispamovou ochranu. "@cs, The object of the public contract is the delivery of a comprehensive anti-virus protection. A software will be buyed including design, implementation and administration of the anti-virus and anti-spam protection."@en .
```

### Procedure and kind ###

We use `pc:procedureType` property to specify a procedure which determines how information about the contract is published and how a supplier is chosen. Its value is a SKOS concept from `proctypes:` SKOS concept scheme:

  * `proctypes:Open`
  * `proctypes:Restricted`
  * `proctypes:AcceleratedRestricted`
  * `proctypes:Negotiated`
  * `proctypes:AcceleratedNegotiated`
  * `proctypes:CompetitiveDialogue`

Another property is `pc:kind` specifying a basic focus of a contract on works, supplies or services. Its value is a SKOS concept from `kinds:` SKOS concept scheme. The scheme contains three top concepts (each having several narrower concepts which can be used to describe the focus more specifically):

  * `pc:Supplies`
  * `pc:Works`
  * `pc:Services`

```
<http://www.example.com/resource/sample-contract>
  pc:procedureType proctypes:Open ;
  pc:kind kinds:SuppliesPurchase .
```

### Contracting authority ###

A contracting authority is an institution which issues a contract. It may be a State, regional or local authority, body governed by public law, etc. The contract is associated with its contracting authority by the property `pc:contractingAuthority`. The authority is represented as an instance of `gr:BusinessEntity`, i.e. we reuse GoodRelations ontology. For more details see [Contracting authority](Cookbook_Contracting_authority.md).

```
<http://www.example.com/resource/sample-contract>
  pc:contractingAuthority <http://www.example.com/resource/sample-authority> .
```

It is also possible that the contracting authority is purchasing on behalf of other contracting authorities. In that case, these contracting authorities are assigned to the contract by the property `pc:onBehalfOf`.

```
<http://www.example.com/resource/sample-contract>
  pc:onBehalfOf <http://www.example.com/resource/another-sample-authority> .
```

### Contact ###

There is usually a contact point or person associated with a public contract. It may be, e.g., a person or office from the contracting authority or from another business entity. Therefore, it does not belong to the contracting authority but to the contract directly. It is assigned to the contract by the property `pc:contact` and is expressed as an instance of `vcard:VCard`. For more details see [Contact](Cookbook_Contact.md).

```
<http://www.example.com/resource/sample-contract>
  pc:contact <http://www.example.com/resource/sample-contract/contact> .
```

### Contract identifiers ###

A contract may have various identifiers. It can be, e.g., an identifier issued by the contracting authority, governmental authority or another institution. There are no specific properties for the identifiers. Instead, we use `adms:identifier` property. Its domain is `adms:Identifier`. An identifier is a resource with own HTTP(S) URI (for the details on its usage see [Identifier](Cookbook_Identifier.md)).

```
<http://www.example.com/resource/sample-contract>
  adms:identifier <http://www.example.com/resource/sample-contract/identifier/1> ; # identifier issued by a governmental authority
  adms:identifier <http://www.example.com/resource/sample-contract/identifier/2> . # identifier issued by the contracting authority
```

### Common Procurement Vocabulary (CPV) ###

Commong Procurement Vocabulary (CPV) is a vocabulary which is used to characterize the products or services purchased by a contract. The CPV codes associated with the contract are called objects. There is one main object associated by `pc:mainObject` property and several additional objects associated by `pc:additionalObject` property. We reuse `http://purl.org/weso/cpv/2008/scheme` concept scheme for CPV codes.

```
<http://www.example.com/resource/sample-contract>
  pc:mainObject <http://purl.org/weso/cpv/2008/48760000> ;
  pc:additionalObject <http://purl.org/weso/cpv/2008/48761000> ;
  pc:additionalObject <http://purl.org/weso/cpv/2008/72600000> .
```

### Locations ###

A place of delivery of a contracted product or performance of a contracted service may be assigned to a contract using the property `pc:location`. Moreover, we introduce `pc:tenderOpeningLocation` to specify the location of opening the tenders. As the domain of both we reuse `s:Place`. See [Location](Cookbook_Location.md) for details.

```
<http://www.example.com/resource/sample-contract>
  pc:location <http://www.example.com/resource/sample-location> ;
  pc:tenderOpeningLocation <http://www.example.com/resource/sample-opening-location> .
```

### Prices ###

A public contract has usually an estimated price specified before tenders are received. It may be an exact estimated price or a range comprising minimal and maximal estimated price. In both cases, the price is assigned to the contract using the property `pc:estimatedPrice`. It is also possible to specify the price of the specification and other descriptive documents assigned to the contract using the property `pc:documentsPrice`. After a tender is awarded a contract price is agreed between the awarded supplier and contracting authority. This price is assigned to the contract with property `pc:agreedPrice`. The actual price after the contract is realized may be assigned to the contract using property `pc:actualPrice`. All prices have range `gr:PriceSpecification`. It is recommended that all are resources with own HTTP(S) URI. For more details on prices see [Price](Cookbook_Price.md).

```
<http://www.example.com/resource/sample-contract>
  pc:estimatedPrice <http://www.example.com/resource/sample-contract/price-specification/1> ;
  pc:documentsPrice <http://www.example.com/resource/sample-contract/price-specification/2> ;
  pc:agreedPrice <http://www.example.com/resource/sample-contract/price-specification/3> ;
  pc:actualPrice <http://www.example.com/resource/sample-contract/price-specification/4> .
```

When the contract is paid partly (or fully) from a subsidy, the amout of subsidy can be specified by the property `pc:subsidy` as an instance of `payment:Payment` class. For more details on prices see [Subsidy](Cookbook_Subsidy.md).

```
<http://www.example.com/resource/sample-contract>
  pc:subsidy <http://www.example.com/resource/sample-contract/payment/1> .
```

### Dates and deadlines ###

There are various dates and deadlines related to a public contract. Regarding deadlines, there may be a time limit for receipt of requests for documents assigned to the contract by the property `pc:documentsRequestDeadline`. Morever, the contract should have a time limit for receipt of tenders or requests to participate. This is assigned to the contract by the property `pc:tenderDeadline`. Deadlines are expressed as `xsd:dateTime` values.

Regarding dates, the contract has the expected duration in days, months or years. It is assigned to the contract by the property `pc:duration` and is expressed as `xsd:duration` value. It is also possible to specify the required start date of performing the contract and estimated end date with properties `pc:startDate` and `pc:estimatedEndDate`, respectively. After the contract has been realized, the actual end date can be different from the estimated end date. The actual end date can be assigned to the contract with property `pc:actualEndDate`. All dates are  expressed as `xsd:date` values.

Another kind of dates are those related to tenders of the contract. The date and time of opening the tenders can be assigned using the property `pc:tenderOpeningDateTime`. Sometimes, minimum time frame during which the tenderer must maintain is specified. This can be assigned by property `pc:tenderMaintenanceDuration`.

```
<http://www.example.com/resource/sample-contract>
  pc:documentsRequestDeadline "2012-04-19T11:00:00"^^<http://www.w3.org/2001/XMLSchema#dateTime> ;
  pc:tenderDeadline "2012-04-19T11:00:00"^^<http://www.w3.org/2001/XMLSchema#dateTime> ;
  pc:tenderOpeningDateTime "2012-04-20T09:00:00"^^<http://www.w3.org/2001/XMLSchema#dateTime> ;
  pc:tenderMaintenanceDuration "P90D"^^<http://www.w3.org/2001/XMLSchema#date> ;
  pc:startDate "2012-09-15"^^<http://www.w3.org/2001/XMLSchema#date> ;
  pc:estimatedEndDate "2012-12-31"^^<http://www.w3.org/2001/XMLSchema#date> .
```

Let us note that it is also possible to consider various date related to the life-cycle of the contract, e.g. publication date, award date or cancellation date. However, these dates are not expressed explicitly with specific properties. Important events in the contract's life-cycle are modeled using contract notices described below, e.g., contract notice, contract award notice or cancellation notice. The dates mentioned above are then expressed as publication dates of respective notices.

### Items ###

Besides the official CPV codes it is also possible to characterize the specific products and/or services intended to be bought by the contracting authority as one or more instances of `gr:Offering` associated with the contract by the `pc:item` property. See [Item](Cookbook_Item.md) for more details.

```
<http://www.example.com/resource/sample-contract>
  pc:item <http://www.example.com/resource/sample-contract/item/1> ;
  pc:item <http://www.example.com/resource/sample-contract/item/2> ;
  pc:item <http://www.example.com/resource/sample-contract/item/3> .
```

### Lots ###

A complex contract may be split by the contracting authority to two or more lots. A lot is assigned to the contract with property `pc:lot`. We understood a lot as a smaller contract which is part of another contract. Therefore, a lot is represented also as an instance of `pc:Contract`.

```
<http://www.example.com/resource/sample-contract>
  pc:lot <http://www.example.com/resource/sample-contract/lot/1> ;
  pc:lot <http://www.example.com/resource/sample-contract/lot/2> .
```

### Award criteria ###

There are usually award criteria which specify conditions under which the best tender will be selected and awarded. The set of criteria is represented as an instance of the class `pc:AwardCriteriaCombination` and is assigned to the contract with the property `pc:awardCriteriaCombination`. Each weighted criterion is then represented as an instance of the class `pc:CriterionWeighting` and is assigned to the set by `pc:awardCriterion`. See [Criterion weighting](Cookbook_Award_criterion.md) for more details.

<a href='Hidden comment: 
with two properties: pc:weightedCriterion and pc:criterionWeight. The former specifies the criterion using a suitable SKOS concept. It is possible to use two predefined SKOS concepts in criteria: SKOS concept scheme (i.e. criteria:Price for a criterion related to price or criteria:LowestPrice specifying that the criterion is the lowest price). The other specifies the weight of the criterion as percentage.
'></a>

```
<http://www.example.com/resource/sample-contract>
  pc:awardCriteriaCombination <http://www.example.com/resource/sample-contract/combination-of-contract-award-criteria/1> .

<http://www.example.com/resource/sample-contract/combination-of-contract-award-criteria/1>
  a pc:AwardCriteriaCombination ;
  pc:awardCriterion <http://www.example.com/resource/sample-contract/combination-of-contract-award-criteria/1/contract-award-weighted-criterion/1> ;
  pc:awardCriterion <http://www.example.com/resource/sample-contract/combination-of-contract-award-criteria/1/contract-award-weighted-criterion/2> .
```

### Tenders ###

Each tender to a contract is represented as an instance of `pc:Tender`. A tender consits of an offered price, supplier and the specification of the offer by the supplier. See [Tender](Cookbook_Tender.md) for more details. A tender is assigned to the contract by property `pc:tender`. After one of the tenders is awarded it is assigned to the contract using the property `pc:awardedTender`. If only an information about the number of tenders is present it is possible to use property `pc:numberOfTenders` to assign this number to the contract.

```
<http://www.example.com/resource/sample-contract>
  pc:tender <http://www.example.com/resource/sample-contract/tender/1> ;
  pc:awardedTender <http://www.example.com/resource/sample-contract/tender/2> ;
  pc:tender <http://www.example.com/resource/sample-contract/tender/3> .
```

### Notices ###

During the contract's life cycle various notices about the contract can be published, e.g., prior information notice, contract notice, contract award notice, contract cancellation notice, etc. All these notices are represented as instances of specific sub-classes of `pc:Notice` and assigned to the contract using property `pc:notice`. For more details see [Notice](Cookbook_Notice.md).

```
<http://www.example.com/resource/sample-contract>
  pc:notice <http://www.example.com/resource/contract-notice/x567432112354> ;
  pc:notice <http://www.example.com/resource/contract-award-notice/x426577312954> .
```

### Associated documents ###

A public contract can be associated with several kinds of documents, so called attachments, e.g. contract specification or agreement, by `pc:attachment` property. We also distinguish two specific sub-types of `pc:attachment`: `pc:specification` for assigning the specification of the contract and `pc:agreement` for assigning the contract agreement. For representing the attachments we reuse `foaf:Document`.

```
<http://www.example.com/resource/sample-contract>
  pc:attachment <http://www.example.com/resource/sample-contract/attachment/1> ;
  pc:attachment <http://www.example.com/resource/sample-contract/attachment/2> ;
  pc:attachment <http://www.example.com/resource/sample-contract/specification/3> ;
  pc:attachment <http://www.example.com/resource/sample-contract/agreement/4> .
```

## Identifier patterns ##

Instances of `pc:Contract` should always have an URI identifier in the `http(s)` URI scheme.

## Example (Turtle) ##

```
<http://www.example.com/resource/sample-contract>
  a pc:Contract .
  dcterms:title "Zajištění antivirové a antispamové ochrany"@cs, "Providing anti-virus and anti-spam protection"@en ;
  rdfs:label "Zajištění antivirové a antispamové ochrany"@cs, "Providing anti-virus and anti-spam protection"@en ;
  dcterms:description "Předmětem veřejné zakázky je dodávka komplexního Systému antivirové ochrany spočívající v pořízení SW včetně projektu, implementace a správy pro antivirovou a antispamovou ochranu. "@cs, The object of the public contract is the delivery of a comprehensive anti-virus protection. A software will be buyed including design, implementation and administration of the anti-virus and anti-spam protection."@en ;
  pc:procedureType proctypes:Open ;
  pc:kind kinds:SuppliesPurchase ;
  pc:contractingAuthority <http://www.example.com/resource/sample-authority> ;
  pc:onBehalfOf <http://www.example.com/resource/another-sample-authority> ;
  pc:contact <http://www.example.com/resource/sample-contract/contact> ;
  adms:identifier <http://www.example.com/resource/sample-contract/identifier/1> ;
  adms:identifier <http://www.example.com/resource/sample-contract/identifier/2> ;
  pc:mainObject <http://purl.org/weso/cpv/2008/48760000> ;
  pc:additionalObject <http://purl.org/weso/cpv/2008/48761000> ;
  pc:additionalObject <http://purl.org/weso/cpv/2008/72600000> ;
  pc:location <http://www.example.com/resource/sample-location> ;
  pc:tenderOpeningLocation <http://www.example.com/resource/sample-opening-location> ;
  pc:estimatedPrice <http://www.example.com/resource/sample-contract/price-specification/1> ;
  pc:documentsPrice <http://www.example.com/resource/sample-contract/price-specification/2> ;
  pc:agreedPrice <http://www.example.com/resource/sample-contract/price-specification/3> ;
  pc:actualPrice <http://www.example.com/resource/sample-contract/price-specification/4> ;
  pc:subsidy <http://www.example.com/resource/sample-contract/payment/1> ;
  pc:documentsRequestDeadline "2012-04-19T11:00:00"^^<http://www.w3.org/2001/XMLSchema#dateTime> ;
  pc:tenderDeadline "2012-04-19T11:00:00"^^<http://www.w3.org/2001/XMLSchema#dateTime> ;
  pc:tenderOpeningDateTime "2012-04-20T09:00:00"^^<http://www.w3.org/2001/XMLSchema#dateTime> ;
  pc:tenderMaintenanceDuration "P90D"^^<http://www.w3.org/2001/XMLSchema#date> ;
  pc:startDate "2012-05-15"^^<http://www.w3.org/2001/XMLSchema#date> ;
  pc:estimatedEndDate "2012-10-31"^^<http://www.w3.org/2001/XMLSchema#date> ;
  pc:item <http://www.example.com/resource/sample-contract/item/1> ;
  pc:item <http://www.example.com/resource/sample-contract/item/2> ;
  pc:item <http://www.example.com/resource/sample-contract/item/3> ;
  pc:lot <http://www.example.com/resource/sample-contract/lot/1> ;
  pc:lot <http://www.example.com/resource/sample-contract/lot/2> ;
  pc:awardCriteriaCombination <http://www.example.com/resource/sample-contract/combination-of-contract-award-criteria/1> ;
  pc:tender <http://www.example.com/resource/sample-contract/tender/1> ;
  pc:awardedTender <http://www.example.com/resource/sample-contract/tender/2> ;
  pc:tender <http://www.example.com/resource/sample-contract/tender/3> ;
  pc:notice <http://www.example.com/resource/isvzus.cz/contract-notice/7202010012179> ;
  pc:notice <http://www.example.com/resource/isvzus.cz/contract-award-notice/7203010012179> ;
  pc:attachment <http://www.example.com/resource/sample-contract/attachment/1> ;
  pc:attachment <http://www.example.com/resource/sample-contract/attachment/2> ;
  pc:attachment <http://www.example.com/resource/sample-contract/specification/3> ;
  pc:attachment <http://www.example.com/resource/sample-contract/agreement/4> .
  
<http://www.example.com/resource/sample-contract/combination-of-contract-award-criteria/1>
  a pc:AwardCriteriaCombination ;
  pc:awardCriterion <http://www.example.com/resource/sample-contract/combination-of-contract-award-criteria/1/contract-award-weighted-criterion/1> ;
  pc:awardCriterion <http://www.example.com/resource/sample-contract/combination-of-contract-award-criteria/1/contract-award-weighted-criterion/2> .  
```