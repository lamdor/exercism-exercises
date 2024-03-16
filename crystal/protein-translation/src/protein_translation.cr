module ProteinTranslation
  def self.proteins(strand : String) : Array(String)
    protein = [] of String

    start = 0
    while start < strand.size()
      codon = strand[start, 3]

      break if STOP_CODONS.includes?(codon)

      amino_acid = amino_acid_for_codon(codon)
      if amino_acid
        protein << amino_acid
      else
        raise ArgumentError.new("Invalid Codon ${codon}")
      end

      start += 3
    end

    return protein
  end

  CODONS_TO_AMINO_ACID = {
    %w(AUG) =>              "Methionine",
    %w(UUU UUC) =>	        "Phenylalanine",
    %w(UUA UUG) =>	        "Leucine",
    %w(UCU UCC UCA UCG) =>	"Serine",
    %w(UAU UAC) =>	        "Tyrosine",
    %w(UGU UGC) =>	        "Cysteine",
    %w(UGG) =>	            "Tryptophan"
  }

  STOP_CODONS = %w(
    UAA UAG UGA
  )

  private def self.amino_acid_for_codon(codon : String) : String | Nil
    CODONS_TO_AMINO_ACID.each do |codons, amino_acid|
      return amino_acid if codons.includes?(codon)
    end
  end
end
