const {secret, tokens} = require('../config/keys').jwt;
const Token = require('../models/Token')
const jwt = require('jsonwebtoken');
const { v4: uuidv4 } = require('uuid');


const generateAccessToken = (userId) => {
    const payload = {
        userId,
        type: tokens.access.type
    }

    const options = {expiresIn: tokens.access.expiresIn}
    return jwt.sign(payload,secret,options)
}

const generateRefreshToken = () => {
    const payload = {
        id: uuidv4(),
        type: tokens.refresh.type
    }
    const options = {expiresIn: tokens.refresh.expiresIn}

    return {
        id: payload.id,
        token: jwt.sign(payload,secret,options)
    }
}

const replaceDbRefreshToken = async (tokenId, userId) =>{
    let data = new Date();
   await Token.findOneAndRemove({userId})
        .exec()
        .then( async ()=>{
            const tok = new Token({tokenId,userId,data})
            try{
                await tok.save();
           }
           catch(err){
                console.log(err);
           }
        })
}

module.exports ={
    generateAccessToken,
    generateRefreshToken,
    replaceDbRefreshToken
}