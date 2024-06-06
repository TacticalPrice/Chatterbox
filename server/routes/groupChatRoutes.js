const express = require('express');
const router = express.Router();
const groupChatController = require('../controllers/group_chat_controller');
const authMiddleware = require('../middlewares/authMiddleware');

router.post('/create' , authMiddleware, groupChatController.createGroup);
router.post('/send' , authMiddleware, groupChatController.sendGroupMessage);
router.get('/message/:groupId' , authMiddleware, groupChatController.getGroupMessages);


module.exports = router;