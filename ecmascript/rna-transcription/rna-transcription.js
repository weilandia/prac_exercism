export default class Transcriptor {
  constructor() {
    this.key = {
      G: 'C',
      C: 'G',
      T: 'A',
      A: 'U',
    };
  }

  toRna(dna) {
    if (/[^GCTA]/.exec(dna)) {
      throw new Error('Invalid input DNA.');
    }

    return dna.split('')
      .map(nucleotide => this.key[nucleotide])
      .join('');
  }
}
