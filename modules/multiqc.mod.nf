#!/usr/bin/env nextflow
nextflow.enable.dsl=2

process MULTIQC {

    label 'multiQC'
    container 'docker://josousa/multiqc:1.22.3'

    input:
        path(file)
        val(outputdir)
        val(multiqc_args)

    output:
        path "multiqc_report.html", emit: html
        path "multiqc_data", emit: raw
        path "multiqc.log", emit: log

    publishDir "$outputdir/qc",
        mode: "copy",
        overwrite: true

    script:
        """
        export TMPDIR=${workDir}

        # run MultiQC
        multiqc ${multiqc_args} --filename multiqc_report.html .

        # force multiqc_data and log into the process directory where NF can see them
        if [ -d multiqc_data ]; then
            echo "multiqc_data directory found"
        else
            echo "ERROR: multiqc_data directory not found"
            ls -A
        fi
        """
}

