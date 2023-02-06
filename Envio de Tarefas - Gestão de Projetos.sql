with r as (
    select
        dime.id as dime_id,
        vend.parceiro as vendedor_id,
        rtrim(vend.celular) as vendedor_num,
        vend.nome as vendedor,
        parc.parceiro as parceiro_id, parc.nome as parceiro,
        pta.data_final,
        pta.data_alteracao as data_conclusao,
        pj.projeto_id, pj.dscprojeto,
        f.id as fase_id, f.fase,
        pjf.percentual_representacao,
        t.id as tarefa_id, t.tarefa,
        pjt.sequencia,
    
        pjt.id as projeto_tarefa_id,
        pta.operador as operador_id,
        ope.nome as operador,
        pta.responsavel as responsavel_id,
        resp.nome as responsavel,
        pta.id as apontamento_id,
        pta.idn_concluido, 
        pta.idn_reaberta,
        pta.enviar
    
    from projetos pj 
        left join fvt_dimensionamento dime on dime.id_projeto = pj.projeto_id
        left join projetos_fases pjf on pjf.id_projeto = pj.projeto_id
        left join fases f on f.id = pjf.id_fase
        left join projetos_tarefas pjt on pjt.id_projeto_fase = pjf.id
        left join tarefas t on t.id = pjt.id_tarefa
    --    left join tarefas_checklist tc on tc.id_tarefa = t.id
    --    left join os_check_list osc on osc.check_list = tc.id_checklist
    --    left join os_check_list_itens osci on osci.check_list = osc.check_list and osci.descricao_item = tc.id_checklist_descricao_item
    --    left join projetos_tarefas_check ptc on ptc.id_projeto_tarefa = pjt.id and ptc.id_check_list = osc.check_list and ptc.id_check_list_descricao_item = osci.descricao_item
        left join projetos_tarefas_apontamentos pta on pta.id_projeto_tarefa = pjt.id and pta.idn_concluido = true and pta.idn_reaberta = false
        left join operadores ope on ope.operador = pta.operador
        left join parceiros resp on resp.parceiro = pta.responsavel
        left join parceiros vend on vend.parceiro = dime.vendedor
        left join parceiros parc on parc.parceiro = dime.parceiro
)

select
    dime.id as dime_id,
    vend.parceiro as vendedor_id,
    rtrim(vend.celular) as send_to_num,
    vend.nome as vendedor,
    parc.parceiro as parceiro_id, parc.nome as parceiro,
    pta.data_final,
    pta.data_final as hora_final,
    pta.data_alteracao as data_conclusao,
    pj.projeto_id, pj.dscprojeto,
    f.id as fase_id, f.fase,
    pjf.percentual_representacao,
    t.id as tarefa_id, t.tarefa,
    pjt.sequencia,
    pjt.id as projeto_tarefa_id,
    pjt.percentual_representacao,
    pta.operador as operador_id,
    ope.nome as operador,
    pta.responsavel as responsavel_id,
    resp.nome as responsavel,
    pta.id as apontamento_id,
    pta.idn_concluido, 
    pta.idn_reaberta,
    pta.enviar

from projetos pj 
    left join fvt_dimensionamento dime on dime.id_projeto = pj.projeto_id
    left join projetos_fases pjf on pjf.id_projeto = pj.projeto_id
    left join fases f on f.id = pjf.id_fase
    left join projetos_tarefas pjt on pjt.id_projeto_fase = pjf.id
    left join tarefas t on t.id = pjt.id_tarefa
    left join projetos_tarefas_apontamentos pta on pta.id_projeto_tarefa = pjt.id and pta.idn_concluido = true and pta.idn_reaberta = false
    left join operadores ope on ope.operador = pta.operador
    left join parceiros resp on resp.parceiro = pta.responsavel
    left join parceiros vend on vend.parceiro = dime.vendedor
    left join parceiros parc on parc.parceiro = dime.parceiro

where
    pta.enviar = true and
    ((pta.enviado = false) or (pta.enviado is null)) and
    pta.idn_reaberta = false
