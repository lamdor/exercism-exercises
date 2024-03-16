const codon_map: [string[], string][] = [
  [["AUG"], "Methionine"],
  [["UUU", "UUC"], "Phenylalanine"],
  [["UUA", "UUG"], "Leucine"],
  [["UCU", "UCC", "UCA", "UCG"], "Serine"],
  [["UAU", "UAC"], "Tyrosine"],
  [["UGU", "UGC"], "Cysteine"],
  [["UGG"], "Tryptophan"]
];

const stop_codons = ["UAA", "UAG", "UGA"];

const codon_to_amino_acid: { [key: string]: string } =
  codon_map.reduce((a, row) => {
    const [codons, amino_acid] = row;
    const cas: { [key: string]: string } = {};

    for (const codon of codons) {
      cas[codon] = amino_acid;
    }

    return { ...a, ...cas };

  }, {} as { [index: string]: string });

export function translate(sequence: string): string[] {

  const translated: string[] = [];

  for (let start = 0; start < sequence.length; start += 3) {
    const codon = sequence.substring(start, start + 3);

    if (stop_codons.includes(codon)) {
      break;
    } else if (codon in codon_to_amino_acid) {
      translated.push(codon_to_amino_acid[codon]);
    } else {
      throw `Invalid codon ${codon}`;
    }
  }

  return translated;
}
