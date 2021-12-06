# Wiremock-test

## Forkunnskaper

- Du bør kjenne litt til docker, kjøre en docker deamon på maskinen din. [Linux](https://docs.docker.com/engine/install/ubuntu/) - [Mac/Windows Docker Desktop](https://www.docker.com/products/docker-desktop)
- Postman installert

## Hva gjør Dockerfile

Den henter det offisielle [wiremock imaget](https://hub.docker.com/r/wiremock/wiremock) med [Alpine-distro](https://alpinelinux.org/). Den kopierer over `./stubs` mappen og undermappene til riktig destinasjon i docker-imaget.


```
1: Bygg dockerfile

docker build . -t wiremock-test --file ./Dockerfile

2: Kjør docker-image

docker run -p 8080:8080 wiremock-test
```

## Postman collection

 - Importer denne i Postman
 - Kjør `docker` kommandoene listet over for å bygge å kjøre docker imaget
 - Test ut Postman requestene

 ## Hvordan funker det

 Wiremock docker imaget vårt inneholder alle filene vi har i `stubs` mappen. 

`mappings` inneholder logikken for hva som skal ses på i request, og hva som skal mappes ut i response.

`__files` inneholder response filene våre, man kan ha responsen i mappings filen, men det er mer ryddig å ha de i separate filer.

## SOAP matching
Det brukes XPath for å gjøre litt lur XML matching slik at vi kan ha flere svar for samme endepunkt. Dette kan for eksempel brukes til å mocke ulike kunder sine mock-data.

# Nyttige linker
[Xpath tutorial - W3](https://www.w3schools.com/xml/xpath_intro.asp)

[Wiremock - stubbing](http://wiremock.org/docs/stubbing/)

[Wiremock - request matching](http://wiremock.org/docs/request-matching/)