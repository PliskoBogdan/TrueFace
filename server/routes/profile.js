const express = require("express");
const router = express.Router();
const authMiddleware = require('../middleware/auth');
const uploadImg = require('../controllers/uploads');
const addUserInfo = require('../middleware/addUserInfo');
const addNewComment = require('../middleware/addComment');
const commentsList = require('../hepler/commentValidation');
 
//routes
router.post('/', commentsList.commentValidation)
router.post('/bio',uploadImg.single('image'), authMiddleware, addUserInfo.updateUserInfo);
router.post('/addComment', authMiddleware, addNewComment.addComment)

module.exports = router;    