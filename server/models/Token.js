const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const TokenSchema =  new Schema({
    tokenId: String,
    userId: String,
    tokenTime: { type : Date, default: Date.now },
   

})

const Token = mongoose.model('Token', TokenSchema);
module.exports = Token;