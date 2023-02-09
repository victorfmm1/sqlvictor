/*usar apenas o fio B para apresentar a proposta, sendo a % do ano +*/
with v as (
    select

    (fvt.consumo_janeiro * fvt.tarifa_energia) as jan_consumo,
--    ((select geracao from fvt_geracao_mensal (fvt.id) where mes = 'JAN') * (fvt.tarifa_energia + (0.3 * 0.15))) as jan_pot,
--    ((select geracao from fvt_geracao_mensal (fvt.id) where mes = 'JAN') * (0.3 * 0.15)) as jan_semtx,
    ((select geracao from fvt_geracao_mensal (fvt.id) where mes = 'JAN') * (1-0.3)*(0.05)) as jan_ano1,
    ((select geracao from fvt_geracao_mensal (fvt.id) where mes = 'JAN') * (1-0.3)*(0.10)) as jan_ano2,

    (fvt.consumo_fevereiro * fvt.tarifa_energia) as fev_consumo,
    ((select geracao from fvt_geracao_mensal (fvt.id) where mes = 'FEV') * fvt.tarifa_energia) as fev_pot,
    ((select geracao from fvt_geracao_mensal (fvt.id) where mes = 'FEV') * (0.48)*(0.05)) as fev_teste,

    (fvt.consumo_marco * fvt.tarifa_energia) as mar_consumo,
    ((select geracao from fvt_geracao_mensal (fvt.id) where mes = 'MAR') * fvt.tarifa_energia) as mar_pot,

    (fvt.consumo_abril * fvt.tarifa_energia) as abril_consumo,
    ((select geracao from fvt_geracao_mensal (fvt.id) where mes = 'ABR') * fvt.tarifa_energia) as abril_pot,

    (fvt.consumo_maio * fvt.tarifa_energia) as maio_consumo,
    ((select geracao from fvt_geracao_mensal (fvt.id) where mes = 'MAI') * fvt.tarifa_energia) as maio_pot,

    (fvt.consumo_junho * fvt.tarifa_energia) as jun_consumo,
    ((select geracao from fvt_geracao_mensal (fvt.id) where mes = 'JUN') * fvt.tarifa_energia) as JUN_pot,

    (fvt.consumo_julho * fvt.tarifa_energia) as jul_consumo,
    ((select geracao from fvt_geracao_mensal (fvt.id) where mes = 'JUL') * fvt.tarifa_energia) as JUL_pot,

    (fvt.consumo_agosto * fvt.tarifa_energia) as ago_consumo,
    ((select geracao from fvt_geracao_mensal (fvt.id) where mes = 'AGO') * fvt.tarifa_energia) as AGO_pot,

    (fvt.consumo_setembro * fvt.tarifa_energia) as set_consumo,
    ((select geracao from fvt_geracao_mensal (fvt.id) where mes = 'SET') * fvt.tarifa_energia) as SET_pot,

    (fvt.consumo_outubro * fvt.tarifa_energia) as out_consumo,
    ((select geracao from fvt_geracao_mensal (fvt.id) where mes = 'OUT') * fvt.tarifa_energia) as OUT_pot,

    (fvt.consumo_novembro * fvt.tarifa_energia) as nov_consumo,
    ((select geracao from fvt_geracao_mensal (fvt.id) where mes = 'NOV') * fvt.tarifa_energia) as NOV_pot,

    (fvt.consumo_dezembro * fvt.tarifa_energia) as dez_consumo,
    ((select geracao from fvt_geracao_mensal (fvt.id) where mes = 'DEZ') * fvt.tarifa_energia) as DEZ_pot

    from
    fvt_dimensionamento fvt
    where fvt.id = :id
)

select
    V.jan_ano1,
    V.jan_ano2,
    cast(round((100-((v.jan_ano1) / jan_consumo)),1) as decimal(12,2)) as resultado_janeiro,
    cast(round((100-((v.jan_semtx) / jan_consumo)),1) as decimal(12,2)) as resultado_janeiro,
    cast(round((100-((v.fev_pot) / jan_consumo)),1) as decimal(12,2)) as resultado_fevereiro,
    cast(round((100-((v.mar_pot) / mar_consumo)),1) as decimal(12,2)) as resultado_marco,
    cast(round((100-((v.abril_pot) / abril_consumo)),1) as decimal(12,2)) as resultado_abril,
    cast(round((100-((v.maio_pot) / maio_consumo)),1) as decimal(12,2)) as resultado_maio,
    cast(round((100-((v.jun_pot) / jun_consumo)),1) as decimal(12,2)) as resultado_junho,
    cast(round((100-((v.jul_pot) / jul_consumo)),1) as decimal(12,2)) as resultado_julho,
    cast(round((100-((v.ago_pot) / ago_consumo)),1) as decimal(12,2)) as resultado_agosto,
    cast(round((100-((v.set_pot) / set_consumo)),1) as decimal(12,2)) as resultado_setembro,
    cast(round((100-((v.out_pot) / out_consumo)),1) as decimal(12,2)) as resultado_outubro,
    cast(round((100-((v.nov_pot) / nov_consumo)),1) as decimal(12,2)) as resultado_novembro,
    cast(round((100-((v.dez_pot ) / dez_consumo)),1) as decimal(12,2)) as resultado_dezembro

from v
