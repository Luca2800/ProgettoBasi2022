/* Trigger */

/* Un dipendente per essere assunto deve essere maggiorenne */

use carrozzeriademo;

create trigger DipendMaggiorenni
    before insert on dipendenti for each row
    begin
        if year(NEW.DataDiNascita) > year(current_date)-18 then signal sqlstate '25555'
        set message_text = 'Il dipendente deve essere maggiorenne';
        end if;
    end;

/* Non posso inserire una fattura attiva che non ha un numero di sinistro corrispondente nelle riparazioni */

create trigger ControllaNumSinistro
    before insert on fattureattive for each row
    begin
        if NEW.NumSinistro not in (select Preventivo from riparazione where Preventivo = new.NumSinistro)
            then signal sqlstate '25556' set message_text = 'Non esiste il num sinistro';
        end if;
    end;


/* Il “prezzo” delle fatture attive deve essere uguale a quello del “costo effettivo”
   della riparazione con lo stesso “N° sinistro”
   (Ho creato un SP per facilitare la realizzazione del trigger) */

create procedure trovaPrezzo(
        in numSin int,
        out prz int)
begin
    select CostoEffettivo into prz from riparazione where numSin = Preventivo;
end;

create trigger ControlloPrezzo
    before insert on fattureattive for each row
    begin
        call trovaPrezzo(new.NumSinistro,@prz);
        if NEW.Prezzo != (select @prz) then signal sqlstate '25556' set message_text = 'Errore nel prezzo';
        end if;
    end;

/* Il “prezzo” delle fatture passive dei fornitori invece deve coincidere con la “costo” della merce acquistata nel “mese” corrispondente a quando è stata emessa la fattura
(Ho creato un SP per facilitare la realizzazione del trigger) */

create procedure trovaCosto(
        in prtIVA varchar(11),
        in Dat int,
        out cost int)
begin
    select sum(Quantità*Costo) into cost from merce
    where prtIVA = Fornitore and Dat = MONTH(DataDiAcquisto);
end;

create trigger ControlloCosto
    before insert on fatturepassive for each row
    begin
        call trovaCosto(NEW.Emittente, MONTH(NEW.Data), @costo);
        if NEW.Prezzo != (select @costo) then signal sqlstate '25556' set message_text = 'Errore nel prezzo';
        end if;
    end;


/* L’attributo “Assicurazione” deve essere “sì” solamente se il cliente è privato */

create trigger ControllaAssicur
    before insert on preventivo for each row
    begin
        if NEW.Assicurazione = 1 and (select tipo from cliente where NEW.Cliente = CodiceID) = 'Azienda'
        then signal sqlstate '25557' set message_text = 'Errore nella assicurazione';
        end if;
    end;

/* Un cliente per avere una ragione sociale deve per forza essere di tipo azienda */

create trigger ControlloRagSoc
    before insert on cliente for each row
    begin
        if NEW.Tipo = 'Privato' and new.RagioneSociale is not null
        then signal sqlstate '25557' set message_text = 'Errore nella Ragione sociale';
        end if;
    end;


