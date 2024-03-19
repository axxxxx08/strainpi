if config["params"]["instrain"]["ref_single"]["do"]:
    rule single_instrain_profile:
        input:
            rules.raw_prepare_reads.output
        output:
            os.path.join(config["output"]["instrain"], "instrain_single/{sample}/{sample}.finished")
        log:
            os.path.join(config["output"]["instrain"], "logs/instrain_single/{sample}.log")
        benchmark:
            os.path.join(config["output"]["instrain"], "benchmark/instrain_single/{sample}.txt")
        params:
            bam_file = os.path.join(config["output"]["alignment"], "bam/bowtie2/{sample}/pe/sorted.bam"),
            profile_dir = os.path.join(config["output"]["instrain"], "instrain_single/{sample}"),
            stb_file = config["params"]["instrain"]["ref_database"]["scaffoletobin.stb"],
            index_prefix = config["params"]["instrain"]["index_prefix"]
        priority:
            10
        threads:
            config["params"]["instrain"]["threads"]
        conda:
            config["envs"]["instrain"]
        shell:
            '''
            inStrain profile \
            {params.bam_file} \
            {index_prefix} \
            -p {threads} \
            -o {params.profile_dir} \
            -s scaffoletobin.stb \
            --skip_plot_generation \
            2> {log}

            echo "instrain profile finished" > {output}
            '''


    rule single_instrain_profile_all:
        input:
            expand(os.path.join(config["output"]["instrain"], "instrain_single/{sample}/{sample}.finished"),
            sample=SAMPLES_ID_LIST)

else:
    rule single_instrain_profile_all:
        input:        

if config["params"]["instrain"]["ref_database"]["do"]:
    rule database_instrain_profile:
        input:
            rules.raw_prepare_reads.output
        output:
            os.path.join(config["output"]["instrain"], "instrain_refdb/{sample}/{sample}.finished")
        log:
            os.path.join(config["output"]["instrain"], "logs/instrain_refdb/{sample}.log")
        benchmark:
            os.path.join(config["output"]["instrain"], "benchmark/instrain_refdb/{sample}.txt")
        params:
            bam_file = os.path.join(config["output"]["alignment"], "bam/bowtie2/{sample}/pe/sorted.bam"),
            profile_dir = os.path.join(config["output"]["instrain"], "instrain_refdb/{sample}"),
            stb_file = config["params"]["instrain"]["ref_database"]["scaffoletobin.stb"],
            index_prefix = config["params"]["instrain"]["index_prefix"]
        priority:
            10
        threads:
            config["params"]["instrain"]["threads"]
        conda:
            config["envs"]["instrain"]
        shell:
            '''
            inStrain profile \
            {params.bam_file} \
            {index_prefix} \
            -p {threads} \
            -o {params.profile_dir} \
            --database_mode \
            -s scaffoletobin.stb \
            --skip_plot_generation \
            2> {log}

            echo "instrain profile finished" > {output}
            '''


    rule database_instrain_profile_all:
        input:
            expand(os.path.join(config["output"]["instrain"], "instrain_refdb/{sample}/{sample}.finished"),
            sample=SAMPLES_ID_LIST)

else:
    rule database_instrain_profile_all:
        input:
