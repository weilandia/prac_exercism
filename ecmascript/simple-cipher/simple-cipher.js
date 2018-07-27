const ALPHABET = 'abcdefghijklmnopqrstuvwxyz';

const generateRandomKey = (length = 100) => {
  let key = '';

  for (let i = 0; i <= length; i += 1) {
    const idx = Math.floor(Math.random() * ALPHABET.length);
    key += ALPHABET.charAt(idx);
  }

  return key;
};

const shiftText = (text, key, shiftFunc) => {
  let result = '';

  for (let i = 0; i < text.length; i += 1) {
    const charIdx = ALPHABET.indexOf(text[i]);
    const keyIdx = ALPHABET.indexOf(key[i % key.length]);
    const shiftIdx = shiftFunc(charIdx, keyIdx) % (ALPHABET.length);

    result += ALPHABET[shiftIdx];
  }

  return result;
};

const charEncode = (n1, n2) => n1 + n2;

const charDecode = (n1, n2) => {
  if (n1 > n2) {
    return n1 - n2;
  }

  return (ALPHABET.length + n1) - n2;
};

const invalidKey = key => typeof key !== 'string' || key.length < 1 || key.match(/[^a-z]/);

class Cipher {
  constructor(key = generateRandomKey()) {
    this.key = key;

    if (invalidKey(this.key)) {
      throw new Error('Bad key');
    }
  }

  encode(message) {
    return shiftText(message, this.key, charEncode);
  }

  decode(encoding) {
    return shiftText(encoding, this.key, charDecode);
  }
}

export default Cipher;
