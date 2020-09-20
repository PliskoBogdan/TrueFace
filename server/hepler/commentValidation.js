const Comment = require('../models/ProfileComments');

module.exports.commentValidation = async function(req, res){
    const comments = await Comment.find({userId: req.body.userId})
   

    console.log(comments);
    if(comments.length !== 0){
        try{
            let validComments = comments.sort((prev, next) => prev.commentData - next.commentData).reverse(); 
            res.status(200).json({
                commentsList: validComments
            })
        }catch(err){
            console.log(err);
        }
    }else{
        res.status(404).json({
            commentsList: comments
        })
    }
    
}