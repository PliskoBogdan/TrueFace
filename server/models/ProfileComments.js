const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const profileComment = new Schema({
    userId: {type: String},
    commentData: {type: String},
    commentatorName: {type: String},
    commentatorImage: {type: String},
    like: {type: String},
    dislike: {type: String},
    commentData: {type : Date, default: Date.now }
})

const Comment = mongoose.model('comments', profileComment);
module.exports = Comment;