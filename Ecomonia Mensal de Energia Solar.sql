with v as (
    select

    ceiling((fvt.consumo_media * (fvt.tarifa_energia * 1.08))) as consumo_ano2,
    ceiling(((select geracao from fvt_geracao_mensal (fvt.id) where mes = 'MÉDIA') * (1-0.25)*(0.10))) as media_ano2,

    ceiling((fvt.consumo_media * (fvt.tarifa_energia * 1.19))) as consumo_ano3,
    ceiling(((select geracao from fvt_geracao_mensal (fvt.id) where mes = 'MÉDIA') * (1-0.25)*(0.15))) as media_ano3,

    ceiling((fvt.consumo_media * (fvt.tarifa_energia * 1.30))) as consumo_ano4,
    ceiling(((select geracao from fvt_geracao_mensal (fvt.id) where mes = 'MÉDIA') * (1-0.25)*(0.20))) as media_ano4,

    ceiling((fvt.consumo_media * (fvt.tarifa_energia * 1.44))) as consumo_ano5,
    ceiling(((select geracao from fvt_geracao_mensal (fvt.id) where mes = 'MÉDIA') * (1-0.25)*(0.25))) as media_ano5,

    ceiling((fvt.consumo_media * (fvt.tarifa_energia * 1.59))) as consumo_ano6,
    ceiling(((select geracao from fvt_geracao_mensal (fvt.id) where mes = 'MÉDIA') * (1-0.25)*(0.30))) as media_ano6,

    ceiling((fvt.consumo_media * (fvt.tarifa_energia * 1.75))) as consumo_ano7,
    ceiling(((select geracao from fvt_geracao_mensal (fvt.id) where mes = 'MÉDIA') * (1-0.25)*(0.30))) as media_ano7,

    ceiling((fvt.consumo_media * (fvt.tarifa_energia * 1.93))) as consumo_ano8,
    ceiling(((select geracao from fvt_geracao_mensal (fvt.id) where mes = 'MÉDIA') * (1-0.25)*(0.30))) as media_ano8,

    ceiling((fvt.consumo_media * (fvt.tarifa_energia * 2.12))) as consumo_ano9,
    ceiling(((select geracao from fvt_geracao_mensal (fvt.id) where mes = 'MÉDIA') * (1-0.25)*(0.32))) as media_ano9,

    (fvt.consumo_janeiro * fvt.tarifa_energia) as jan_consumo,
    ((select geracao from fvt_geracao_mensal (fvt.id) where mes = 'JAN') * (1-0.25)*(0.05)) as jan_ano1,

    (fvt.consumo_fevereiro * fvt.tarifa_energia) as fev_consumo,
    ((select geracao from fvt_geracao_mensal (fvt.id) where mes = 'FEV') * (1-0.25)*(0.05)) as fev_ano1,

    (fvt.consumo_marco * fvt.tarifa_energia) as mar_consumo,
    ((select geracao from fvt_geracao_mensal (fvt.id) where mes = 'MAR') * (1-0.25)*(0.05)) as mar_ano1,

    (fvt.consumo_abril * fvt.tarifa_energia) as abril_consumo,
    ((select geracao from fvt_geracao_mensal (fvt.id) where mes = 'ABR')* (1-0.25)*(0.05)) as abr_ano1,

    (fvt.consumo_maio * fvt.tarifa_energia) as maio_consumo,
    ((select geracao from fvt_geracao_mensal (fvt.id) where mes = 'MAI') * (1-0.25)*(0.05)) as mai_ano1,

    (fvt.consumo_junho * fvt.tarifa_energia) as jun_consumo,
    ((select geracao from fvt_geracao_mensal (fvt.id) where mes = 'JUN') * (1-0.25)*(0.05)) as jun_ano1,

    (fvt.consumo_julho * fvt.tarifa_energia) as jul_consumo,
    ((select geracao from fvt_geracao_mensal (fvt.id) where mes = 'JUL') * (1-0.25)*(0.05)) as jul_ano1,

    (fvt.consumo_agosto * fvt.tarifa_energia) as ago_consumo,
    ((select geracao from fvt_geracao_mensal (fvt.id) where mes = 'AGO') * (1-0.25)*(0.05)) as ago_ano1,

    (fvt.consumo_setembro * fvt.tarifa_energia) as set_consumo,
    ((select geracao from fvt_geracao_mensal (fvt.id) where mes = 'SET') * (1-0.25)*(0.05)) as sete_ano1,

    (fvt.consumo_outubro * fvt.tarifa_energia) as out_consumo,
    ((select geracao from fvt_geracao_mensal (fvt.id) where mes = 'OUT') * (1-0.25)*(0.05)) as out_ano1,

    (fvt.consumo_novembro * fvt.tarifa_energia) as nov_consumo,
    ((select geracao from fvt_geracao_mensal (fvt.id) where mes = 'NOV') * (1-0.25)*(0.05)) as nov_ano1,

    (fvt.consumo_dezembro * fvt.tarifa_energia) as dez_consumo,
    ((select geracao from fvt_geracao_mensal (fvt.id) where mes = 'DEZ') * (1-0.25)*(0.05)) as dez_ano1

    from
    fvt_dimensionamento fvt
    where fvt.id = :id
)

select
     jan_ano1,
     fev_ano1,
     mar_ano1,
     abr_ano1,
     mai_ano1,
     jun_ano1,
     jul_ano1,
     ago_ano1,
     sete_ano1,
     out_ano1,
     nov_ano1,
     dez_ano1,
    (media_ano2 + (media_ano2 * 0.45)) as media_ano2,
    consumo_ano2,
    (media_ano3 * 1.49) as media_ano3,
    consumo_ano3,
    (media_ano4 * 1.64)media_ano4,
    consumo_ano4,
    (media_ano5 * 1.8)media_ano5,
    consumo_ano5,
    (media_ano6 * 2)media_ano6,
    consumo_ano6,
    (media_ano7 * 2.21)media_ano7,
    consumo_ano7,
    (media_ano8 * 2.42)media_ano8,
    consumo_ano8,
    (media_ano9 * 2.51)media_ano9,
    consumo_ano9,
    cast(round((100-((v.jan_ano1*100) / jan_consumo)),1) as decimal(12,2)) as resultado_janeiro,
    cast(round((100-((v.fev_ano1*100) / jan_consumo)),1) as decimal(12,2)) as resultado_fevereiro,
    cast(round((100-((v.mar_ano1*100) / mar_consumo)),1) as decimal(12,2)) as resultado_marco,
    cast(round((100-((v.abr_ano1*100) / abril_consumo)),1) as decimal(12,2)) as resultado_abril,
    cast(round((100-((v.mai_ano1*100) / maio_consumo)),1) as decimal(12,2)) as resultado_maio,
    cast(round((100-((v.jun_ano1*100) / jun_consumo)),1) as decimal(12,2)) as resultado_junho,
    cast(round((100-((v.jul_ano1*100) / jul_consumo)),1) as decimal(12,2)) as resultado_julho,
    cast(round((100-((v.ago_ano1*100) / ago_consumo)),1) as decimal(12,2)) as resultado_agosto,
    cast(round((100-((v.sete_ano1*100) / set_consumo)),1) as decimal(12,2)) as resultado_setembro,
    cast(round((100-((v.out_ano1*100) / out_consumo)),1) as decimal(12,2)) as resultado_outubro,
    cast(round((100-((v.nov_ano1*100) / nov_consumo)),1) as decimal(12,2)) as resultado_novembro,
    cast(round((100-((v.dez_ano1*100) / dez_consumo)),1) as decimal(12,2)) as resultado_dezembro,
    cast(round((100-((media_ano2*100) / consumo_ano2)),1) as decimal(12,2)) as resultado_ano2,
    cast(round((100-((media_ano3*100) / consumo_ano3)),1) as decimal(12,2)) as resultado_ano3,
    cast(round((100-((media_ano4*100) / consumo_ano4)),1) as decimal(12,2)) as resultado_ano4,
    cast(round((100-((media_ano5*100) / consumo_ano5)),1) as decimal(12,2)) as resultado_ano5,
    cast(round((100-((media_ano6*100) / consumo_ano6)),1) as decimal(12,2)) as resultado_ano6,
    cast(round((100-((media_ano7*100) / consumo_ano7)),1) as decimal(12,2)) as resultado_ano7,
    cast(round((100-((media_ano8*100) / consumo_ano8)),1) as decimal(12,2)) as resultado_ano8,
    cast(round((100-((media_ano9*100) / consumo_ano9)),1) as decimal(12,2)) as resultado_ano9,
    jan_consumo,
    fev_consumo,
    mar_consumo,
    abril_consumo,
    maio_consumo,
    jun_consumo,
    jul_consumo,
    ago_consumo,
    set_consumo,
    out_consumo,
    nov_consumo,
    dez_consumo

from v
