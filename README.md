# Public Contracts Ontology

The Public Contracts Ontology serves to express structured data about public contracts in RDF, in a machine-readable format. It is developed by the Czech [OpenData.cz](http://www.opendata.cz/) initiative.

## Design

In the group, we have examined the existing RDF vocabularies and ontologies, such as [GoodRelations](http://purl.org/goodrelations/v1.html) or [Payments Ontology](http://data.gov.uk/resources/payments), but we have not found a suitable one for expressing structured data about public contracts. Thus, we set forth to create a new ontology that maps to the available vocabularies. The design of the Public Contracts Ontology was informed by the work of others, both ontologies and vocabularies of RDF and non-RDF origin. Its design strives to align it with other related projects, for example, in adopting established terminology for naming or re-using existing components.
 
The ontology builds on [GoodRelations](http://purl.org/goodrelations/v1.html) for description of business entities, such as cities publishing public procurement tenders or commercial companies applying for them. The specification of prices is based on the same vocabulary.

Public contracts may have spendings attached. For this purpose, the Payment Ontology used by the [Data.gov.uk](http://data.gov.uk/resources/payments) project.

One of the goals of the ontology is to re-use the established terminology used to describe the domain of public procurement in the [TED - Tenders Electronic Daily](http://ted.europa.eu/) system for registering public contracts in the European Union.

## Licence

The ontology is licenced under the terms of [Creative Commons By 3.0 licence](http://creativecommons.org/licenses/by/3.0/cz/). This is an [open licence](http://www.opendefinition.org/) that allows to use, re-use, and re-distribute its contents subjected only to the requirement of attribution.

## Cookbook

A detailed cookbook containing recommendations on data modelling or linking is available in the [project wiki](https://github.com/opendatacz/public-contracts-ontology/blob/wiki/Cookbook.md).

## Report

The report deliverable about the Public Contracts Ontology for the [LOD2 project](http://lod2.eu) may be [downloaded here](http://static.lod2.eu/Deliverables/deliverable-9a.1.1.pdf) (PDF).
