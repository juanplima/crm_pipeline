{{ config(materialized='table') }}

select
    v.vendedor,
    count(v.id_da_oportunidade) as total_oportunidades,
    sum(case when v.estagio_negociacao = 'ganho' then 1 else 0 end) as ganhos,
    round(
        sum(case when v.estagio_negociacao = 'ganho' then 1 else 0 end) * 100.0 
        / count(v.id_da_oportunidade), 2
    ) as taxa_conversao_pct
from u794777727_crm_pipeline.raw_vendas_pipeline v
group by v.vendedor
order by taxa_conversao_pct desc