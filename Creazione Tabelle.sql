create database CarrozzeriaDemo;
use CarrozzeriaDemo;

create table Cliente
(
    CodiceID        varchar(11) primary key,
    Nome            varchar(20) not null,
    Cognome        	varchar(20) not null,
    RagioneSociale 	varchar(20),
    Tipo 			varchar(7)   not null
        check ( Tipo in ('Azienda', 'Privato') )
);
/* Gli unici due tipi permessi nei “clienti” sono “Azienza” e “Privato” */

create table Veicolo
(
    Targa           varchar(6) primary key,
    Cliente    	    varchar(11)      not null,
    NumDiTelaio 	varchar(17)      not null,
    Tipo        	varchar(20)      not null
        check (Tipo in ('Automobile', 'Moto', 'Furgone')),
    constraint FK_veicolo
        foreign key (Cliente) references Cliente(CodiceID)
        on delete cascade on update cascade
);
/* Gli unici due tipi permessi nei “Veicoli” sono “Automobile”, “Moto” e “Furgone” */


create table Preventivo
(
    NumeroSinistro 	    int     auto_increment,
    Cliente         	varchar(11)   not null,
    TempoStimato    	int           not null,
    CostoStimato    	int    		  not null,
    Assicurazione   	boolean    	  not null,
    Approvato       	boolean,
    primary key (NumeroSinistro),
    constraint FK_preventivo
        foreign key (Cliente) references cliente(CodiceID)
        on delete cascade on update cascade
);

create table Riparazione
(
    Preventivo      int           unique,
    Veicolo        	varchar(11),
    TempoEffettivo 	int         not null,
    CostoEffettivo 	int         not null,
    Tipo 			varchar(10) not null
        check ( Tipo in ('Meccanica', 'Verniciatura', 'Entrambe') ),
    primary key (Preventivo,Veicolo),
    constraint FK_riparazione1
        foreign key (Preventivo) references Preventivo(NumeroSinistro)
        on delete cascade on update cascade,
    constraint FK_riparazione2
        foreign key (Veicolo) references veicolo(Targa)
        on delete cascade on update cascade
);

create table PezziDiRicambio
(
    Codice	    int,
    Preventivo	int,
    Costo      	int         not null,
    Tipo      	varchar(20) not null,
    Quantità 	int         not null,
    primary key (Codice,Preventivo),
    constraint FK_pezzidiricambio
        foreign key (Preventivo) references preventivo (NumeroSinistro)
        on delete cascade on update cascade
);

create table FattureAttive
(
    NumSinistro 	int 	 primary key,
    Cliente     	varchar(11) not null,
    Iban        	varchar(27) not null,
    Prezzo     	    int         not null,
    Data       	    date        not null,
    Pagato      	boolean     not null,
    constraint FK_fattureattive2
        foreign key (Cliente) references cliente (CodiceID)
        on delete cascade on update restrict
);

create table Fornitori
(
    PartitaIVA    	varchar(11) primary key,
    RagioneSociale 	varchar(20)	   not null
);
create table Merce
(
    Codice         		int,
    DataDiAcquisto 	    date,
    Fornitore      		varchar(11),
    Costo         		int         not null,
    Quantità       		int         not null,
    Tipo           		varchar(20) not null
        check ( Tipo in ('Attrezzatura', 'Materiale da consumo') ),
    primary key (Codice,DataDiAcquisto),
    constraint FK_merce
        foreign key (Fornitore) references fornitori (PartitaIVA)
        on delete set null on update cascade
);
/* Gli unici due tipi permessi nella “Merce” sono “Attrezzatura” e “Materiali da consumo” */

create table Dipendenti
(
    CartaIdentità  varchar(9)  primary key,
    Nome           varchar(20) 	  not null,
    Cognome        varchar(20) 	  not null,
    Iban           varchar(27) 	  not null,
    DataDiNascita  date 	      not null
);


create table Stipendio
(
    Dipendente	varchar(9),
    Data        date,
    OreDiLavoro int  not null,
    primary key (Dipendente, Data),
    constraint FK_stipendio
        foreign key (Dipendente) references dipendenti (CartaIdentità)
            on delete cascade on update cascade
);

create table FatturePassive
(
    NumFattura   int     auto_increment primary key,
    Emittente    varchar(11)               not null,
    Iban         varchar(27)               not null,
    Prezzo       int                   	   not null,
    Data	     date                      not null,
    Pagato       boolean                   not null,
    constraint FK_fatturepassive
        foreign key (Emittente) references fornitori(PartitaIVA)
        on delete cascade on update restrict
);

