class Pangram {
  constructor(sentence) {
    this.sentence = sentence;
  }

  isPangram() {
    const uniqLetters = this.sentence.match(/([a-z])(?!.*\1)/ig) || [];
    return uniqLetters.length === 26;
  }
}

export default Pangram;
