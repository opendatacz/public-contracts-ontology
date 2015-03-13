# Recept pro vyznačení veřejné zakázky v HTML stránce pomocí jazyka RDFa #
**Autoři:**

  * [Jakub Klímek](http://purl.org/klimek#me)
  * [Tomáš Knap](http://purl.org/knap#me)
  * [Jindřich Mynarz](http://keg.vse.cz/resource/person/jindrich-mynarz)
  * [Martin Nečaský](http://www.ksi.mff.cuni.cz/~necasky)
  * [Josef Petrák](http://keg.vse.cz/resource/person/josef-petrak)

Tento dokument názorně ukazuje, jakým způsobem lze zveřejňovat údaje o veřejné zakázce ve strojově čitelné podobě. Základem zveřejnění je klasická HTML stránka. Ta je doplněna o strojově čitelné anotace údajů vyjádřených pomocí prostředků rozšíření jazyka HTML označovaného zkratkou <a href='http://www.w3.org/TR/xhtml-rdfa-primer/'>RDFa</a>. Pro sjednocení podoby strojově čitelných údajů jsme navrhli slovník (ontologii), který popisuje jednotlivé datové položky veřejné zakázky. Ty je potřeba dodržet. Nicméně, nemají vliv na samotnou vizuální podobu HTML stránky.

Pro první seznámení s použitím slovníku pro vyznačení strojově čitelných údajů o veřejné zakázce pomocí RDFa se můžete podívat na zdrojový kód ukázkového příkladu (<a href='http://purl.org/procurement/public-contracts-example-czech'>XHTML verze</a>). Můžete příklady použít i jako šablony pro vaše řešení. Následující text slouží jako "recept", který vysvětluje technické detaily.

Protože má každá země odlišnou legislativu, skládá se ontologie veřejných zakázek z několika částí. První část je společná pro všechny země. Druhá část je modul pro konkrétní zemi. Zatím je připraven modul pro Českou republiku. Základní část i moduly jsou přístupné jak v RDF/XML tak v Turtle formátu:

<ul>
<blockquote><li>společná část (<a href='http://purl.org/procurement/public-contracts'>Turtle</a>)</li>
<li>modul pro ČR (<a href='http://purl.org/procurement/public-contracts-czech'>Turtle</a>)</li>
</ul></blockquote>

<h2>Kontrola syntaxe</h2>

Pokud vytvoříte dokument s veřejnou zakázkou dle tohoto dokumentu, můžete si její syntaktickou správnost ověřit pomocí řady volně dostupných nástrojů. Např. můžete využít <a href='http://www.w3.org/2007/08/pyRdfa/Shadow.html'>RDFa Distiller and Parser</a>.

<h2>Základní struktura dokumentu s veřejnou zakázkou</h2>

Pokud používáte formát XHTML, upravte jeho záhlaví a kořenový element <tt>html</tt> tak, aby bylo řečeno, že dokument je XHTML dokument se strojově čitelnými anotacemi:

```
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML+RDFa 1.1//EN" "http://www.w3.org/MarkUp/DTD/xhtml-rdfa-2.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="cs" lang="cs" version="XHTML+RDFa 1.1">
   ...
<html>
```

Pokud používáte formát HTML, situace je obdobná. V záhlaví uvedete, že se jedná o HTML dokument se strojově čitelnými anotacemi.

```
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01+RDFa 1.1//EN"
   "http://www.w3.org/MarkUp/DTD/html401-rdfa11-1.dtd">
<html>
   ...
</html>
```

<h2>Jmenné prostory</h2>

Kořenový element <tt>html</tt> doplňte o deklarace jmenných prostorů. Snažíme se o kompatibilitu se všemi verzemi jazyka RDFa (1.0 a 1.1). Pro kompatibilitu s verzí RDFa 1.1 je potřeba zavádět jmenné prostory pomocí atributu <tt>prefix</tt>

```
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="cs" lang="cs" version="XHTML+RDFa 1.1"
      prefix="rdf: http://www.w3.org/1999/02/22-rdf-syntax-ns#
              rdfs: http://www.w3.org/2000/01/rdf-schema#
              gr: http://purl.org/goodrelations/v1#
              dcterms: http://purl.org/dc/terms/
              pc: http://purl.org/procurement/public-contracts#
              pccz: http://purl.org/procurement/public-contracts-czech#
              cpv: http://purl.org/weso/pscs/cpv/2008/resource/
              v: http://www.w3.org/2006/vcard/ns#
              payment: http://reference.data.gov.uk/def/payment#
              br: http://purl.org/business-register#              
              xsd: http://www.w3.org/2001/XMLSchema#
              pcdt: http://purl.org/procurement/public-contracts-datatypes#">
   ...
</html>
```

Pro kompatibilitu s verzí RDFa 1.0 je potřeba zavádět jmenné prostory pomocí XML jmenných prostorů

```
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="cs" lang="cs" version="XHTML+RDFa 1.1"
      xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
      xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
      xmlns:gr="http://purl.org/goodrelations/v1#"
      xmlns:dcterms="http://purl.org/dc/terms/"
      xmlns:pc="http://purl.org/procurement/public-contracts#"
      xmlns:pccz="http://purl.org/procurement/public-contracts-czech#"
      xmlns:cpv="http://purl.org/weso/pscs/cpv/2008/resource/"
      xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
      xmlns:v="http://www.w3.org/2006/vcard/ns#"
      xmlns:payment="http://reference.data.gov.uk/def/payment#"
      xmlns:br="http://purl.org/business-register#"
      xmlns:pcdt="http://purl.org/procurement/public-contracts-datatypes#">
   ...
</html>
```

Pro kompatibilitu s oběma verzemi použijte oba způsoby najednou.

<div>
<blockquote><span>Proč je použito tolik jmenných prostorů?</span>
<span>Slovník maximálně využívá části jiných, již hotových a široce používaných slovníků. To zajistí interoperabilitu dat o veřejných zakázkách s jinými daty vytvořenými dle těchto slovníků.</span>
</div></blockquote>

<h2>Určení místa na webové stránce, kde je veřejná zakázka popsána</h2>

Informace o veřejné zakázce uzavřete ve vašem HTML kódu do jednoho elementu, např. <tt>div</tt>, <tt>span</tt>, apod. Potom určete, že obsah tohoto elementu se týká veřejné zakázky pomocí RDFa atributu <tt>typeof</tt> s hodnotou <tt>pc:Contract</tt>. Jinými slovy tím říkáte, že obsah reprezentuje instanci třídy <tt>Contract</tt> ze jmenného prostoru s prefixem <tt>pc</tt> (tj. ze jmenného prostoru slovníku veřejných zakázek).

```
<div typeof="pc:Contract">
  ...
</div>
```

Výše uvedeným dále říkáte, že samotná veřejná zakázka je anonymní, tj. nemá žádný identifikátor. V RDFa je možné instance nepovinně identifikovat pomocí URI. Identifikační URI vám např. umožní se na veřejnou zakázku odkazovat z jiného místa na webu, kde máte umístěny nějaké další údaje o zakázce. Toto URI může být např. fyzickým URL, na kterém je umístěna HTML stránka s veřejnou zakázkou. Je důležité ale zajistit, že zvolené identifikační URI se pro danou veřejnou zakázku již nikdy nezmění.

```
<div about="http://www.mesto.cz/VZ/12345678" typeof="pc:Contract">
  ...
</div>
```

Výše uvedeným říkáte, že veřejná zakázka není anonymní. Je identifikována pomocí URL <tt><a href='http://www.mesto.cz/VZ/12345678'>http://www.mesto.cz/VZ/12345678</a></tt>.

<h2>Údaje při zveřejnění veřejné zakázky</h2>

Pro každou veřejnou zakázku uvádějte její název. Pro názvy je v našem slovníku určena RDF vlastnost <tt>dcterms:title</tt>. Název umístěte do samostatného HTML elementu, např. <tt>span</tt>. Pomocí jeho RDFa atributu <tt>property</tt> s hodnotou <tt>dcterms:title</tt> řeknete, že obsah elementu je názvem veřejné zakázky.

```
<div about="http://www.mesto.cz/VZ/12345678" typeof="pc:Contract">
   Název: <span property="dcterms:title">Jezdecké potřeby městské policie</span>
</div>
```

<h3>Údaje o zadavateli</h3>

Připojte informace o zadavateli veřejné zakázky pomocí vlastnosti <tt>pc:contractingAuthority</tt>. Zadavatele uvádějte jako anonymní instanci třídy <tt>gr:BusinessEntity</tt>, tj. v samostatném elementu s RDFa atributem <tt>typeof</tt> s hodnotou <tt>gr:BusinessEntity</tt>.

```
<div about="http://www.mesto.cz/VZ/12345678" typeof="pc:Contract">
  ...
  <span rel="pc:contractingAuthority" typeof="gr:BusinessEntity">
  Zadavatel:
      ...                 	
  </span>
```

Doplňte jméno (RDF vlastnost <tt>gr:legalName</tt>), IČ (RDF vlastnost <tt>br:officialNumber</tt>) a odkaz na web (RDF vlastnost <tt>pc:buyerProfile</tt>) zadavatele. Tentokrát však nemá element s odkazem na web zadavatele RDFa atribut <tt>property</tt> ale RDFa atribut <tt>rel</tt> s hodnotou <tt>pc:buyerProfile</tt>. Tím říkáme, že hodnotou vlastnosti není jednoduchá datová hodnota ale zdroj, jehož URL je u elementu <tt>a</tt> v atributu <tt>href</tt>. Jelikož je IČ reprezentováno jako řetězec, je třeba explicitně uvést že není v žádném specifickém jazyce pomocí atribudu <tt>lang</tt> s prázdnou hodnotou.

```
<div about="http://www.mesto.cz/VZ/12345678" typeof="pc:Contract">
  ...
  <span rel="pc:contractingAuthority" typeof="gr:BusinessEntity">
  Zadavatel:
      ...                 	
      <span property="gr:legalName">Město Ukázkové</span>,
      IČ <span property="br:officialNumber" lang="">987654321</span>,
      WWW: <a rel="pc:buyerProfile" href="http://www.mesto.cz">stránka kupujícího</a>
  </span>
```

<h4>Hlavní kontakt</h4>

Pro udání hlavního kontaktu pro tuto zakázku používáme slovník <a href='http://www.w3.org/Submission/vcard-rdf/'>VCard</a>. Vytvoříme tedy anonymní instanci třídy <tt>v:VCard</tt> která bude reprezentovat "vizitku" a přiřadíme ji zakázce pomocí atributu <tt>rel</tt> s hodnotou<tt>pc:contact</tt>. Vizitka má například vlastnosti <tt>v:fn</tt> pro jméno kontaktu, <tt>v:adr</tt> pro adresu, <tt>v:tel</tt> pro telefon a <tt>v:email</tt> pro email kontaktu. Pro adresu a telefon ale musíme vytvořit další anonymní instance tříd <tt>v:Address</tt> a <tt>v:Tel</tt> kterým dále nastavíme jednotlivé položky dle příkladu. Všimněte si strojově čitelné reprezentace telefonního čísla pomocí URL schematu <tt>tel:+420123456789</tt>. Tuto reprezentaci telefonního čísla vyžaduje slovník FOAF který také používáme.
```
<div about="http://www.mesto.cz/VZ/12345678" typeof="pc:Contract">
  ...
  <div rel="pc:contact" typeof="v:VCard">
     <span property="v:fn">Jan Novák</span>
     <div rel="v:adr" typeof="v:Address">
        <span property="v:street-address">Václavské Náměstí 1</span> 
        <br/><span property="v:postal-code">110 00</span> 
        <span property="v:locality">Praha 1</span>
        <br/><span property="v:country-name">Česká republika</span>
     </div>
     <br/>Telefon: 
     <span rel="v:tel" typeof="v:Tel">
      <a rel="rdf:value" href="tel:+420212345678">+420212345678</a>
     </span>
     <br/>Email: <a rel="v:email" href="mailto:novak@priklad.cz">novak@priklad.cz</a>
  </div>
```

<h3>Procesní údaje</h3>

Mezi procesní údaje o zakázce patří například spisové číslo zakázky <tt>pc:referenceNumber</tt>. Jelikož je ale reprezentováno jako řetězec, je třeba explicitně uvést že není v žádném specifickém jazyce pomocí atribudu <tt>lang</tt> s prázdnou hodnotou.
```
<div about="http://www.mesto.cz/VZ/12345678" typeof="pc:Contract">
  ...
  Spisové číslo zakázky: <span property="pc:referenceNumber" lang="">1234567890</span>
```

Pro nastavení dalších vlastností budeme pro přehlednost odkazovat na zkrácené URL zdroje pomocí tzv. <a href='http://www.w3.org/TR/curie/'>SafeCURIE</a>. Je to hodnota atributu <tt>resource</tt> uzavřená v hranatých závorkách [.md](.md). Jedná se o vlastnosti <tt>pc:kind</tt> a <tt>pc:procedureType</tt> pro určení druhu zakázky a druhu řízení zakázky. V našem příkladě je druhem zakázky <tt>pc:Supplies</tt> reprezendující "dodávky" a druhem řízení je <tt>pc:Open</tt> reprezentující otevřené řízení.
```
<div about="http://www.mesto.cz/VZ/12345678" typeof="pc:Contract">
  ...
  <br/>Druh zakázky: <span rel="pc:kind" resource="[pc:Supplies]">Dodávky</span>
  <br/>Druh řízení zakázky: <span rel="pc:procedureType" resource="[pc:Open]">Otevřené</span>
```
> <ul>
<blockquote><li><tt>pc:kind</tt> může mít jako hodnotu jeden z následujících zdrojů:<br>
<blockquote><ul>
<blockquote><li><tt>pc:Supplies</tt> - Dodávky</li>
<li><tt>pc:Works</tt> - Stavební práce</li>
<li><tt>pc:Services</tt> - Služby</li>
</blockquote></ul>
</blockquote></li>
<li><tt>pc:procedureType</tt> může mít jako hodnotu jeden z následujících zdrojů:<br>
<blockquote><ul>
<blockquote><li><tt>pc:Open</tt> - Otevřené řízení</li>
<li><tt>pc:Restricted</tt> - Užší řízení</li>
<li><tt>pc:AcceleratedRestricted</tt> - Urychlené užší řízení</li>
<li><tt>pc:Negotiated</tt> - Řízení jednací</li>
<li><tt>pc:AcceleratedNegotiated</tt> - Urychlené jednací řízení</li>
<li><tt>pc:CompetitiveDialogue</tt> - Soutěžní dialog</li>
</blockquote></ul>
</blockquote></li>
</ul></blockquote>

Dále reprezentujeme kritéria pro zadání zakázky jako vlastnost <tt>pc:awardCriteriaCombination</tt>. Máme dvě možnosti. Buďto bude hodnotou vlastnosti <tt>[pc:AwardCriteriaLowestPrice]</tt> pro nejnižší cenu jakožto jediné kritérium a nebo vytvoříme anonymní instanci třídy <tt>pc:AwardCriteriaCombination</tt> jako v našem příkladu. Této třídě pak přiřazujeme jednotlivá kritéria vlastností<tt>pc:awardCriterion</tt>, které jako hodnotu přiřazujeme anonymní instance třídy <tt>pc:AwardCriterion</tt>. Těmto instancím již přiřazujeme název kritéria vlastností <tt>pc:criterionName</tt> a jeho váhu v procentech v rozmezí 0 až 100 vlastností <tt>pc:criterionWeight</tt>. Zde je třeba specifikovat tento datový typ pomocí atributu <tt>datatype</tt> s hodnotou <tt>pcdt:percentage</tt>.
```
<div about="http://www.mesto.cz/VZ/12345678" typeof="pc:Contract">
  ...
  
  <br/>Kritéria pro zadání zakázky: 
    <span rel="pc:awardCriteriaCombination" typeof="pc:AwardCriteriaCombination">
    Ekonomicky nejvýhodnější nabídka.
    <br/>Kritéria pro zadání zakázky:
    <span rel="pc:awardCriterion" typeof="pc:AwardCriterion">
      <span property="pc:criterionName">Délka biče</span>
      (Váha: <span property="pc:criterionWeight" datatype="pcdt:percentage">20</span>%)</span>,
    <span rel="pc:awardCriterion" typeof="pc:AwardCriterion">
      <span property="pc:criterionName">Pohodlnost sedla</span>
      (Váha: <span property="pc:criterionWeight" datatype="pcdt:percentage">80</span>%)</span>
    </span>
```


Dále můžete zveřejnit specifický údaj o veřejné zakázce dané českou legislativou. Tím myslíme limit zakázky (vlastnost <tt>pccz:limit</tt>). Tato vlastnost není součástí základního slovníku, ale modulu pro ČR, o kterém jsme se zmiňovali na začátku. Jejími hodnotami jsou opět zdroje reprezentující jednotlivé typy limitů.

```
<div about="http://www.mesto.cz/VZ/12345678" typeof="pc:Contract">
   ...
  Limit: <span rel="pccz:limit" resource="[pccz:UnderLimit]">Podlimitní</span>
```

Konkrétně slovník nabízí tyto možné hodnoty:

<ul>
<blockquote><li><tt>pccz:limit</tt> může mít jako hodnotu jeden z následujících zdrojů:<br>
<blockquote><ul>
<blockquote><li><tt>pccz:SmallAmount</tt> - Zakázka malého rozsahu</li>
<li><tt>pccz:UnderLimit</tt> - Podlimitní zakázka</li>
<li><tt>pccz:AboveLimit</tt> - Nadlimitní zakázka</li>
</blockquote></ul>
</blockquote></li>
</ul></blockquote>

<h3>Předmět zakázky</h3>

Dalším údajem je předmět veřejné zakázky ve formě CPV kódu. Pro vyhledávání CPV kódů v rámci svého softwarového řešení můžete použít jednoduchý <a href='http://opendata.cz/vocabulary/cpv/2008'>nástroj</a>. Předmětů může mít veřejná zakázka více. V našem slovníku jsou pro ně určeny RDF vlastnosti <tt>pc:mainObject</tt> pro hlavní předmět a <tt>pc:additionalObject</tt> pro další předměty. Oproti předchozím údajům ale nejsou CPV kódy jednoduché (atomické) datové hodnoty, ale samostatné entity identifikované vlastním URL.

```
<div about="http://www.mesto.cz/VZ/12345678" typeof="pc:Contract">
   ...
  <br/>Hlavní předmět zakázky: <span rel="pc:mainObject" resource="[cpv:18911000]">sedla</span>
  <br/>Další předmět zakázky: <span rel="pc:additionalObject" resource="[cpv:18913000]">biče</span>      
```
Dále vyplňte textový detailnější popis zakázky pomocí vlastnosti <tt>dcterms:description</tt>.
```
<div about="http://www.mesto.cz/VZ/12345678" typeof="pc:Contract">
   ...
  Popis: <span property="dcterms:description">Detailní slovní popis zakázky.</span>      
```

Druhý způsob jak lze reprezentovat předmět zakázky v případě produktů je pomocí slovníku <a href='http://www.productontology.org/'>The Product Types Ontology</a>. Protože už jsme ale uživateli předmět zobrazili při anotaci CPV kódy, použijeme pro anotaci tímto slovníkem prázdné elementy obsahující pouze příslušné RDFa atributy tvořící RDF trojice. Tvoříme tedy anonymní instance tříd ze slovníku reprezentujících daný produkt. Ty přiřazujeme pomocí vlastnosti <tt>pc:item</tt> veřejné zakázce. K třídám produktu můžeme dále připojovat další vlastnosti, jako například český název pomocí vlastnosti <tt>rdfs:label</tt>.

```
<div about="http://www.mesto.cz/VZ/12345678" typeof="pc:Contract">
   ...
  <span rel="pc:item" typeof="http://www.productontology.org/id/Saddle">
    <span property="rdfs:label" content="Sedlo"/>
  </span>
  <span rel="pc:item" typeof="http://www.productontology.org/id/Whip">
    <span property="rdfs:label" content="Bič"/>
  </span>
```

<h3>Cena</h3>

Dále vyplňte údaje o ceně zakázky. Na výběr jsou dvě možnosti. Buď je uvedena přesná odhadovaná cena pomocí vlastnosti <tt>pc:estimatedPrice</tt>, nebo je uveden její spodní a horní odhad pomocí vlastností <tt>pc:estimatedPriceLower</tt> a <tt>pc:estimatedPriceUpper</tt>. Hodnotou těchto vlastností je anonymní instance třídy <tt>gr:PriceSpecification</tt> a její vlastnosti <tt>gr:hasCurrencyValue</tt> udávající částku, <tt>gr:hasCurrency</tt> udávající měnu a <tt>gr:valueAdedTaxIncluded</tt> udávající zda je do ceny započítána DPH. Tato hodnota má datový typ <tt>xsd:boolean</tt>. Jelikož kódy měn jsou řetězec, je třeba explicitně uvést že nejsou v žádném specifickém jazyce pomocí atribudu <tt>lang</tt> s prázdnou hodnotou.
```
<div about="http://www.mesto.cz/VZ/12345678" typeof="pc:Contract">
   ...
  <div rel="pc:estimatedPrice" typeof="gr:PriceSpecification">
    Přesná odhadovaná cena:
    <span property="gr:hasCurrencyValue" content="1000000.0" datatype="xsd:float">1.000.000</span>
    <span property="gr:hasCurrency" content="CZK" lang="">Kč</span>
    (<span property="gr:valueAddedTaxIncluded" content="false" datatype="xsd:boolean">bez daně</span>)            		
  </div>
```
Nebo:
```
<div about="http://www.mesto.cz/VZ/12345678" typeof="pc:Contract">
   ...
  <div rel="pc:estimatedPriceLower" typeof="gr:PriceSpecification">
    Počáteční rozsah odhadované ceny:
    <span property="gr:hasCurrencyValue" content="500000.0" datatype="xsd:float">500.000</span>
    <span property="gr:hasCurrency" content="CZK" lang="">Kč</span>
    (<span property="gr:valueAddedTaxIncluded" content="false" datatype="xsd:boolean">bez daně</span>)            		
  </div>
  
  <div rel="pc:estimatedPriceUpper" typeof="gr:PriceSpecification">
    Koncový rozsah odhadované ceny:
    <span property="gr:hasCurrencyValue" content="2000000.0" datatype="xsd:float">2.000.000</span>
    <span property="gr:hasCurrency" content="CZK" lang="">Kč</span>
    (<span property="gr:valueAddedTaxIncluded" content="false" datatype="xsd:boolean">bez daně</span>)            		
  </div>    
```

<h3>Lhůty a data</h3>

Dále uvádějte datum zveřejnění zakázky, lhůtu pro posílání nabídek nebo žádostí o účast, datum začátku realizace zakázky a očekávané datum konce realizace zakázky. Pro ně jsou v našem slovníku určeny RDF vlastnosti <tt>pc:publicationDate</tt>, <tt>pc:tenderDeadline</tt>, <tt>pc:startDate</tt> a <tt>pc:estimatedEndDate</tt>. Uveďte každé datum v samostatném HTML elementu, např. <tt>span</tt>, který opatřete RDFa atributem <tt>property</tt> s patřičnou hodnotou. Je zde ale jeden podstatný rozdíl oproti minulým použitím atributu <tt>property</tt>. Na webové stránce chcete návštěvníkům zobrazit datum ve formátu běžném v ČR, např. <tt>1. 2. 2010</tt> nebo <tt>1. února 2010</tt>. To ale není strojově čitelné datum. Pro strojově čitelnou podobu datumů používáme datový typ <tt>xsd:date</tt> jazyka XML Schema, např. <tt>2010-02-01</tt> (RRRR-MM-DD). Strojově čitelnou hodnotu ale pravděpodobně nechcete ukazovat svým návštěvníkům. Proto ji dávejte jako hodnotu RDFa atributu <tt>content</tt>. Také přidejte informaci o datovém typu pomocí atributu <tt>datatype</tt>.

```
<div about="http://www.mesto.cz/VZ/12345678" typeof="pc:Contract">
   ...
  Datum zveřejnění zakázky: 
  <span property="pc:publicationDate" content="2010-01-01" datatype="xsd:date">1.1.2010</span>
  
  <br/>Lhůta pro doručení nabídek nebo přijetí žádostí o účast: 
  <span property="pc:tenderDeadline" content="2010-01-01" datatype="xsd:date">1.1.2010</span>
  
  <br/>Datum začátku realizace zakázky: 
  <span property="pc:startDate" content="2010-01-01" datatype="xsd:date">1. 1. 2010</span>
  
  <br/>Očekávané datum konce realizace zakázky: 
  <span property="pc:estimatedEndDate" content="2010-01-01" datatype="xsd:date">1. 1. 2010</span>
```
Dále také specifikujte dobu trvání zakázky ve dnech pomocí vlastnosti <tt>pc:durationDays</tt> která má datový typ <tt>xsd:positiveInteger</tt>.
```
<div about="http://www.mesto.cz/VZ/12345678" typeof="pc:Contract">
   ...
  <br/>Doba trvání zakázky ve dnech: 
  <span property="pc:durationDays" datatype="xsd:positiveInteger">31</span>
```

<h3>Ostatní</h3>

Mezi další informace patří dělení na podzakázky. To lze vyjádřit jako odkaz na ně pomocí standardního HTML elementu <tt>a</tt>, kterému přidáme atribut <tt>rel</tt> s hodnotou <tt>pc:lot</tt>. Dále lze ještě odkázat na přílohy (například dokument se smlouvou, zadávací dokumentace, ...) opět pomocí hodnoty <tt>pc:attachment</tt> atributu <tt>rel</tt> elementu <tt>a</tt> s odkazem na přílohu.
```
<div about="http://www.mesto.cz/VZ/12345678" typeof="pc:Contract">
   ...
  Podzakázky: <a rel="pc:lot" href="http://www.mesto.cz/VZ/12345678.html">Podzakázka 1</a>,
  <a rel="pc:lot" href="http://www.mesto.cz/VZ/12345678.html">Podzakázka 2</a>
  <br/><a rel="pc:attachment" href="http://www.mesto.cz/prilohy/1">Příloha 1</a>
```


Vždy můžete specifikovat, že daná zakázka byla zrušena užitím vlastnosti <tt>pc:cancellationDate</tt> elementu <tt>div</tt> nebo <tt>span</tt> s požadovaným datem, ke kterému je zakázka zrušená.

```
<div about="http://www.mesto.cz/VZ/12345678" typeof="pc:Contract">
   ...
<span property="pc:cancellationDate" content="2010-01-01" datatype="xsd:date">1. 1. 2010</span>
   ...
</div>
```

<h2>Údaje při zadání veřejné zakázky</h2>

Po zadání veřejné zakázky můžete zveřejnit další údaje. První informací je počet obdržených nabídek, k čemuž použijte RDF vlastnost <tt>pc:numberOfTenders</tt>. Hodnota je datového typu <tt>xsd:nonNegativeInteger</tt>, který značí přirozená čísla a nulu. Proto ještě přidáváme RDFa atribut <tt>datatype</tt> s příslušnou hodnotou.

```
<div about="http://www.mesto.cz/VZ/12345678" typeof="pc:Contract">
   ...
  <h2>Obdržené nabídky: <span property="pc:numberOfTenders" datatype="xsd:nonNegativeInteger">2</span></h2>      
```

Slovník umožňuje také zveřejnit jednotlivé nabídky jako instance třídy <tt>pc:Tender</tt>. Nabídku přiřadíte k veřejné zakázce pomocí vlastnosti <tt>pc:tender</tt>. Nabídek můžete přiřadit několik.

```
<div about="http://www.mesto.cz/VZ/12345678" typeof="pc:Contract">
  ...
  Nabídky:
  <div rel="pc:tender" typeof="pc:Tender">
      ...
  </div>
  <div rel="pc:tender" typeof="pc:Tender">
      ...
  </div>
</div>
```

Ke každé nabídce přidejte společnost, která zaslala nabídku, pomocí vlastnosti <tt>pc:supplier</tt>. Společnost uvádějte jako anonymní instanci třídy <tt>gr:BusinessEntity</tt>, tj. v samostatném elementu s RDFa atributem <tt>typeof</tt> s hodnotou <tt>gr:BusinessEntity</tt>. Doplňte data o nabízejícím - jeho název (RDF vlastnost <tt>gr:legalName</tt>) a IČ (RDF vlastnost <tt>br:officialNumber</tt>). Kromě nabízejícího uvádějte k nabídce také nabídnutou cenu pomocí vlastnosti <tt>pc:offeredPrice</tt>. Cenu uvádějte stejně jako výše. Tedy jako anonymní instanci třídy <tt>gr:PriceSpecification</tt>, tj. v samostatném elementu s RDFa atributem <tt>typeof</tt> s hodnotou <tt>gr:PriceSpecification</tt>. K ceně doplňte hodnotu (RDF vlastnost <tt>gr:hasCurrencyValue</tt>), měnu (RDF vlastnost <tt>gr:hasCurrency</tt>) a zda je cena s DPH (RDF vlastnost <tt>gr:valueAddedTaxIncluded</tt>).

```
<div about="http://www.mesto.cz/VZ/12345678" typeof="pc:Contract">
   ...
  <div rel="pc:tender" typeof="pc:Tender">
    <span rel="pc:supplier" typeof="gr:BusinessEntity">
      Nabízející:
      <span property="gr:legalName">Druhá pojízdná a.s.</span>, IČ
      <span property="br:officialNumber" lang="">24681012</span>
    </span>
    <span rel="pc:offeredPrice" typeof="gr:PriceSpecification">
      Nabídnutá cena:
      <span property="gr:hasCurrencyValue" content="550000.0" datatype="xsd:float">55.000</span>
      <span property="gr:hasCurrency" content="EUR" lang="">€</span>
      <span property="gr:valueAddedTaxIncluded" content="false" datatype="xsd:boolean">bez daně</span>      
    </span>

</div>
```

Vítěznou nabídku nepřiřazujte k veřejné zakázce pomocí RDF vlastnosti <tt>pc:tender</tt> ale pomocí vlastnosti <tt>pc:awardedTender</tt>. Samotnou vítěznou nabídku popište stejně jako ostatní nabídky, tj. jako instance třídy <tt>pc:Tender</tt>.

```
<div about="http://www.mesto.cz/VZ/12345678" typeof="pc:Contract">
  ...
  Vítězná nabídka:
  <div rel="pc:awardedTender" typeof="pc:Tender">
      ...
  </div>
```

Cenu za zakázku dohodnutou s vítězným dodavatelem na smlouvě můžete uvést pomocí vlastnosti <tt>pc:pc:agreedPrice</tt> (opět jako instanci třídy <tt>gr:PriceSpecification</tt>). Datum přidělení zakázky uveďte jako vlastnost <tt>pc:awardDate</tt>.

```
<div about="http://www.mesto.cz/VZ/12345678" typeof="pc:Contract">
  ...
  Datum přidělení zakázky:
  <span property="pc:awardDate" content="2010-01-01" datatype="xsd:date">1.1.2010</span>
  
  <div rel="pc:agreedPrice" typeof="gr:PriceSpecification">
    Smluvní cena:
    <span property="gr:hasCurrencyValue" content="150000.0" datatype="xsd:float">150.000</span>
    <span property="gr:hasCurrency" content="CZK" lang="">Kč</span>           		
    (<span property="gr:valueAddedTaxIncluded" content="false" datatype="xsd:boolean">bez daně</span>)
  </div>
```

<h2>Údaje při dokončení realizace veřejné zakázky</h2>

Po dokončení zakázky zadejte ještě údaje o skutečně zaplacené ceně a skutečném datu dokončení zakázky ve stejném formátu jako výše uvedené údaje o cenách a datech.
```
<div about="http://www.mesto.cz/VZ/12345678" typeof="pc:Contract">
  ...
  Skutečné datum konce realizace zakázky: 
  <span property="pc:actualEndDate" content="2010-01-01" datatype="xsd:date">1. 1. 2010</span>

  <div rel="pc:actualPrice" typeof="gr:PriceSpecification">
    Skutečná cena po realizaci zakázky:
    <span property="gr:hasCurrencyValue" content="150000.0" datatype="xsd:float">150.000</span>
    <span property="gr:hasCurrency" content="CZK" lang="">Kč</span>           		
    (<span property="gr:valueAddedTaxIncluded" content="false" datatype="xsd:boolean">bez daně</span>)            		
  </div>
```

Dále také uvěďte případnou dotaci (částku z celkové konečné ceny zakázky, která byla pokryta nějakou dotací) použitou pro zakázku. Protože ale u dotace nemá sémantiku ceny, používáme pro ni slovník pro platby <a href='http://data.gov.uk/resources/payments'>Payments Ontology</a>. Použijeme tedy vlastnost <tt>pc:subsidy</tt> a její hodnotu, anonymní instanci třídy <tt>payment:Payment</tt>. K této třídě připojíme pomocí vlastnosti <tt>payment:expenditureLine</tt> další anonymní instanci třídy, tentokrát <tt>payment:ExpenditureLine</tt>. Té už pomocí vlastnosti <tt>payment:netAmount</tt> nastavíme částku dotace, její strojově čitelnou podobu pomocí atributu <tt>content</tt> a správný datový typ <tt>xsd:decimal</tt>. Nakonec uvedeme pomocí vlastnosti <tt>payment:currency</tt> uvedeme měnu ve které je částka dotace uvedena. Hodnotou této vlastnosti ale není jednoduchá hodnota, nýbrž zdroj reprezentující měnu. Takovým zdrojem může být reprezentace na <a href='http://dbpedia.org'>DBpedia</a> tak jako v příkladě.
```
<div about="http://www.mesto.cz/VZ/12345678" typeof="pc:Contract">
  ...
  <div rel="pc:subsidy" typeof="payment:Payment">
    Dotace použitá pro zakázku:
    <span rel="payment:expenditureLine" typeof="payment:ExpenditureLine">
      <span property="payment:netAmount" content="2000000" datatype="xsd:decimal">2.000.000</span>
      <span rel="payment:currency" resource="http://dbpedia.org/resource/Czech_koruna">Kč</span>
    </span>            		
  </div>
```