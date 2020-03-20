version 1.0

task Index {
    input {
      File fasta
      Int preemptible_tries
    }

    Float ref_size = size(fasta, "GiB")
    Int disk_size = ceil(ref_size) * 2 + 20

    command {
        /opt/samtools/bin/samtools index ~{fasta}
    }

    output {
        File fasta_index = "~{fasta}.fai"
    }

    runtime {
        docker: "mgibio/samtools-cwl:1.0.0"
        memory: "4 GiB"
        disks: "local-disk " + disk_size + " HDD"
        preemptible: preemptible_tries
    }
}

workflow IndexWorkflow {
    input {
        File fasta
        Int preemptible_tries
    }

    call Index { 
      input: 
        fasta=fasta, 
        preemptible_tries=preemptible_tries
    }
}
