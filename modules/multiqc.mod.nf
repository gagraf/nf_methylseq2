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
        path "multiqc_report_data", emit: raw   // <--- updated to match MultiQC output

    publishDir "$outputdir/qc",
        mode: "copy",
        overwrite: true

    script:
        """
        export TMPDIR=${workDir}

        # Run MultiQC
        multiqc ${multiqc_args} --filename multiqc_report.html -o .
        """
}


