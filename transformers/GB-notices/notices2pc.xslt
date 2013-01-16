<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	xmlns:adms="http://www.w3.org/ns/adms#"
	xmlns:c4n="http://vocab.deri.ie/c4n#"
	xmlns:dcterms="http://purl.org/dc/terms/"
	xmlns:foaf="http://xmlns.com/foaf/0.1/"
	xmlns:gr="http://purl.org/goodrelations/v1#"
	xmlns:irw="http://www.ontologydesignpatterns.org/ont/web/irw.owl#"
	xmlns:loted="http://loted.eu/ontology#"
	xmlns:owl="http://www.w3.org/2002/07/owl#"
	xmlns:payment="http://reference.data.gov.uk/def/payment#"
	xmlns:qb="http://purl.org/linked-data/cube#"
	xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
	xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
	xmlns:s="http://schema.org/"
	xmlns:skos="http://www.w3.org/2004/02/skos/core#"
	xmlns:vann="http://purl.org/vocab/vann/"
	xmlns:vcard="http://www.w3.org/2006/vcard/ns#"
	xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
	xmlns:activities="http://purl.org/procurement/public-contracts-activities#"
	xmlns:authkinds="http://purl.org/procurement/public-contracts-authority-kinds#"
	xmlns:kinds="http://purl.org/procurement/public-contracts-kinds#"
	xmlns:proctypes="http://purl.org/procurement/public-contracts-procedure-types#"
	xmlns:criteria="http://purl.org/procurement/public-contracts-criteria#"
	xmlns:pc="http://purl.org/procurement/public-contracts#"
	xmlns:pcdt="http://purl.org/procurement/public-contracts-datatypes#"
	xmlns:pccz="http://purl.org/procurement/public-contracts-czech#"
	xmlns:pceu="http://purl.org/procurement/public-contracts-eu#">
	<!--xmlns:uuid="http://www.uuid.org" exclude-result-prefixes="fn uuid">-->
	<!--<xsl:import href="uuid.xslt" />-->
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:template match="/">
		<rdf:RDF>
			<xsl:apply-templates/>
		</rdf:RDF>
	</xsl:template>
	<xsl:template match="PRIOR_INFORMATION"/>
	<!-- CONTRACT -->
	<xsl:template match="CONTRACT">
		<rdf:Description>
		    <!--<xsl:attribute namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#" name="about">
				<xsl:text>http://ld.opendata.cz/resource/contractsfinder.businesslink.gov.uk/contract/</xsl:text>
				<xsl:value-of select="uuid:get-uuid()" />
		    </xsl:attribute>-->
		    <rdf:type rdf:resource="http://purl.org/procurement/public-contracts#Contract" />
			<xsl:apply-templates/>
		</rdf:Description>
	</xsl:template>
	<xsl:template match="FD_CONTRACT">
		<xsl:choose>
			<xsl:when test="@CTYPE = 'Services'">
				<pc:kind rdf:resource="http://purl.org/procurement/public-contracts-kinds#Services" />
			</xsl:when>
			<xsl:when test="@CTYPE = 'Works'">
				<pc:kind rdf:resource="http://purl.org/procurement/public-contracts-kinds#Works" />
			</xsl:when>
			<xsl:when test="@CTYPE = 'Supplies'">
				<pc:kind rdf:resource="http://purl.org/procurement/public-contracts-kinds#Supplies" />
			</xsl:when>
		</xsl:choose>
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="NAME_ADDRESSES_CONTACT_CONTRACT">
		<!--<xsl:variable name="authorityURL">
			<xsl:text>http://ld.opendata.cz/resource/contractsfinder.businesslink.gov.uk/business-entity/</xsl:text>
			<xsl:value-of select="uuid:get-uuid()" />
		</xsl:variable>-->
		<xsl:variable name="authorityLegalName" select="normalize-space(CA_CE_CONCESSIONAIRE_PROFILE/ORGANISATION/text())"/>
		<pc:contractingAuthority>
			<rdf:Description>
				<!--<xsl:attribute namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#" name="about">
					<xsl:value-of select="$authorityURL" />
				</xsl:attribute>-->
				<rdf:type rdf:resource="http://purl.org/goodrelations/v1#BusinessEntity" />
				<xsl:if test="$authorityLegalName">
					<gr:legalName>
						<xsl:value-of select="$authorityLegalName"/>
					</gr:legalName>
					<rdfs:label>
						<xsl:value-of select="$authorityLegalName"/>
					</rdfs:label>
					<dcterms:title>
						<xsl:value-of select="$authorityLegalName"/>
					</dcterms:title>
				</xsl:if>
				<xsl:if test="CA_CE_CONCESSIONAIRE_PROFILE/(ADDRESS|TOWN|POSTAL_CODE|COUNTRY)/text()">
					<s:address>
						<rdf:Description>
							<rdf:type rdf:resource="http://schema.org/PostalAddress" />
							<xsl:if test="CA_CE_CONCESSIONAIRE_PROFILE/ADDRESS/text()">
								<s:streetAddress>
									<xsl:value-of select="CA_CE_CONCESSIONAIRE_PROFILE/ADDRESS"/>
								</s:streetAddress>
							</xsl:if>
							<xsl:if test="CA_CE_CONCESSIONAIRE_PROFILE/TOWN/text()">
								<s:addressLocality>
									<xsl:value-of select="CA_CE_CONCESSIONAIRE_PROFILE/TOWN"/>
								</s:addressLocality>
							</xsl:if>
							<xsl:if test="CA_CE_CONCESSIONAIRE_PROFILE/POSTAL_CODE/text()">
								<s:postalCode>
									<xsl:value-of select="CA_CE_CONCESSIONAIRE_PROFILE/POSTAL_CODE"/>
								</s:postalCode>
							</xsl:if>
							<xsl:choose>
								<xsl:when test="CA_CE_CONCESSIONAIRE_PROFILE/COUNTRY/text()">
									<s:addressCountry>
										<xsl:value-of select="CA_CE_CONCESSIONAIRE_PROFILE/COUNTRY"/>
									</s:addressCountry>
								</xsl:when>
								<xsl:otherwise>
									<s:addressCountry>
										<xsl:text>GB</xsl:text>
									</s:addressCountry>
								</xsl:otherwise>
							</xsl:choose>
						</rdf:Description>
					</s:address>
				</xsl:if>
				<xsl:if test="INTERNET_ADDRESSES_CONTRACT/URL_BUYER/text()">
					<pc:buyerProfile>
						<xsl:attribute namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#" name="resource"><xsl:value-of select="INTERNET_ADDRESSES_CONTRACT/URL_BUYER"/></xsl:attribute>
					</pc:buyerProfile>
				</xsl:if>
			</rdf:Description>
		</pc:contractingAuthority>
		<xsl:variable name="fileReferenceNumber" select="../..//ADMINISTRATIVE_INFORMATION_CONTRACT_NOTICE/FILE_REFERENCE_NUMBER/text()"/>
		<xsl:if test="$fileReferenceNumber">
			<pc:referenceNumber>
				<rdf:Description>
					<rdf:type rdf:resource="http://www.w3.org/ns/adms#Identifier"/>
					<skos:notation><xsl:value-of select="$fileReferenceNumber" /></skos:notation>
					<!--<dcterms:creator>
						<xsl:attribute namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#" name="resource">
							<xsl:value-of select="$authorityURL"/>
						</xsl:attribute>
					</dcterms:creator>-->
					<adms:schemeAgency>
						<xsl:value-of select="$authorityLegalName"/>
					</adms:schemeAgency>
				</rdf:Description>
			</pc:referenceNumber>
		</xsl:if>
		<xsl:if test="CA_CE_CONCESSIONAIRE_PROFILE/(E_MAIL|PHONE|FAX|CONTACT_POINT|URL_BUYER)/text()">
			<pc:contact>
				<rdf:Description>
					<rdf:type rdf:resource="http://www.w3.org/2006/vcard/ns#VCard" />
					<xsl:if test="CA_CE_CONCESSIONAIRE_PROFILE/E_MAIL/text()">
						<vcard:email>
							<xsl:attribute namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#" name="resource">
								<xsl:text>mailto:</xsl:text>
								<xsl:value-of select="CA_CE_CONCESSIONAIRE_PROFILE/E_MAIL"/>
							</xsl:attribute>
						</vcard:email>
					</xsl:if>
					<xsl:if test="CA_CE_CONCESSIONAIRE_PROFILE/PHONE/text()">
						<vcard:tel>
							<rdf:Description>
								<rdf:type rdf:resource="http://www.w3.org/2006/vcard/ns#Work"/>
								<rdf:value>
									<xsl:value-of select="CA_CE_CONCESSIONAIRE_PROFILE/PHONE"/>
								</rdf:value>
							</rdf:Description>
						</vcard:tel>
					</xsl:if>
					<xsl:if test="CA_CE_CONCESSIONAIRE_PROFILE/FAX/text()">
						<vcard:tel>
							<rdf:Description>
								<rdf:type rdf:resource="http://www.w3.org/2006/vcard/ns#Fax"/>
								<rdf:value>
									<xsl:value-of select="CA_CE_CONCESSIONAIRE_PROFILE/FAX"/>
								</rdf:value>
							</rdf:Description>
						</vcard:tel>
					</xsl:if>
					<xsl:if test="CA_CE_CONCESSIONAIRE_PROFILE/CONTACT_POINT/text()">
						<vcard:fn>
							<xsl:value-of select="CA_CE_CONCESSIONAIRE_PROFILE/CONTACT_POINT"/>
						</vcard:fn>
					</xsl:if>
				</rdf:Description>
			</pc:contact>
		</xsl:if>
	</xsl:template>
	<xsl:template match="DESCRIPTION_CONTRACT_INFORMATION">
		<xsl:call-template name="processDescriptionContractInformation"/>
	</xsl:template>
	<xsl:template name="processDescriptionContractInformation">
		<xsl:if test="TITLE_CONTRACT/text()">
			<dcterms:title>
				<xsl:value-of select="TITLE_CONTRACT"/>
			</dcterms:title>
			<rdfs:label>
				<xsl:value-of select="TITLE_CONTRACT"/>
			</rdfs:label>
		</xsl:if>
		<xsl:if test="SHORT_CONTRACT_DESCRIPTION/text()">
			<dcterms:description>
				<xsl:value-of select="SHORT_CONTRACT_DESCRIPTION"/>
			</dcterms:description>
		</xsl:if>
		<xsl:if test="string-length(LOCATION_NUTS/SITE_OR_LOCATION/LABEL) &gt; 0 or string-length(LOCATION_NUTS/NUTS/@CODE) &gt; 0">
			<pc:location>
				<rdf:Description>
					<rdf:type rdf:resource="http://schema.org/Place" />
					<xsl:if test="string-length(LOCATION_NUTS/SITE_OR_LOCATION/LABEL/p[1]) &gt; 0">
						<rdfs:label>
							<xsl:value-of select="LOCATION_NUTS/SITE_OR_LOCATION/LABEL/p[1]" />
						</rdfs:label>
						<dcterms:title>
							<xsl:value-of select="LOCATION_NUTS/SITE_OR_LOCATION/LABEL/p[1]" />
						</dcterms:title>
					</xsl:if>
					<xsl:if test="string-length(normalize-space(substring-after(LOCATION_NUTS/SITE_OR_LOCATION/LABEL/p[2], 'Additional Information:'))) &gt; 0">
						<dcterms:description>
							<xsl:value-of select="normalize-space(substring-after(LOCATION_NUTS/SITE_OR_LOCATION/LABEL/p[2], 'Additional Information:'))" />
						</dcterms:description>
					</xsl:if>
					<xsl:if test="string-length(LOCATION_NUTS/NUTS/@CODE) &gt; 0">
						<pceu:hasParentRegion>
							<xsl:attribute namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#" name="resource">
								<xsl:text>http://ec.europa.eu/eurostat/ramon/rdfdata/nuts2008/</xsl:text>
								<xsl:value-of select="LOCATION_NUTS/NUTS/@CODE" />
							</xsl:attribute>
						</pceu:hasParentRegion>
					</xsl:if>
				</rdf:Description>
			</pc:location>
		</xsl:if>
		<xsl:if test="string-length(CPV/CPV_MAIN/CPV_CODE/@CODE) &gt; 0">
			<pc:mainObject>
				<xsl:attribute namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#" name="resource"><xsl:text>http://purl.org/weso/cpv/2008/</xsl:text><xsl:value-of select="CPV/CPV_MAIN/CPV_CODE/@CODE"/></xsl:attribute>
			</pc:mainObject>
		</xsl:if>
		<xsl:for-each select="CPV/CPV_ADDITIONAL/CPV_CODE">
			<xsl:if test="string-length(@CODE) &gt; 0">
				<pc:additionalObject>
					<xsl:attribute namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#" name="resource"><xsl:text>http://purl.org/weso/cpv/2008/</xsl:text><xsl:value-of select="@CODE"/></xsl:attribute>
				</pc:additionalObject>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<xsl:template match="NATURE_QUANTITY_SCOPE">
		<xsl:if test="COSTS_RANGE_AND_CURRENCY/RANGE_VALUE_COST/LOW_VALUE/text() or COSTS_RANGE_AND_CURRENCY/RANGE_VALUE_COST/HIGH_VALUE/text()">
			<pc:estimatedPrice>
				<rdf:Description>
					<xsl:if test="COSTS_RANGE_AND_CURRENCY/RANGE_VALUE_COST/LOW_VALUE/text()">
						<gr:hasMinCurrencyValue>
							<xsl:value-of select="COSTS_RANGE_AND_CURRENCY/RANGE_VALUE_COST/LOW_VALUE/text()"/>
						</gr:hasMinCurrencyValue>
					</xsl:if>
					<xsl:if test="COSTS_RANGE_AND_CURRENCY/RANGE_VALUE_COST/HIGH_VALUE/text()">
						<gr:hasMaxCurrencyValue>
							<xsl:value-of select="COSTS_RANGE_AND_CURRENCY/RANGE_VALUE_COST/HIGH_VALUE/text()"/>
						</gr:hasMaxCurrencyValue>
					</xsl:if>
					<xsl:if test="string-length(COSTS_RANGE_AND_CURRENCY/@CURRENCY) &gt; 0">
						<gr:hasCurrency>
							<xsl:value-of select="COSTS_RANGE_AND_CURRENCY/@CURRENCY"/>
						</gr:hasCurrency>
					</xsl:if>
					<gr:valueAddedTaxIncluded>false</gr:valueAddedTaxIncluded>
				</rdf:Description>
			</pc:estimatedPrice>
		</xsl:if>
	</xsl:template>
	<xsl:template match="PERIOD_WORK_DATE_STARTING">
		<xsl:if test="DAYS/text()">
			<pc:duration>
				<xsl:text>P</xsl:text>
				<xsl:value-of select="DAYS/text()"/>
				<xsl:text>D</xsl:text>
			</pc:duration>
		</xsl:if>
		<xsl:if test="MONTHS/text()">
			<pc:duration>
				<xsl:text>P</xsl:text>
				<xsl:value-of select="MONTHS/text()"/>
				<xsl:text>M</xsl:text>
			</pc:duration>
		</xsl:if>
		<xsl:if test="INTERVAL_DATE/START_DATE">
			<pc:startDate>
				<xsl:value-of select="INTERVAL_DATE/START_DATE/YEAR"/>
				<xsl:text>-</xsl:text>
				<xsl:value-of select="INTERVAL_DATE/START_DATE/MONTH"/>
				<xsl:text>-</xsl:text>
				<xsl:value-of select="INTERVAL_DATE/START_DATE/DAY"/>
			</pc:startDate>
		</xsl:if>
		<xsl:if test="INTERVAL_DATE/END_DATE">
			<pc:estimatedEndDate>
				<xsl:value-of select="INTERVAL_DATE/START_DATE/YEAR"/>
				<xsl:text>-</xsl:text>
				<xsl:value-of select="INTERVAL_DATE/START_DATE/MONTH"/>
				<xsl:text>-</xsl:text>
				<xsl:value-of select="INTERVAL_DATE/START_DATE/DAY"/>
			</pc:estimatedEndDate>
		</xsl:if>
	</xsl:template>
	<xsl:template match="PROCEDURE_DEFINITION_CONTRACT_NOTICE//PT_OPEN">
		<pc:procedureType rdf:resource="http://purl.org/procurement/public-contracts-procedure-types#Open"/>
	</xsl:template>
	<xsl:template match="AWARD_CRITERIA_CONTRACT_NOTICE_INFORMATION">
		<xsl:if test="AWARD_CRITERIA_DETAIL/LOWEST_PRICE">
			<pc:awardCriteriaCombination>
				<rdf:Description>
					<rdf:type rdf:resource="http://purl.org/procurement/public-contracts#AwardCriteriaCombination"/>
					<pc:awardCriterion>
						<rdf:Description>
							<rdf:type rdf:resource="http://purl.org/procurement/public-contracts#CriterionWeighting"/>
							<pc:weightedCriterion rdf:resource="http://purl.org/procurement/public-contracts-criteria#LowestPrice"/>
							<pc:criterionWeight>100</pc:criterionWeight>
						</rdf:Description>
					</pc:awardCriterion>
				</rdf:Description>
			</pc:awardCriteriaCombination>
		</xsl:if>
		<xsl:if test="AWARD_CRITERIA_DETAIL/MOST_ECONOMICALLY_ADVANTAGEOUS_TENDER/CRITERIA_STATED_BELOW">
			<pc:awardCriteriaCombination>
				<rdf:Description>
					<rdf:type rdf:resource="http://purl.org/procurement/public-contracts#AwardCriteriaCombination"/>
					<xsl:for-each select="AWARD_CRITERIA_DETAIL/MOST_ECONOMICALLY_ADVANTAGEOUS_TENDER/CRITERIA_STATED_BELOW/CRITERIA_DEFINITION">
						<pc:awardCriterion>
							<rdf:Description>
								<rdf:type rdf:resource="http://purl.org/procurement/public-contracts#CriterionWeighting"/>
								<pc:weightedCriterion>
									<rdf:Description>
										<rdf:type rdf:resource="http://www.w3.org/2004/02/skos/core#Concept"/>
										<skos:inScheme rdf:resource="http://purl.org/procurement/public-contracts-criteria#"/>
										<skos:prefLabel><xsl:value-of select="CRITERIA"/></skos:prefLabel>
										<skos:topConceptOf rdf:resource="http://purl.org/procurement/public-contracts-criteria#"/>
									</rdf:Description>
								</pc:weightedCriterion>
								<pc:criterionWeight>
									<xsl:value-of select="WEIGHTING"/>
								</pc:criterionWeight>
							</rdf:Description>
						</pc:awardCriterion>
					</xsl:for-each>
				</rdf:Description>
			</pc:awardCriteriaCombination>
		</xsl:if>
	</xsl:template>
	<xsl:template match="ADMINISTRATIVE_INFORMATION_CONTRACT_NOTICE">
		<xsl:if test="RECEIPT_LIMIT_DATE">
			<pc:tenderDeadline>
				<xsl:value-of select="RECEIPT_LIMIT_DATE/YEAR"/>
				<xsl:text>-</xsl:text>
				<xsl:value-of select="RECEIPT_LIMIT_DATE/MONTH"/>
				<xsl:text>-</xsl:text>
				<xsl:value-of select="RECEIPT_LIMIT_DATE/DAY"/>
			</pc:tenderDeadline>
		</xsl:if>
	</xsl:template>
	<xsl:template match="SYSTEM">
		<xsl:choose>
			<xsl:when test="SOURCE_SYSTEM/PUBLISHED_ON_SOURCE_DATE/YEAR/text()">
				<pc:publicationDate>
					<xsl:value-of select="SOURCE_SYSTEM/PUBLISHED_ON_SOURCE_DATE/YEAR"/>
					<xsl:text>-</xsl:text>
					<xsl:value-of select="SOURCE_SYSTEM/PUBLISHED_ON_SOURCE_DATE/MONTH"/>
					<xsl:text>-</xsl:text>
					<xsl:value-of select="SOURCE_SYSTEM/PUBLISHED_ON_SOURCE_DATE/DAY"/>
				</pc:publicationDate>
			</xsl:when>
			<xsl:when test="SYSTEM_PUBLISHED_DATE">
				<pc:publicationDate>
					<xsl:value-of select="replace(SYSTEM_PUBLISHED_DATE, '([0-9]{2})/([0-9]{2})/([0-9]{4})', '$3-$2-$1')" />
				</pc:publicationDate>
			</xsl:when>
		</xsl:choose>
		<xsl:if test=".//NOTICE_ID/text()">
			<pc:notice>
				<rdf:Description>
					<!--<xsl:attribute namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#" name="about">
						<xsl:text>http://ld.opendata.cz/resource/contractsfinder.businesslink.gov.uk/notice/</xsl:text>
						<xsl:value-of select="NOTICE_ID" />
					</xsl:attribute>-->
					<rdf:type rdf:resource="http://purl.org/procurement/public-contracts#ContractNotice" />
					<pc:identifier>
						<rdf:Description>
							<rdf:type rdf:resource="http://www.w3.org/ns/adms#Identifier"/>
							<skos:notation><xsl:value-of select="NOTICE_ID" /></skos:notation>
							<dcterms:creator>
								<xsl:attribute namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#" name="resource">
									<xsl:text>http://www.businesslink.gov.uk</xsl:text>
								</xsl:attribute>
							</dcterms:creator>
							<adms:schemeAgency>
								<xsl:text>Business Link</xsl:text>
							</adms:schemeAgency>
						</rdf:Description>
					</pc:identifier>
					<xsl:choose>
						<xsl:when test="SOURCE_SYSTEM/PUBLISHED_ON_SOURCE_DATE/YEAR/text()">
							<pc:publicationDate>
								<xsl:value-of select="SOURCE_SYSTEM/PUBLISHED_ON_SOURCE_DATE/YEAR"/>
								<xsl:text>-</xsl:text>
								<xsl:value-of select="SOURCE_SYSTEM/PUBLISHED_ON_SOURCE_DATE/MONTH"/>
								<xsl:text>-</xsl:text>
								<xsl:value-of select="SOURCE_SYSTEM/PUBLISHED_ON_SOURCE_DATE/DAY"/>
							</pc:publicationDate>
						</xsl:when>
						<xsl:when test="SYSTEM_PUBLISHED_DATE">
							<pc:publicationDate>
								<xsl:value-of select="replace(SYSTEM_PUBLISHED_DATE, '([0-9]{2})/([0-9]{2})/([0-9]{4})', '$3-$2-$1')" />
							</pc:publicationDate>
						</xsl:when>
					</xsl:choose>
					<xsl:if test="PARENT_NOTICE_ID/text()">
						<pc:previousNotice>
							<xsl:attribute namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#" name="resource">
								<xsl:text>http://ld.opendata.cz/resource/contractsfinder.businesslink.gov.uk/notice/</xsl:text>
								<xsl:value-of select="PARENT_NOTICE_ID" />
							</xsl:attribute>
						</pc:previousNotice>
					</xsl:if>
					<!--
					<xsl:if test="ROOT_NOTICE_ID/text()">
						<system:firstNoticeID>
							<xsl:value-of select="ROOT_NOTICE_ID" />
						</system:firstNoticeID>
					</xsl:if>
					-->
				</rdf:Description>
			</pc:notice>
		</xsl:if>
	</xsl:template>
	
	<!-- CONTRACT AWARD -->
	<xsl:template match="CONTRACT_AWARD">
		<rdf:Description>
			<!--<xsl:attribute namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#" name="about">
				<xsl:text>http://ld.opendata.cz/resource/contractsfinder.businesslink.gov.uk/contract/</xsl:text>
				<xsl:value-of select="uuid:get-uuid()" />
		    </xsl:attribute>-->
		    <rdf:type rdf:resource="http://purl.org/procurement/public-contracts#Contract" />
			<xsl:apply-templates mode="AWARD"/>
		</rdf:Description>
	</xsl:template>
	<xsl:template match="OBJECT_CONTRACT_INFORMATION_CONTRACT_AWARD_NOTICE" mode="AWARD">
		<xsl:apply-templates mode="AWARD"/>
	</xsl:template>
	<xsl:template match="DESCRIPTION_AWARD_NOTICE_INFORMATION" mode="AWARD">
		<xsl:call-template name="processDescriptionContractInformation"/>
		<xsl:apply-templates mode="AWARD"/>
	</xsl:template>
	<xsl:template match="PERIOD_WORK_DATE_STARTING" mode="AWARD">
		<xsl:apply-templates select="."/>
	</xsl:template>
	<xsl:template match="TOTAL_FINAL_VALUE" mode="AWARD">
		<xsl:if test="COSTS_RANGE_AND_CURRENCY_WITH_VAT_RATE/VALUE_COST/text()">
			<pc:agreedPrice>
				<rdf:Description>
					<gr:hasCurrencyValue>
						<xsl:value-of select="COSTS_RANGE_AND_CURRENCY_WITH_VAT_RATE/VALUE_COST/text()"/>
					</gr:hasCurrencyValue>
					<xsl:if test="string-length(COSTS_RANGE_AND_CURRENCY_WITH_VAT_RATE/@CURRENCY) &gt; 0">
						<gr:hasCurrency>
							<xsl:value-of select="COSTS_RANGE_AND_CURRENCY_WITH_VAT_RATE/@CURRENCY"/>
						</gr:hasCurrency>
					</xsl:if>
					<gr:valueAddedTaxIncluded>true</gr:valueAddedTaxIncluded>
				</rdf:Description>
			</pc:agreedPrice>
		</xsl:if>
	</xsl:template>
	<xsl:template match="ADMINISTRATIVE_INFORMATION_CONTRACT_AWARD" mode="AWARD">
		<xsl:if test="FILE_REFERENCE_NUMBER/text()">
			<pc:referenceNumber>
				<rdf:Description>
					<rdf:type rdf:resource="http://www.w3.org/ns/adms#Identifier"/>
					<skos:notation><xsl:value-of select="FILE_REFERENCE_NUMBER/text()" /></skos:notation>
				</rdf:Description>
			</pc:referenceNumber>
		</xsl:if>
	</xsl:template>
	<xsl:template match="AWARD_OF_CONTRACT" mode="AWARD">
		<xsl:if test="count(ITEM) &gt; 1">
			<xsl:for-each select="ITEM">
				<pc:lot>
					<rdf:Description>
						<!--<xsl:attribute namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#" name="about">
							<xsl:text>http://ld.opendata.cz/resource/contractsfinder.businesslink.gov.uk/contract/</xsl:text>
							<xsl:value-of select="uuid:get-uuid()" />
						</xsl:attribute>-->
						<rdf:type rdf:resource="http://purl.org/procurement/public-contracts#Contract" />
						<xsl:call-template name="contractAward">
							<xsl:with-param name="it" select="position()" />
							<xsl:with-param name="award" select=".." />
						</xsl:call-template>
					</rdf:Description>
				</pc:lot>
			</xsl:for-each>
		</xsl:if>
		<xsl:if test="count(ITEM) = 1">
			<xsl:call-template name="contractAward">
				<xsl:with-param name="award" select="." />
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	<xsl:template name="contractAward">
		<xsl:param name="it" select="1" />
		<xsl:param name="award" />
		<xsl:if test="$award/CONTRACT_AWARD_DATE[$it]/YEAR/text()">
			<pc:awardDate>
				<xsl:value-of select="$award/CONTRACT_AWARD_DATE[$it]/YEAR"/>
				<xsl:text>-</xsl:text>
				<xsl:value-of select="$award/CONTRACT_AWARD_DATE[$it]/MONTH"/>
				<xsl:text>-</xsl:text>
				<xsl:value-of select="$award/CONTRACT_AWARD_DATE[$it]/DAY"/>
			</pc:awardDate>
		</xsl:if>
		<xsl:if test="$award/ECONOMIC_OPERATOR_NAME_ADDRESS[$it]">
			<pc:awardedTender>
				<rdf:Description>
					<!--<xsl:attribute namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#" name="about">
						<xsl:text>http://ld.opendata.cz/resource/contractsfinder.businesslink.gov.uk/tender/</xsl:text>
						<xsl:value-of select="uuid:get-uuid()" />
					</xsl:attribute>-->
					<rdf:type rdf:resource="http://purl.org/procurement/public-contracts#Tender" />
					<xsl:if test="$award/CONTRACT_VALUE_INFORMATION[$it]/COSTS_RANGE_AND_CURRENCY_WITH_VAT_RATE/VALUE_COST/text()">
						<pc:offeredPrice>
							<rdf:Description>
								<gr:hasCurrencyValue>
									<xsl:value-of select="$award/CONTRACT_VALUE_INFORMATION[$it]/COSTS_RANGE_AND_CURRENCY_WITH_VAT_RATE/VALUE_COST/text()"/>
								</gr:hasCurrencyValue>
								<xsl:if test="string-length($award/CONTRACT_VALUE_INFORMATION[$it]/COSTS_RANGE_AND_CURRENCY_WITH_VAT_RATE/@CURRENCY) &gt; 0">
									<gr:hasCurrency>
										<xsl:value-of select="$award/CONTRACT_VALUE_INFORMATION[$it]/COSTS_RANGE_AND_CURRENCY_WITH_VAT_RATE/@CURRENCY"/>
									</gr:hasCurrency>
								</xsl:if>
								<gr:valueAddedTaxIncluded>true</gr:valueAddedTaxIncluded>
							</rdf:Description>
						</pc:offeredPrice>
					</xsl:if>
					<pc:supplier>
						<rdf:Description>
							<!--<xsl:attribute namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#" name="about">
								<xsl:text>http://ld.opendata.cz/resource/contractsfinder.businesslink.gov.uk/business-entity/</xsl:text>
								<xsl:value-of select="uuid:get-uuid()" />
							</xsl:attribute>-->
							<rdf:type rdf:resource="http://purl.org/goodrelations/v1#BusinessEntity" />
							<xsl:variable name="supplierLegalName" select="$award/ECONOMIC_OPERATOR_NAME_ADDRESS[$it]/CONTACT_DATA_WITHOUT_RESPONSIBLE_NAME/ORGANISATION/text()"/>
							<xsl:if test="$supplierLegalName">
								<gr:legalName>
									<xsl:value-of select="$supplierLegalName"/>
								</gr:legalName>
								<rdfs:label>
									<xsl:value-of select="$supplierLegalName"/>
								</rdfs:label>
								<dcterms:title>
									<xsl:value-of select="$supplierLegalName"/>
								</dcterms:title>
							</xsl:if>
							<xsl:if test="CA_CE_CONCESSIONAIRE_PROFILE/(E_MAIL|PHONE|FAX|CONTACT_POINT|URL_BUYER|ADDRESS|TOWN|POSTAL_CODE|COUNTRY)/text()">
								<s:address>
									<rdf:Description>
										<rdf:type rdf:resource="http://schema.org/PostalAddress" />
										<xsl:if test="CA_CE_CONCESSIONAIRE_PROFILE/ADDRESS/text()">
											<s:streetAddress>
												<xsl:value-of select="CA_CE_CONCESSIONAIRE_PROFILE/ADDRESS"/>
											</s:streetAddress>
										</xsl:if>
										<xsl:if test="CA_CE_CONCESSIONAIRE_PROFILE/TOWN/text()">
											<s:addressLocality>
												<xsl:value-of select="CA_CE_CONCESSIONAIRE_PROFILE/TOWN"/>
											</s:addressLocality>
										</xsl:if>
										<xsl:if test="CA_CE_CONCESSIONAIRE_PROFILE/POSTAL_CODE/text()">
											<s:postalCode>
												<xsl:value-of select="CA_CE_CONCESSIONAIRE_PROFILE/POSTAL_CODE"/>
											</s:postalCode>
										</xsl:if>
										<xsl:choose>
											<xsl:when test="CA_CE_CONCESSIONAIRE_PROFILE/COUNTRY/text()">
												<s:addressCountry>
													<xsl:value-of select="CA_CE_CONCESSIONAIRE_PROFILE/COUNTRY"/>
												</s:addressCountry>
											</xsl:when>
											<xsl:otherwise>
												<s:addressCountry>
													<xsl:text>GB</xsl:text>
												</s:addressCountry>
											</xsl:otherwise>
										</xsl:choose>
									</rdf:Description>
								</s:address>
								<s:contactPoint>
									<rdf:Description>
										<rdf:type rdf:resource="http://schema.org/ContactPoint" />
										<xsl:if test="$award/ECONOMIC_OPERATOR_NAME_ADDRESS[$it]/E_MAIL/text()">
											<s:email>
												<xsl:value-of select="$award/ECONOMIC_OPERATOR_NAME_ADDRESS[$it]/E_MAIL"/>
											</s:email>
										</xsl:if>
										<xsl:if test="$award/ECONOMIC_OPERATOR_NAME_ADDRESS[$it]/PHONE/text()">
											<s:telephone>
												<xsl:value-of select="$award/ECONOMIC_OPERATOR_NAME_ADDRESS[$it]/PHONE"/>
											</s:telephone>
										</xsl:if>
										<xsl:if test="$award/ECONOMIC_OPERATOR_NAME_ADDRESS[$it]/FAX/text()">
											<s:faxNumber>
												<xsl:value-of select="$award/ECONOMIC_OPERATOR_NAME_ADDRESS[$it]/FAX"/>
											</s:faxNumber>
										</xsl:if>
										<xsl:if test="$award/ECONOMIC_OPERATOR_NAME_ADDRESS[$it]/CONTACT_POINT/text()">
											<s:name>
												<xsl:value-of select="$award/ECONOMIC_OPERATOR_NAME_ADDRESS[$it]/CONTACT_POINT"/>
											</s:name>
										</xsl:if>
									</rdf:Description>
								</s:contactPoint>
							</xsl:if>
						</rdf:Description>
					</pc:supplier>
				</rdf:Description>
			</pc:awardedTender>
		</xsl:if>
	</xsl:template>
	<xsl:template match="SYSTEM" mode="AWARD">
		<xsl:apply-templates select="."/>
	</xsl:template>
	
	<xsl:template match="text()"/>
	<xsl:template match="text()" mode="AWARD"/>
</xsl:stylesheet>
