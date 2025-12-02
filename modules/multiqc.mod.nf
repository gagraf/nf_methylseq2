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
        path "*html", emit: html
        path "multiqc_data", emit: raw   // <--- add this
        path "multiqc.log", emit: log    // <--- optional but useful

    publishDir "$outputdir/qc",
        mode: "link",
        overwrite: true,
        pattern: "*html|multiqc_data|multiqc.log"  // <--- publish the raw outputs

    script:
        """
        export TMPDIR=${workDir}
        multiqc ${multiqc_args} --filename multiqc_report.html .
        """
}
