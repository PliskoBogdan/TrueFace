const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const UserSchema =  new Schema({
    email:{
        type: String
    },
   
    password:{
        type: String
    },
    bio:{
        type: String,
        default: ""
    },
    name:{
        type: String,
        default: ""
    },
    nickname:{
        type: String,
        default: ""
    }
   
},{timestamps:true})

const User = mongoose.model('users', UserSchema);
module.exports = User;