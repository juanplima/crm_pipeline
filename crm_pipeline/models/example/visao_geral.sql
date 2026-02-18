{{ config(materialized='table') }}

select
    count(id_da_oportunidade) as total_oportunidades,
    sum(case when estagio_negociacao = 'ganho' then 1 else 0 end) as total_ganhos,
    sum(case when estagio_negociacao = 'perdido' then 1 else 0 end) as total_perdidos,
    sum(case when estagio_negociacao = 'prospeccao' then 1 else 0 end) as em_prospeccao,
    sum(case when estagio_negociacao = 'engajamento' then 1 else 0 end) as em_engajamento,
    round(sum(fechamento_valor), 2) as receita_total,
    round(avg(fechamento_valor), 2) as ticket_medio,
    round(sum(case when estagio_negociacao = 'ganho' then 1 else 0 end) * 100.0 
        / count(id_da_oportunidade), 2) as taxa_conversao_pct
from u794777727_crm_pipeline.raw_vendas_pipeline