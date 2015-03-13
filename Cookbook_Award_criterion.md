# Cookbook: Award criterion #

## Resource type ##

  * `pc:CriterionWeighting`

## Labels ##

  * **Preferred label:** award criterion
  * **Non-preferred labels:** award condition

## Description ##

Describes a criterion used to evaluate individual tenders to a public contract.

## Modelling patterns ##

An award criterion is represented as an instance of the class `pc:CriterionWeighting`. It has two properties: `pc:weightedCriterion` and `pc:criterionWeight`. The former property attaches the criterion that is weighted. It is a SKOS concept from an arbitrary suitable SKOS concept scheme. There are two predefined SKOS concepts: `criteria:LowestPrice` for an often used criterion specifying the lowest price and `criteria:TechnicalQuality` for another often used criterion specifying the technical quality of the offered products/services. The other property specifies the criterion weight for tender evaluation. Its value is `pcdt:percentage`.

## Example (Turtle) ##

```
<http://www.example.com/resource/sample-contract>
  pc:awardCriteriaCombination <http://www.example.com/resource/sample-contract/combination-of-contract-award-criteria/1> .

<http://www.example.com/resource/sample-contract/combination-of-contract-award-criteria/1>
  a pc:AwardCriteriaCombination ;
  pc:awardCriterion <http://www.example.com/resource/sample-contract/combination-of-contract-award-criteria/1/contract-award-weighted-criterion/1> ;
  pc:awardCriterion <http://www.example.com/resource/sample-contract/combination-of-contract-award-criteria/1/contract-award-weighted-criterion/2> .

<http://www.example.com/resource/sample-contract/combination-of-contract-award-criteria/1/contract-award-weighted-criterion/1>
  a pc:CriterionWeighting;
  pc:weightedCriterion criteria:LowestPrice ;
  pc:criterionWeight "60"^^pcdt:percentage
  .

<http://www.example.com/resource/sample-contract/combination-of-contract-award-criteria/1/contract-award-weighted-criterion/1>
  a pc:CriterionWeighting;
  pc:weightedCriterion criteria:TechnicalQuality ;
  pc:criterionWeight "40"^^pcdt:percentage
  .

```