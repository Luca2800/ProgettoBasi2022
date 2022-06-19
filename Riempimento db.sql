use carrozzeriademo;

/* Riepimento tabella Cliente */

insert into cliente
values ('111111111','Fabio','Rossi',null, 'Privato');

insert into cliente
values ('111111112','Gianfranco','Bianchi',null, 'Privato');

insert into cliente
values ('111111113','Paolo','Verdi','Verdi snc', 'Azienda');

select * from cliente;

/* Riepimento tabella veicolo */

insert into veicolo
values ('abcde', '111111111','aaaaaaaaaaaaaaaa', 'automobile');

insert into veicolo
values ('fghi', '111111113' ,'bbbbbbbbbbbbbbbb', 'Furgone');

select * from veicolo;

/* Riepimento tabella dipendenti */

insert into dipendenti
values ('222222222','Gianni','Rossi','aaaabbbbccccdddd',20000222);

insert into dipendenti
values ('222222223','Vincenzo','Viola', 'aaaaccccdddggg',19990301);

select * from dipendenti;

/* Riepimento tabella Stipendio */

insert into stipendio
values (222222222,20220430,140);

insert into stipendio
values (222222222,20220331,140);

insert into stipendio
values (222222223,20220430,100);

insert into stipendio
values (222222223,20220331,110);

select * from stipendio;

/* Riempimento tabella Preventivo */

insert into preventivo
values (null,'111111111', 20, 3000, 1, 1 );

insert into preventivo
values (null,'111111113', 10, 100, 0, 1 );

select * from preventivo;

/*Riempimento tabella riparazione*/

insert into riparazione
values (1,'abcde',20,2800,'entrambe');

insert into riparazione
values (2,'fghi',2,100,'entrambe');

select * from riparazione;

/*Riempimento tabella pezzi di ricambio*/

insert into pezzidiricambio
values (01,1,100,'Parabrezza',1);

insert into pezzidiricambio
values (02,1,200,'Cofano',1);

insert into pezzidiricambio
values (01,2,100,'Parabrezza',1);

insert into pezzidiricambio
values (04,2,50,'Specchio retrovisore',2);

select * from pezzidiricambio;

/*Riempimento tabella Fornitori*/

insert into fornitori
values ('0001','Macchine srl');

insert into fornitori
values ('0002', 'Vernici snc');

select * from fornitori;

/*Riempimento tabella Merce*/

insert into merce
values (001, 20220604, '0001', 200, 4,'Materiale da consumo');

insert into merce
values (002, 20220603, '0001', 30, 20,'Materiale da consumo');

insert into merce
values (003, 20220603, '0002', 5000, 1,'Attrezzatura');

select * from merce;

/*Riempimento tabella Fatture attive*/

insert into fattureattive
values (01,'111111111','aaaaaaaaaaaaa',2800,20220501,1);

insert into fattureattive
values (02,'111111113','bbbbbbbbbbb',100,20220422,0);

select * from fattureattive;

/*Riempimento tabella Fatture Passive*/

insert into fatturepassive
values (null,'0001','cccccccccccc',1800,20220630,1);

select * from fatturepassive;