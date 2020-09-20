const Comment = require('../models/ProfileComments');


module.exports.addComment = async function(req, res){
    const data = req.body.commentData;
        if(data.length === 0){
            res.status(406).json({message: "Field don't mast be empty"})
        }else if(data.length < 10){
            res.status(406).json({message: "Add more info in field"})
        }else{
            const addNewComment = new Comment({
                userId: req.body.userId,
                commentData: data,
                commentatorName: req.body.commentatorName,
                commentatorImage: req.body.commentatorImage,
                like: "",
                dislike: "",
                commentData: new Date()
            })
            
            try{
                await addNewComment.save()
                res.json({comment: addNewComment});
             }catch(err){
                 console.log(err);
             }
        }
}    



