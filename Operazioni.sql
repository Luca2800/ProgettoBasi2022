/* Operazioni */
/* Elimina tutti i preventivi rifiutati (batch) */
use carrozzeriademo;

set global event_scheduler = on;
create event EliminaPreventivi on schedule every '1' month
starts current_date do
begin
    delete from preventivo where Approvato = 0;
end;

/* Visualizza tutti i pezzi di ricambio per la automobile dato il numero di preventivo */

create procedure VeicoloEPezzi (in NumSin int)
begin
    select rip.Preventivo,Veicolo,Cliente,Codice,Costo,p.Tipo,Quantità from riparazione rip
    inner join preventivo prev on rip.Preventivo = prev.NumeroSinistro
    inner join pezzidiricambio p on rip.Preventivo = p.Preventivo
     where NumSin = rip.Preventivo;
end;

/* Trovare tutte le riparazioni che sono state eseguite su una automobile */

create procedure RiparazioniAuto (in targa varchar(6))
begin
    select * from riparazione where Veicolo = targa;
end;

/* Cerca tutte le fatture passive ancora da pagare */

create procedure FornitoriDaPagare()
begin
    select * from fatturepassive where Pagato = 0;
end;

/* Cerca tutte le fatture attive che non sono ancora state pagate dai clienti */

create procedure ClientiCheNonPagano()
begin
    select * from fattureattive where Pagato = 0;
end;

/* Trova tutti gli stipendi di un dipendente in un determinato periodo di tempo */

create procedure StipedioDipendente(
    in CI varchar(11),
    in datainizio date,
    in datafine date)
begin
    select dipendente, data, oredilavoro,( OreDiLavoro*8) as paga from stipendio
    where Dipendente = CI and Data<datafine and Data>datainizio;
end;

/* Operazione che calcola I’imposta sul valore aggiunto (IVA) data una fattura */

create procedure calcoloIva(
    in numSin int,
    out Iva double)
begin
    select Prezzo*(22/100) into Iva from fattureattive where NumSinistro=numSin;
end;



