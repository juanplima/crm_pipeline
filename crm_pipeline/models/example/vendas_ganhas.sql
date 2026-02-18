{{ config(materialized='table') }}
select
    v.id_da_oportunidade,
    v.vendedor,
    v.conta,
    v.produto,
    v.fechamento_valor,
    v.data_fechamento,
    a.setor,
    a.localizacao
from u794777727_crm_pipeline.raw_vendas_pipeline v
join u794777727_crm_pipeline.raw_accounts a on v.conta = a.conta
where v.estagio_negociacao = 'ganho'