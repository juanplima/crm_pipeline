{{ config(materialized='table') }}

select
    date_format(data_fechamento, '%Y-%m') as ano_mes,
    count(id_da_oportunidade) as total_oportunidades,
    sum(case when estagio_negociacao = 'ganho' then 1 else 0 end) as total_ganhos,
    round(sum(fechamento_valor), 2) as receita_total,
    round(avg(datediff(data_fechamento, data_de_engajamento)), 0) as dias_medio_fechamento
from u794777727_crm_pipeline.raw_vendas_pipeline
where data_fechamento is not null
group by date_format(data_fechamento, '%Y-%m')
order by ano_mes