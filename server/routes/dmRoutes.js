const express = require('express');
const router = express.Router();
const dmController = require('../controllers/dm_controller');
//const authMiddleware = require('../middlewares/authMiddleware');

router.post('/send' , authMiddleware, dmController.sendDM);
router.get('/messages', authMiddleware , dmController.getDMs);

module.exports = router;