{{ config(materialized='table') }}

select
    p.produto,
    p.modelo,
    p.preco_venda,
    count(v.id_da_oportunidade) as total_oportunidades,
    sum(case when v.estagio_negociacao = 'ganho' then 1 else 0 end) as total_ganhos,
    round(sum(v.fechamento_valor), 2) as receita_total,
    round(sum(case when v.estagio_negociacao = 'ganho' then 1 else 0 end) * 100.0 
        / count(v.id_da_oportunidade), 2) as taxa_conversao_pct
from u794777727_crm_pipeline.raw_vendas_pipeline v
join u794777727_crm_pipeline.raw_produtos p on v.produto = p.produto
group by p.produto, p.modelo, p.preco_venda