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
        path "multiqc_data",        emit: data

    publishDir "$outputdir/qc", mode: "copy", overwrite: true

    script:
        """
        export TMPDIR=${workDir}
        multiqc ${multiqc_args} \\
            --outdir . \\
            --data-dir multiqc_data \\
            --filename multiqc_report.html \\
            .
        """
}

