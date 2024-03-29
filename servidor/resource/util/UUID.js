class UUID {
  crypto = require('crypto');

  constructor() {}

  generate() {
    let uuid = "";

    for(let x = 0; x < 5; x++) {
      let r  = '';
      let rs = [];

      switch (x) {
        case 0:
          rs = this.crypto.randomBytes(4); break;
        case 1:
        case 2:
        case 3:
          rs = this.crypto.randomBytes(2); break;
        case 4:
          rs = this.crypto.randomBytes(6); break;
      }

      for(let _r of rs) r += (`00${_r.toString(16)}`).slice(-2);
      if (x == 0) uuid += `${r}`;
      else        uuid += `-${r}`;
    }

    return uuid;
  }

  static instance() {
    return new UUID();
  }
}

module.exports = UUID;