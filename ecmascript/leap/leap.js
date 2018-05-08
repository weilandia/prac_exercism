export default class Year {
  constructor(year) {
    this.year = year;
  }

  isLeap() {
    if (this.year % 4 === 0) {
      if (this.year % 400 !== 0 && this.year % 100 === 0) {
        return false;
      }
      return true;
    }

    return false;
  }
}
