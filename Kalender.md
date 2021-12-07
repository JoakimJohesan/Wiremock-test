# WireMock, et godt alternativ til SoapUi?

[WireMock](http://wiremock.org/)

## Frikobling ved hjelp av mocks
De fleste Banking-Service teamene bruker SoapUi aktivt i CI/CD pipelinen hvor ett av test paradigmene er Ende-til-ende testing av APIene våre. Der forsøker vi å frikoble APIet fra alle avhengigheter for å kun teste koden vår. Frikoblingen gjøres ved å ha mock responser i stedet for ekte tredjeparter. Vi lager mocks av våre tjenester, TietoEvry sine tjenester og alle andre avhengigheter.

## SoapUi
I dag brukes som regel et SoapUi prosjekt med mapping og response oppsett. De fleste brukstilfellene er enkle stubs som returneres for ulike request parametere inn, men programmet har støtte for relativt avanserte scenario.

SoapUi har god støtte for WSDL filer som gjør det enkelt å mocke TietoEvry sine SOAP tjenester. Rest tjenester er tilsvarende lett å mocke.

SoapUi høres egentlig helt fantastisk fint ut så langt? :see_no_evil:

Men: :skull:
- Prosjektfilen som definerer oppsettet er en XML-fil som er tilnærmet umulig å lese, alle WSDL filene blir inlinet inn i prosjektfilen, så den blir tusenvis av linjer lang.
  - Code-review er umulig
  - Endring av prosjekt utenfor GUI er vanskelig
  - Prosjektet må lastes inn på nytt hver gang nye endringer kommer inn fra repository
- Script språket som brukes for å gjøre mer avansert mapping er [Groovy](https://groovy-lang.org/), i seg selv ikke et problem, men det er slitsomt å lære seg et nytt språk kun for å lage noen enkle mock-stubs.
- Brukergrensesnittet er tipp-topp anno 2006, og veldig vanskelig å bruke
  - Feilsteg i UI gjør at man må begynne om igjen med endringene fra original prosjektfil i repo
- Feilmeldinger ved mapping feil / Java feil er uforståelig
:-1:

Frykt ikke, det finnes et bedre alternativ!

## :collision: WireMock - a web service test double for all occasions! :tada:

Wiremock er en mock-server som støtter å legge opp all mocking fra eksterne filer. Alt oppsettet i kode gjør at vi har bedre kontroll i forhold til SoapUi. 

Oppsettet blir gjort med et sett av mapping filer, og et valgfritt oppsett av responser. Request og response blir definert i Mappings som inneholder Json filer som definerer oppførsel.

Oppsett av REST-mocks er selvforlarende; X inn, Y ut.
For SOAP er det mye likt, men det kan være behov for å matche litt dypere inn i XML data fra request. Da kan man bruke XPath for å matche på elementene man ønsker. XPath er et veldig nyttig spørrespråk for XML, og det er raskt å lære. 

Wiremock:
- Raskt å sette seg inn i :dash:
- Høy lesbarhet på mappings
 - Lett å utføre code-review
- Trenger kun 1 container i CI/CD pipeline - SoapUi kjører 2 stk, en for REST service, en for SOAP
 - Raskere bygg
- Ingen behov for reloading av prosjektfil
- Apache lisens som gjør det mulig for oss å bruke helt gratis

Jeg har laget en enkel POC for å vise at det er mulig å erstatte SoapUi bruken vår med WireMock: [Wiremock-test](https://github.com/JoakimJohesan/Wiremock-test)

Håpet mitt er at dere ser samme forbedringspotensial som meg, og at vi kan flytte over til WireMock! :heart:
