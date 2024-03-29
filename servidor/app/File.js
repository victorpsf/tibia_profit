const BaseModelSql = require('./BaseModelSql');

class File extends BaseModelSql {
  table = 'file';

  fields = [
    'id',
    'name',
    'mimetype',
    'size',
    'binary',
    'created_at',
    'updated_at'
  ];

  encrypt = [];

  hash = [];

  timestamp = true;

  relation = {};

  constructor() { super(); }
}

module.exports = File;