# Run standard MSA free AF3 with custom template
# -----------------------------------------------------
rule simulate_reads:
    input:
        fasta=rules.validate_genome.output.fasta,
    output:
        multiext(
            "results/simulate_reads/{sample}",
            read1=".bwa.read1.fastq.gz",
            read2=".bwa.read2.fastq.gz",
        ),
    log:
        "results/simulate_reads/{sample}.log",
    conda:
        "../envs/simulate_reads.yaml"
    params:
        output_type=1,
        output_prefix=lambda wildcards, output: output.read1.rsplit(".", 4)[0],
        read_length=lookup(within=config, dpath="simulate_reads/read_length"),
        read_number=lookup(within=config, dpath="simulate_reads/read_number"),
    message:
        """--- Simulating read data with DWGSIM."""
    shell:
        "dwgsim "
        " -1 {params.read_length}"
        " -2 {params.read_length}"
        " -N {params.read_number}"
        " -o {params.output_type}"
        " {input.fasta}"
        " {params.output_prefix}"
        " > {log} 2>&1"
