rule dockq:
    input: 
        af3_msa_free_custom_template = rules.af3_workflow_AF3_INFERENCE.output.model
    output:
       touch("results/done.txt") 