{{ config(materialized='table') }}

select
    t.gerente,
    t.escritorio,
    count(v.id_da_oportunidade) as total_oportunidades,
    sum(case when v.estagio_negociacao = 'ganho' then 1 else 0 end) as total_ganhos,
    round(sum(v.fechamento_valor), 2) as receita_total,
    round(sum(case when v.estagio_negociacao = 'ganho' then 1 else 0 end) * 100.0 
        / count(v.id_da_oportunidade), 2) as taxa_conversao_pct
from u794777727_crm_pipeline.raw_vendas_pipeline v
join u794777727_crm_pipeline.raw_time_vendas t on v.vendedor = t.vendedor
group by t.gerente, t.escritorio
order by receita_total desc