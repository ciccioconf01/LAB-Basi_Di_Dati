select p.nomep,p.indirizzo,p.citta
from palestra p, lezione l
where l.codfiscale not in (
    select l1.codfiscale
    from lezione l1, specialita s
    where s.nomes<>'Yoga' and l1.cods=s.cods
)
and l.codp=p.codp
group by p.codp,p.nomep,p.indirizzo,p.citta
having count(p.codp)=(
    select Max(npalestre)
    from(select p.codp,p.nomep, Count(p.codp) as npalestre
        from lezione l, palestra p
        where l.codfiscale not in (
            select l.codfiscale
            from lezione l, specialita s
            where s.nomes<>'Yoga' and l.cods=s.cods
    )
    and l.codp=p.codp
    group by p.codp,p.nomep
)
)