/* 
1) Calcolare l'insieme (non il multi-insieme) delle coppie (A,B) tali che A è uno scalatore e B è un continente in cui A ha
effettuato una scalata.*/
SELECT distinct scalata.scalatore, nazione.continente 
FROM scalata join nazione on scalata.nazione=nazione.nome


/* 
2)Per ogni scalatore nato prima del 1980, calcolare tutti i continenti in cui ha effettuato una scalata,
ordinando il risultato per codice fiscale e, a parità di codice fiscale, per il nome del continente.*/
SELECT distinct  scalatore.cf,nazione.continente, count(scalata.nazione) as totContinente
FROM scalata join scalatore on scalatore.cf=scalata.scalatore join  nazione on scalata.nazione=nazione.nome
WHERE scalatore.annoNascita<1980 
group by scalatore.cf
order by scalatore.cf

/*
3)Calcolare le nazioni (mostrando, per ciascuna, anche il continente) nelle quali è stata effettuata almeno una scalata
da uno scalatore minorenne.*/
select distinct nazione.nome,nazione.continente
from scalatore join scalata on scalatore.cf=scalata.scalatore 
        join nazione on scalata.nazione=nazione.nome
where scalata.anno - scalatore.annoNascita<18

/*
4) Per ogni nazione, calcolare il numero di scalate effettuate da
scalatori nati in quella nazione.*/
SELECT scalata.nazione, count(scalatore.nazionenascita) as TotScalate
FROM scalatore join scalata on scalatore.cf=scalata.scalatore
group by scalata.scalatore
order by totScalate desc


/*
5) Per ogni continente, calcolare il numero di scalate effettuate
da scalatori nati in una nazione di quel continente*/
SELECT   n1.continente, count( distinct scalatore.cf)
FROM scalatore join nazione n1 on scalatore.nazionenascita=n1.nome join scalata s1 on s1.scalatore=scalatore.cf
join nazione n2 on s1.nazione=n2.nome
where n1.continente=n2.continente
group by n1.continente


/*
6) Calcolare codice fiscale, nazione di nascita, continente di
nascita di ogni scalatore nato in un continente diverso
dall’America, e, solo se egli ha effettuato almeno una scalata,
affiancare queste informazioni alle nazioni in cui ha effettuato
scalate.*/
                            /*ESERCIZIO DA FINIRE*/
SELECT distinct scalatore.cf, scalatore.nazioneNascita, nazione.continente
FROM scalatore join scalata on scalatore.cf=scalata.scalatore join nazione on nazione.nome=scalata.nazione 
WHERE nazione.continente!="America"


/*7)
Per ogni nazione e per ogni anno, calcolare il numero di
scalate effettuate in quella nazione e in quell’anno, ma solo se
tale numero è maggiore di 1. Nel risultato le nazioni dello
stesso continente devono essere mostrati in tuple contigue, e
le tuple relative allo stesso continente devono essere ordinate
per anno.*/



/*8)
Per ogni nazione N, calcolare il numero medio di
scalate effettuate all’anno in N da scalatori nati in
nazioni diverse da N.*/




/*9)
Calcolare gli scalatori tali che tutte le scalate che
hanno effettuato nella nazione di nascita le hanno
effettuate quando erano minorenni.*/

                /*SCALATORI MINORENNI 0*/
SELECT *
FROM scalatore join scalata on scalatore.cf=scalata.scalatore join nazione on scalata.nazione=nazione.nome
WHERE nazioneNascita=scalata.nazione and anno-annoNascita<18

                /*PROVA CON SCALATORI CHE HANNO MENO DI 40 ANNI*/
select  scalatore,nazionenascita,nazione,scalatore.annoNascita, scalata.anno,count(scalatore) as scalateStessoPaese
FROM scalatore join scalata on  scalatore.cf=scalata.scalatore 
where scalata.anno-scalatore.annoNascita<40 and scalata.nazione=scalatore.nazioneNascita
GROUP BY scalatore,nazionenascita,nazione,scalatore.annoNascita, scalata.anno


select  scalatore.cf 
FROM scalatore join scalata on  scalatore.cf=scalata.scalatore 
where scalata.anno-scalatore.annoNascita<40 and scalata.nazione=scalatore.nazioneNascita
