{{ config(materialized='table') }}

select
    v.vendedor,
    t.gerente,
    t.escritorio,
    count(v.id_da_oportunidade) as total_oportunidades,
    sum(case when v.estagio_negociacao = 'ganho' then 1 else 0 end) as total_ganhos,
    sum(case when v.estagio_negociacao = 'perdido' then 1 else 0 end) as total_perdidos,
    sum(v.fechamento_valor) as receita_total
from u794777727_crm_pipeline.raw_vendas_pipeline v
join u794777727_crm_pipeline.raw_time_vendas t on v.vendedor = t.vendedor
group by v.vendedor, t.gerente, t.escritorio