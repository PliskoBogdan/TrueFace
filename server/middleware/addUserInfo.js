const User = require('../models/User')
const ProfileImg = require('../models/profileImg')
const jwt = require('jsonwebtoken')
const {secret} = require ('../config/keys').jwt;

module.exports.updateUserInfo = async function(req,res){
    const decodeId =  jwt.decode(req.headers.authorization,secret)   
    let userImg = null;
  try{
    //User Bio
    await User.findOneAndUpdate({_id:`${decodeId.userId}`},
    { $set: {
      "bio": req.body.bio || "",
      "name": req.body.name || "",
      "nickname": req.body.nickname || ""
    }},
    {
      returnNewDocument: true,
      strict: true,
    })
    //User Image
    if(req.file !== undefined){
      //create User Image
        userImg = new ProfileImg({
          imageSrc: req.file ? req.file.path : '',
          userId: `${decodeId.userId}`
        })       
        await userImg.save() 
    }     
    //Return:
    res.status(200).json({
      info:{
        bio: req.body.bio,
        name: req.body.name ,
        nickname: req.body.nickname 
      },
      image: userImg 
     
    })
  
    
  }catch(err){
    console.log(err);
  }

}

