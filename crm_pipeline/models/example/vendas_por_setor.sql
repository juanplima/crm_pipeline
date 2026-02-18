{{ config(materialized='table') }}

select
    a.setor,
    count(v.id_da_oportunidade) as total_oportunidades,
    sum(case when v.estagio_negociacao = 'ganho' then 1 else 0 end) as total_ganhos,
    round(sum(v.fechamento_valor), 2) as receita_total
from u794777727_crm_pipeline.raw_vendas_pipeline v
join u794777727_crm_pipeline.raw_accounts a on v.conta = a.conta
group by a.setor