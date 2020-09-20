const User = require("../models/User");
const Token = require('../models/Token');
const {secret} = require('../config/keys').jwt;
const tokenLifeTime = require('../config/keys')
const authHelper = require('../hepler/authHelper');
const bcrypt = require('bcryptjs');
const jwt = require("jsonwebtoken");

const updateToken = (userId) =>{
    const accessToken = authHelper.generateAccessToken(userId);
    const refreshToken = authHelper.generateRefreshToken();

    return authHelper.replaceDbRefreshToken(refreshToken.id, userId)
        .then(()=>({
            accessToken: accessToken,
            refreshToken: refreshToken.token
        }))
}

module.exports.register = async function(req,res){
    const candidate = await User.findOne({email: req.body.email})    
    if(candidate){
        // have user
        res.status(409).json({
            message: `email ${req.body.email} already in use.`
        })
    }else {
        
        const salt = bcrypt.genSaltSync(10); // hesh for password
        const password = req.body.password;
        
     
        const user = new User({
            email: req.body.email,
            password: bcrypt.hashSync(password, salt)
        })

       try{
            await user.save();
            res.status(201).json(user)
       }
       catch(err){
            console.log(err);
       }
        
    }
}




module.exports.login = async function(req,res){
   const candidate = await User.findOne({email:req.body.email})
   if(candidate){
       //password verification
       console.log(candidate.body);
    const isValid = bcrypt.compareSync(req.body.password, candidate.password)
        if(isValid){
                updateToken(candidate._id)
                .then( tokens => res.json({
                    token: tokens,
                    userId: candidate._id,
                    userInfo: {
                        bio: candidate.bio || '',
                        name: candidate.name || '',
                        nickname: candidate.nickname || ''
                    },
                    tokenLifeTime: tokenLifeTime.jwt.tokens.access.expiresIn
                }))
                
           
           
        }else{
            res.status(401).json({
                error: {
                    message:  'Password is wrong.'
                }
            })
        }
   }else{
       res.status(404).json({
           error: {
               message: 'User with this email not found.'
           }
       })
   }
 }

 module.exports.refreshToken = async(req,res)=>{
     const {refreshToken} = req.body;
     let payload = null;
     try{
         payload = jwt.verify(refreshToken, secret)
         if(payload.type !== 'refresh'){
             res.status(400).json({message: 'Invalid token!'})
             return
         }
     }catch(e){
         if(e instanceof jwt.TokenExpiredError){
             res.status(400).json({message: 'Token expired!'});
             return
         }else if(e instanceof jwt.JsonWebTokenError){
             res.status(400).json({message: 'Invalid token'});
             return
         }
     }

    await Token.findOne({tokenId: payload.id})
        .exec()
        .then((token) =>{
            if(token === null){
                throw new Error('Invalid token!')
            }
            return updateToken(token.userId)
        })
        .then(tokens => res.json(tokens))
        .catch(err => res.status(400).json({message: err.message}));
 }